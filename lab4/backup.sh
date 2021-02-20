#!/bin/bash

HOM="/home/user"
backup_date=$(ls $HOM | grep -E "^Backup-" | sort -n | tail -1  | sed "s/Backup-//")
backup="$HOM/Backup-${backup_date}"
today_date=$(date +"%Y-%m-%d")
today_time=$(date -d "$today_date" +"%s")
backup_time=$(date -d "$backup_date" +"%s")
total_time=$(echo "(${today_time} - ${backup_time} / 60 / 60 / 24" | bc)
rep="$HOM/backup-report"


if [[ $total_time > 7 || -z "$backup_date" ]];
then
	mkdir "$HOM/Backup-${today_date}"
	for obj in $(ls $HOM/source);
		do
			cp "$HOM/source/$obj" "$HOM/Backup-$today_date"
		done
	list=$(ls $HOM/source | sed "s/^/\t/")
	echo -e "${today_date} created:\n${list}" >> $rep
else
	changes=""
	for obj in $(ls $HOM/source);
		do
			if [[ -f "$backup/$obj" ]];
			then
				source_size=$(stat "$HOM/source/${obj}" -c%s)
				backup_size=$(stat "${backup}/${obj}" -c%s)
				if [[ $source_size -ne $backup_size ]]
				then
					mv "$backup/$obj" "$backup/$obj.$today_date"
					cp "$HOM/source/$obj" $backup
					changes="${changes}\n\t$obj ($obj.$today_date)"
				fi
			else
				cp "$HOM/source/$obj" $backup
				changes="${changes}\n\t$obj"
			fi
		done
	changes=$(echo $changes | sed 's/^\\n//')
	if [[ ! -z "$changes" ]];
	then
		echo -e "${backup_date}. Updated:\n${changes}" >> $rep
	fi
fi 
