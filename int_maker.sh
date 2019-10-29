#!/bin/bash
echo "Please provide chromosome name, length and step size e.g chr1 275000000 5000000"
read chr length step
start=$step
printf '%s:%d-%s\n' "$chr" "1" "${start}" > ${chr}_intervals.list
while [ "$start" -lt "$length" ];do
	        chunk=$(($start+$step))
	while [ "$chunk" -lt "$length" ];do
		printf '%s:%d-%s\n' "$chr" "${start}" "${chunk}" >> ${chr}_intervals.list
		start=$chunk
		chunk=$(($chunk+$step))
		if [ "$chunk" -ge "$length" ];then
			printf '%s:%d-%s\n' "$chr" "${start}" "${length}" >> ${chr}_intervals.list
			break
		fi
	done;
	break
done;

