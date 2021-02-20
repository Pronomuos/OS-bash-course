#!/bin/bash

cmd="+"
echo "+"
output=1
tail -f pipe |
while true;
do
	read line
	case $line in
		"+")
			cmd=$line
			echo "Switched plus"
		;;
		"*")
			cmd=$line
			echo "Switched multiplication"
		;;
		"QUIT")
			pid=$(pidof -s tail)
			kill $pid
			echo "Quit"
			exit 0
		;;
		[0-9]*)
			case $cmd in
				"+")
					output=$(($output + $line))
					echo $output
				;;
				"*")
					output=$(($output * $line))
					echo $output
				;;
			esac
		;;
		*)
			pid=$(pidof -s tail)
			kill $pid
			echo "Inccorrect parameter"
			exit 1
		;;
	esac
done
