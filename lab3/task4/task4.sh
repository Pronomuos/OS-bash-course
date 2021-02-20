#!/bin/bash

./loop.sh&pid1=$!
./loop.sh&pid2=$!
./loop.sh&pid3=$!

echo $pid1
echo $pid2
echo $pid3

renice +10 -p $pid1
