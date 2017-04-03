#!/bin/bash
##==============================================##
##              Md5sum checker                  ##
##              by                              ##
##              Dr.Mazdak Salavati              ##
##              30.03.2017                      ##
##==============================================##
for f in ./*/*/*.fastq.gz #Just in case your files live in many subfolders
do
key="$(md5sum $f|awk '{print$1}')"
        if grep -q $key $f.md5 ; then
                echo "Passed"
        else
                echo "$f failed md5sum check!" #output is to terminal but could always be appended to a file >> fail_report.txt
                echo "$f" >> fial_report.txt
        fi

done;

