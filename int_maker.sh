#!/bin/bash
echo "Please provide chromosome name and lenth e.g chr1 275000000"
read chr length
start=1000000
printf '%s:%d-%s\n' "$chr" "1" "${start}" > ${chr}_intervals.list
while [ "$start" -lt "$length" ];do
	chunk=$(($start+1000000))
	while [ "$chunk" -lt "$length" ];do  
		printf '%s:%d-%s\n' "$chr" "${start}" "${chunk}" >> ${chr}_intervals.list
		start=$chunk
		chunk=$(($chunk+1000000))
		if [ "$chunk" -ge "$length" ];then 
			printf '%s:%d-%s\n' "$chr" "${start}" "${length}" >> ${chr}_intervals.list
			break
		fi
	done;
	break
done;


	


