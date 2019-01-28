#!/bin/bash
#Script works really well if fasqc need to be run on a small number of fastq.gz files ( files <= number of CPU threads)

#Vectorised function for parsing file per row in a 1 column list
QC(){
fastqc --noextract "$1"
}

#Creating the 1 column list 
ls -1 ./*.fastq.gz > tmp

#Parallel loop of background tasks
while read f ;do
        QC "$f" &
done < tmp

#Cleaner
rm -f tmp

#Waiting for all the spawn tasks before returning to the shell.
wait
echo "All done!"

#If something like multiqc is also available--> 
multiqc -o report_all ./




