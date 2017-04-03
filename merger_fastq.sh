#!/bin/bash
##==============================================##
##              FastQ Merger (gz compressed)    ##
##              by                              ##
##              Dr.Mazdak Salavati              ##
##              29.03.2017                      ##
##==============================================##
# This is a solution to when you have the same library sequenced multiple times and you have to merge them. 
# Bare in mind the files should share a commong sample name to be used as a substring in find. 
# There is no need to zcat either as bgzip compression handles the output as it was: 
# Two .gz files glued to eachother file after another.

mkdir -p ./Merged;
for f in "./"*.fastq.gz;
	do
	#substring of file names ${f:NOT_INCLUSIVE_POSITION:LENGTH} e.g "./FASTQ12345_1.fastq.gz" or "./FASTQ12345_2.fastq.gz" -> "FASTQ12345"
	find ./ -iname "*${f:2:10}*" |xargs cat > ./Merged/${f:2:10}.fastq.gz
	echo "Merger is done for ${f:2:10}" 
done;

