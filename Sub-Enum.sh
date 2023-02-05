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

if [[ -z "$1" || -z "$2" ]]
then
  	echo -e " ${red}Invalid Syntax:- "
	echo -e " ${normal}Sub-Enum.sh <filepath> <target-name> \n"
elif test -a /home/kali/automated/sub1.txt
then
  	echo "${red}sub1.txt is already there.$normal"
else
	echo -e " ${aqua}\n# Syntax :- ./Sub-Enum.sh <filepath> <target-name> $normal"
	echo -e "# In the End you will have a Sub1.txt and probed1.txt "
	echo -e "# Sub1.txt will contain all the subdomains "
	echo -e "# Probed1.txt will have all alive subdomains ready to use \n"

  	lines=`echo $(cat $1 | wc -l)`
	total=0
  	i=0
	while read domain
	do
   		i=$(($i+1));
		echo "[$i/$lines] "${aqua}$domain ; d=0
		echo "${lightpurple}Now Amass has started....." ; echo -n "$normal"			#Amass passive scan
		echo $(amass enum -passive -d $domain | tee -a sub1.txt) 														#Amass Passive Enumeration

		echo "${lightpurple}[$i/$lines] Now Subfinder has started....." ; echo -n "$normal"	#Subfinder
		echo $(subfinder -d $domain | tee -a sub1.txt)																			#Subfinder Passive Enumeration

		echo "${lightpurple}[$i/$lines] Now Assetfinder has started....." ; echo -n "$normal"	#Assetfinder 
		echo $(assetfinder --subs-only $domain | tee -a sub1.txt)														#Assetfinder Passive Enumeration
	
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
