#!/bin/bash

declare -a arr
declare -a add_arr=(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
		1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)
count=0
> report.log

while true;
do
	arr+=(${add_arr[@]})
	let count++
	if [[ $count == 10000 ]]
	then
		echo "${#arr[*]}" >> report.log
		count=0
	fi
done
