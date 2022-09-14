#!/bin/bash

#Colour-Codes
{
normal=`echo -en "\e[0m"`
red=`echo -en "\e[31m"`
green=`echo -en "\e[32m"`
orange=`echo -en "\e[33m"`
blue=`echo -en "\e[34m"`
purple=`echo -en "\e[35m"`
aqua=`echo -en "\e[36m"`
gray=`echo -en "\e[37m"`
lightred=`echo -en "\e[91m"`
lightgreen=`echo -en "\e[92m"`
lightyellow=`echo -en "\e[93m"`
lightblue=`echo -en "\e[94m"`
lightpurple=`echo -en "\e[95m"`
lightaqua=`echo -en "\e[96m"`
}

echo " Syntax :- ./Sub-Enum-Script.sh <filename having all domains of target> "
echo " In the End you will have a Sub1.txt and probed1.txt "
echo " Sub1.txt will contain all the subdomains "
echo " Probed1.txt will have all alive subdomains ready to use "

total=0
if test -a ~/automated/sub1.txt
then
echo "${red}sub1.txt is already there.$normal"
fi

total=0
while read domain
do
	echo $domain ; d=0
	echo $(subfinder -d $domain | tee -a sub1.txt)							#Subfinder Passive Enumeration
	echo "${lightpurple}Now Assetfinder has started....." ; echo -n "$normal"
	
	echo $(assetfinder --subs-only $domain | tee -a sub1.txt)					#Assetfinder Passive Enumeration
	echo "${lightpurple}Now Amass has started....." ; echo -n "$normal"
	
	echo $(amass enum -passive -d $domain | tee -a sub1.txt) 					#Amass Passive Enumeration
	
	# echo $(shuffledns -d $domain -w {{wordlist}} -r {{resolvers file}}				#Shuffledns Incomplete { requires resolvers.txt }
	
	sum=`echo $(cat sub1.txt | wc -l)` ; total=$(($sum - $total))
	d=`echo $(cat sub1.txt|grep $domain|sort |uniq | wc -l)`
	echo "${orange}Subdomains found for $domain = $total, $d {Non-Duplicate}";
	echo "$normal";sum=0 ;

done < $1

dup=`echo $(sort sub1.txt | uniq > sub2.txt && cp sub2.txt sub1.txt )`  				#Sorting and De-Duplicating
tsum=`echo $(cat sub1.txt | wc -l )`
echo "${orange}Total subdomains found = $tsum " ;echo -n "$normal"					#Total Subdomain count
t=`echo $(cat sub2.txt | httpx-toolkit | tee ~/automated/probed1.txt )`					#Alive hosts using Httpx
echo "${orange}Alive Hosts = $(cat ~/automated/probed1.txt | wc -l)"					#Alive hosts count
dup=`echo $(mv sub1.txt ~/automated/ ;rm sub2.txt)`							#Moving saved output file
