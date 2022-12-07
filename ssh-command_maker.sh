#!/bin/bash

#SSH One-Liner Maker
i=0
arr=()
while read ip
do	
	let i++
	#echo "$i. sshpass -p "Admin@9012" ssh vikram@$ip -p 22000"
	#arr[$i]="sshpass -p "Admin@9012" ssh vikram@$ip -p 22000"
	echo "$i. ssh vikram@$ip -p 22000"
	arr[$i]="ssh vikram@$ip -p 22000"
	
done < $1

echo -e "Number ? \c"
read ans
xdotool type "${arr[$ans]}"
