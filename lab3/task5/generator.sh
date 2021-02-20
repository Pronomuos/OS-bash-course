#!/bin/bash

while true;
do
	read line
	echo "$line" > pipe
	if [[ "$line" == "QUIT" ]];
	then
		exit 0
	fi
	if [[ "$line" != [0-9]* && "$line" != "+" && "$line" != "*" ]];
	then
		exit 1
	fi
done
