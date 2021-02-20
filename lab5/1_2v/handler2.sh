#!/bin/bash

./mem2.bash&pid0=$!
echo "TIME MEM VIRT RES SHR CPU FREE SWAP" > mem2.txt

while true; do
    line=$(top -p $pid0 -b -n 1 | head -8 | tail -n +8)
    free=$(top -o %MEM -b -n 1 | head -4 | tail -n +4 | awk '{print ""$8""}')
    swap=$(top -o %MEM -b -n 1 | head -5 | tail -n +5 | awk '{print ""$7""}')
    line=$(echo -e $line | awk '{print ""$11" "$11" "$5" "$6" "$7" "$9""}')
    line=$(echo -e "$line $free $swap\n")
    echo $line >> mem2.txt
    sleep 1
done
