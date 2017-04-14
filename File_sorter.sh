#!/bin/bash
##==============================================================================##
##             			 File Sorter	      		                ##
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
## Have you ever had to sort out 1000s of files in to few groups (viz. folders)?!
## I had more than 1000 PDF files named with individual IDs that only existed on a separate list ('ID.list' was of comma separated values).
## ID.list also had GROUP information under 1st column ($1) and individual IDs under 4th ($4). 

## Destination folders 

mkdir -p ./ABC/GROUP1
mkdir -p ./ABC/GROUP2
mkdir -p ./ABC/GROUP3 
mkdir -p ./ABC/GROUP4

## BASH indexes from 1 and lefthand side excluded (Similar to python).

for pdf in "./ABC/"*.pdf
do 
	awk -F',' '($1 == "GROUP1"){print $4}' ./ID.list > temp1
	if grep ${pdf:39:18} temp1; #${pdf:39:18} This coordinate was taking the ID part of my PDF file names. Adjust for your own accordingly.
		then
		mv $pdf ./ABC/GROUP1/${pdf:39:22} #PDF file full name excl. pevious PWD
	fi;
	awk -F',' '($1 == "GROUP2"){print $4}' ./ID.list > temp2
	if grep ${pdf:39:18} temp2; 
		then
		mv $pdf ./ABC/GROUP2/${pdf:39:22} 
	fi;
	awk -F',' '($1 == "GROUP3"){print $4}' ./ID.list > temp3
	if grep ${pdf:39:18} temp3; 
		then
		mv $pdf ./ABC/GROUP3/${pdf:39:22} 
	fi;
	awk -F',' '($1 == "GROUP4"){print $4}' ./ID.list > temp4
	if grep ${pdf:39:18} temp4; 
		then
		mv $pdf ./ABC/GROUP4/${pdf:39:22} 
	fi;
done

## Clean up (vey conservative to accomodate for different shells)

rm -f temp1
rm -f temp2
rm -f temp3
rm -f temp4

