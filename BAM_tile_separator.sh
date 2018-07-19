#!/bin/bash

##==========================================================================##
##             		     Tile Separator - ILLUMINA PE BAM               ##
##             		                              			    ##
##                    Copyright (C) 2018  Dr.Mazdak Salavati                ##
##++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++##
##  This program is free software: you can redistribute it and/or modify    ##
##  it under the terms of the GNU General Public License as published by    ##
##  the Free Software Foundation, either version 3 of the License, or	    ##
##  (at your option) any later version.					    ##
##  This program is distributed in the hope that it will be useful,	    ##
##  but WITHOUT ANY WARRANTY; without even the implied warranty of	    ##
##  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the	    ##
##  GNU General Public License for more details.			    ##
##									    ##
##  You should have received a copy of the GNU General Public License	    ##
##  along with this program.  If not, see <http://www.gnu.org/licenses/>.   ##
##==========================================================================##

#Taking the tile (illumina SBS slides have 50 tiles [25/column]) info for separating reads.
# (F+R and all the alignment of the same read) which originate from the same tile on the chip could be 
# subsetted in BAM chunks for parallelising the runs. 

#I/O check
ls ./INPUT.bam

#e.g line ==> HISEQ:123:C1XX2XXXX:5:~~~TILE~~1112~~~TILE~~~~:1234:12345
samtools view INPUT.bam | sort -V -k1,5n | cut -d: -f5 | uniq > tile.txt
  
#Splitting the tile by the number of cores available to the pipeline e.g. 12
# split -n 12 -e tile.txt --filter 'dd 2> /dev/null'

#Preserving the header
samtools view -H INPUT.bam > tmp_header.sam

#Testing the while loop for 12 cores
While read TILERANGE;do
    #Range reporter
    echo "$TILERANGE \n will be separated from the BAM"
    
    #First tile of the range for marking only!
    tally=$(head -n 1 $TILERANGE)
    
    #print the SAM without header, sub-setting and conversion
    samtools view -@12 INPUT.bam | awk -F'\t' '$1 ~/$TILERANGE/ {print $0}' | samtools view -bS -@12 > INPUT_${tally}.bam 
    
    #reheader the BAM
    samtools reheader tmp_header.sam INPUT_${tally}.bam > tmp && mv tmp INPUT_${tally}.bam
    
    ##ALL THE FUNCTIONS need to be done to that chunk of BAM e.g. sort -n READNAME
    samtools sort -n -@12 INPUT_${tally}.bam -o INPUT_${tally}_sorted.bam
    
    echo "$tally is done!"
done < $(split -n 12 tile.txt --filter 'dd 2> /dev/null')

#Merger of the chunks
ls -1 ./*_sorted.bam > bam.list
samtools merge -b bam.list > INPUT_sorted.bam

#Garbage cleaner

rm -f ./*_sorted.bam
rm -f bam.list
rm -f tmp_header.sam
rm -f tile.txt




