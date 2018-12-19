#!/bin/bash

#In the odd times that need be to pull out fastq format of a previously mapped BAM file using samtools, the following trick helps.
#Presence of following is necessary: 
# 1. samtools 1.6 and above (e.g. http://www.htslib.org/download/)
# 2. Pigz for multithreaded compressing (https://zlib.net/pigz/)

# for a scenario within which 8 cores are available:

for b in ./*.bam;do
	BAMNAME=$(dirname $b)
	samtools fastq -@8 $b | pigz -p 8 > ${BAMNAME}.fastq.gz
done;
