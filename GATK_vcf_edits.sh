#!/bin/bash
##==============================================================================##
##             			 VCF edits for GATK  		                ##
##             		                  					##
##                       Copyright (C) 2017  Dr.Mazdak Salavati	 	        ##
##++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++##
##  This program is free software: you can redistribute it and/or modify	##
##  it under the terms of the GNU General Public License as published by	##
##  the Free Software Foundation, either version 3 of the License, or		##
##  (at your option) any later version.						##
##  This program is distributed in the hope that it will be useful,		##
##  but WITHOUT ANY WARRANTY; without even the implied warranty of		##
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the		##
##  GNU General Public License for more details.				##
##										##
##  You should have received a copy of the GNU General Public License		##
##  along with this program.  If not, see <http://www.gnu.org/licenses/>. 	##
##==============================================================================##
## Using the Genome Analysis Toolkit pipeline and Ensmbl gene annotations I had to jump through many hoops.
## Beside unix tools you also need Samtools, Picard-tools and vcftools already compiled on your system
## I could have done the first step with GATK SelectVariant tools as well but vcftools runs faster than JAVA!!!
## Variant call foramt header composition was heavily affected by random flags from ENSEMBL and the VE was the most inportant one to keep. 
## I Kept dbSNP_148 version, TSA and VE (Consequence prediction). There are many more other flags in the header info region if necessary. 
## Last thing: Adjust the folder addresses and run these one by one (DO NOT RUN THIS SCRIPT AS IT IS)

# Separting indels (Insertion Deletion) from SNPs in VCF file
vcftools --gzvcf ../ref/Bos_taurus_incl_consequences.vcf.gz --remove-indels --recode --recode-INFO dbSNP_148 --recode-INFO TSA --recode-INFO VE --stdout | gzip -c @8 > ../ref/Ensmbl87_SNPs_Only.vcf.gz

# VCF header should be repaired for GATK 
# After editing the header using sed I had to recompress and index hence the pipe | and if successful && index : 
zcat ../ref/Ensmbl87_SNPs_Only.vcf.gz | sed '7i##INFO=<ID=VE,Number=1,Type=String,Description="Variant Effect prediction.">' | bgzip -c -@8 > ../ref/Ensmbl87_SNPs_VE.vcf.gz && tabix ../ref/Ensmbl87_SNPs_VE.vcf.gz

#Selecting only Bi-Allelic sites (Java capped RAM start 10G and maximum 25G useful flags) 
java -Xms10G -Xmx25G -jar ~/Progz/GATK/GenomeAnalysisTK.jar -T SelectVariants -R ../ref/UMD3.1.87.fa -V ../ref/Ensmbl87_SNPs_VE.vcf.gz -o ../ref/Ensmbl87_SNPs_VE_BIALLELIC.vcf -restrictAllelesTo BIALLELIC

#Compression and indexing of the final product before running the rest of GATK
bgzip -c -@8 ../ref/Ensmbl87_SNPs_VE_BIALLELIC.vcf > ../ref/Ensmbl87_SNPs_VE_BIALLELIC.vcf.gz && tabix ../ref/Ensmbl87_SNPs_VE_BIALLELIC.vcf.gz

#Finding the end of the header in VCFs
zcat Ensmbl87_SNPs_VE_BIALLELIC.vcf.gz| awk '$1 == "#CHROM" {print NR}'

#Script to edit the array of first two columns for repeated SNPs
#Or for that matter any repeated combinations that exists in two columns of any tabular file (strong AWK game :D )
zcat Ensmbl87_SNPs_VE_BIALLELIC.vcf.gz | awk '!seen[$1,$2]++ {print $0}' | bgzip -c -@8 > Ensmbl87_SNPs_VE_BIALLELIC_cleaned.vcf.gz

# And finally binary indexing the outcome (tabix also part of samtools)
tabix Ensmbl87_SNPs_VE_BIALLELIC_cleaned.vcf.gz   
