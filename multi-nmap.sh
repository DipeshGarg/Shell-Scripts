#!/bin/bash

while read ip
do
	echo "\n### Running nmap on $ip..."
	#nmap -p- $ip -T4 
	nmap -A -Pn -p- $ip -v -T4 --script=vuln -oA nmap-$ip 
done
