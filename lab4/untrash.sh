#!/bin/bash

if [[ $# > 1 || $# < 1 ]];
then
	echo "Incorrect number of arguments"
	exit 1
fi

if [[ ! -d "/home/user/.trash/" ]] ;
then
	echo "Directory is not found"
	exit 1
fi

if [[ ! -f "/home/user/.trash.log" ]];
then
	echo "Log file is not found"
	exit 1
fi


for line in $(cat "/home/user/.trash.log")
do
	if [[ "$line" =~ "$1" ]]; then

	untrash_file=$(echo $line | cut -d ":" -f 1)
	delete_file=$(echo $line | cut -d ":" -f 2 )
	
	read -p "Are you sure you'd like to resore the file:  $untrash_file ?" ans
	if [[ "$ans" == "y" ]]; then
		location="$untrash_file"
		if [[ ! -d "$(dirname '$untrash_file')" ]]; then
			echo "No directory. The file will be restored in home directory"
			location= "/home/user/$1"
		fi
	
		ln "/home/user/.trash/$delete_file" $location &&
		 rm "/home/user/.trash/$delete_file" &&
		sed -i "/$delete_file/d" "/home/user/.trash.log" &&
		 echo "$untrash_file was restored"
	fi
	fi
done 
