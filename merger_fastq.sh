#!/bin/bash
##==============================================================================##
##             		 FASTQ Merger (gz compressed input)	                ##
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
# This is a solution to when you have the same library sequenced multiple times and you have to merge them. 
# Bare in mind the files should share a commong sample name to be used as a substring in find. 
# There is no need to zcat either as bgzip compression handles the output as it was: 
# Two .gz files glued to each other one after another.

mkdir -p ./Merged;
for f in "./"*.fastq.gz;
	do
	#substring of file names ${f:NOT_INCLUSIVE_POSITION:LENGTH} e.g "./FASTQ12345_1.fastq.gz" or "./FASTQ12345_2.fastq.gz" -> "FASTQ12345"
	find ./ -iname "*${f:2:10}*" |xargs cat > ./Merged/${f:2:10}.fastq.gz
	echo "Merger is done for ${f:2:10}" 
done;

