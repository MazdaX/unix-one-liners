#!/bin/bash
##==============================================##
##              Md5sum checker                  ##
##              by                              ##
##              Dr.Mazdak Salavati              ##
##              30.03.2017                      ##
##==============================================##
for f in ./*/*/*.fastq.gz
do
key="$(md5sum $f|awk '{print$1}')"
        if grep -q $key $f.md5 ; then
                echo "Passed"
        else
                echo "$f failed md5sum check!"
        fi

done;

