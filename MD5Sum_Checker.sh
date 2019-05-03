#!/bin/bash
##==============================================================================##
##             			 MD5 sum checker    		                ##
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
for f in ./*/*/*.fastq.gz #Just in case your files live in many subfolders
do
key="$(md5sum $f|awk '{print$1}')"
        if grep -q $key $f.md5 ; then
                echo "Passed"
        else
                echo "$f failed md5sum check!" #output is to terminal but could always be appended to a file >> fail_report.txt
                echo "$f" >> final_report.txt
        fi

done;

