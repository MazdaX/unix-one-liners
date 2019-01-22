#!/bin/bash

#Reporter script for SGE scheduler
while true;do
        qstat -ext -u $USER
        tag=$(qstat -ext -u $USER | awk 'NR==3 {print $1}')
        qstat -j $tag | grep 'usage'
        printf  '\n%s\n' "Press Ctrl+C to stop the reporter!"
        sleep 5
done;
