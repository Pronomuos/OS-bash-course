#!/bin/bash

K=$1
N=$2
> report.log

for (( i=0; i < K; i++ )); do
	./newmem.bash $N & 
	sleep 1
done

