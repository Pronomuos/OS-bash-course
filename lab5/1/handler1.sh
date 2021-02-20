#!/bin/bash

./mem1.bash&pid=$!
> executed_script1.info
> mem1.info
> process_changes1.info

echo  "VIRT	RES	%CPU	%MEM	TIME	COMMAND" >> executed_script1.info
echo "PID:COMMAND" >> process_changes1.info

while true
do
	process=$(top -b -n 1 | head -12 | tail  -n +8 | awk '{print $1":"$12}' | 
			sed -z 's/\n/\t/g')
	mem=$(top -b -n 1 | head -5 | tail -n +4)
	executed_script=$(top -p $pid -b -n 1 | head -8 | tail -n +8|
	 awk '{print $5"	"$6"	"$9"	"$10"	"$11"	"$12 }')

	echo -e "$process\n" >> process_changes1.info
	echo -e "$mem\n" >> mem1.info 
	echo -e "$executed_script" >> executed_script1.info
	sleep 1
done
