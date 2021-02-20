#!/bin/bash

./mem.bash&pid=$!
> executed_script.info
> mem.info
> process_changes.info

echo  "VIRT	RES	%CPU	%MEM	TIME	COMMAND" >> executed_script.info
echo "PID:COMMAND" >> process_changes.info

while true
do
	process=$(top -b -n 1 | head -12 | tail  -n +8 | awk '{print $1":"$12}' | 
			sed -z 's/\n/\t/g')
	mem=$(top -b -n 1 | head -5 | tail -n +4)
	executed_script=$(top -p $pid -b -n 1 | head -8 | tail -n +8|
	 awk '{print $5"	"$6"	"$9"	"$10"	"$11"	"$12 }')

	echo -e "$process\n" >> process_changes.info
	echo -e "$mem\n" >> mem.info 
	echo -e "$executed_script" >> executed_script.info
	sleep 1
done
