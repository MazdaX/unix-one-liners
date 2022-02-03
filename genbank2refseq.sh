#!/bin/bash

#Scripts requires the following tools:
# Pigz
# wget
# Internet! :)

echo "This tools will rename chromsomes for ARS-UI_Ramb_v2.0 (genBank > RefSeq)"
echo "The link to assembly_report.txt is hard coded. Change it manually"
echo "Input the common suffix of your BED6 input files e.g. dmr.gz followed by [ENTER]:"
read JOB

#Downloading manifest from NCBI
echo "$(date) ===== Start..."
wget -q  https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/016/772/045/GCF_016772045.1_ARS-UI_Ramb_v2.0/GCF_016772045.1_ARS-UI_Ramb_v2.0_assembly_report.txt
echo "$(date) ===== Assembly report downloaded"
#Creating dictionary for Genbank\tRefSeq names
grep -v '#' GCF_016772045.1_ARS-UI_Ramb_v2.0_assembly_report.txt | cut -f5,7 | sed 's/na/CM028731.1/' | head -n -1 > dict
echo "$(date) ===== Processing input BED6 format file...";sleep 2

#Taking in files

files_array=(*$JOB)

for f in "${files_array[@]}";do 
	name=$(basename -s .dmr.gz $f)
	echo "$(date) ===== $name"
	#Reading every line in the dmr file as an array
	zcat $f | while read -ra LINE;do
			#First element of the array genbank chr
			chrom=${LINE[0]}
			#Finding the refseq match in the dictionary
			match=$(grep "$chrom" dict | cut -f2)
			#Reconstructing BED6 format for each line 
			printf '%s\t%s\t%s\t%s\t%s\t%s\n' "${match} ${LINE[@]:1}" >> ${name}.bed
		  done;
	echo "$(date) ===== Finished chr renaming for $name"
	echo "$(date) Gz compression."
	pigz ${name}.bed
done;

#GC
rm -f GCF_016772045.1_ARS-UI_Ramb_v2.0_assembly_report.txt dict
echo "$(date) ===== Finished with no errors."
