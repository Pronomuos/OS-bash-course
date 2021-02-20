#!/bin/bash

if [[ $# > 1  ||  $# < 1 ]];
then
	echo "Incorrect number of arguments"
	exit 1
fi

if [[ ! -f $1 ]];
then
	echo "File is not found"
	exit 1
fi

if  [[ ! -e "/home/user/.trash" ]];
then
	mkdir "/home/user/.trash"
fi

count=0
while [[ -e "/home/user/.trash/$1_$count" ]]; do 
	((count=count + 1))
done

ln  "/home/user/lab4/$1" "/home/user/.trash/$1_$count"
rm $1 && echo "$(realpath $1):$1_$count" >> /home/user/.trash.log
