#!/bin/bash

HOM="/home/user"
last_backup_date=$(ls $HOM | grep -E "^Backup-" | sort -n | tail -1 | sed 's/^Backup-//')
last_backup="$HOM/Backup-${last_backup_date}"

if [[ -z "$last_backup_date" ]];
then
	echo "Backup is not found"
	exit 1
fi

if [[ ! -d $HOM/restore ]];
then
	mkdir $HOM/restore
else 
	rm -r $HOM/restore
	mkdir $HOM/restore
fi

for i in $(ls $last_backup | grep -Ev "\.[0-9]{4}-[0-9]{2}-[0-9]{2}$");
do
	cp "${last_backup}/${i}" "$HOM/restore/${i}"
	echo "Success!"
done
