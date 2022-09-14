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

echo "CVE number ? Format --> CVE-2020-0601, CVE-2020-13777, CVE-2021-40449"
read cve
IFS=", " read -a CVE <<< $cve     #Spliting into array with ","
n=`echo "${#CVE[@]}"`
echo "Total CVEs = $n"

for (( i=0; i<$n; i++ ))
do
  a=`echo $(curl -H 'Cache-Control: no-cache','Connection: keep-alive' --user-agent 'Googlebot/2.1 (+http://www.google.com/bot.html)' --silent "https://vulmon.com/vulnerabilitydetails?qid=${CVE[i]}&scoretype=cvssv3" > temp.txt)`
  echo -n "https://vulmon.com/vulnerabilitydetails?qid=${red}${CVE[i]}${normal}&scoretype=cvssv3 "
  echo $(echo "${orange}" ;cat temp.txt | grep -e "CVSS v3 Base Score:" -e "jsdescription1 content_overview" | sed 's/<\/div>//g;s/<p class="jsdescription1 content_overview"//g;s/\/p>//g' > 1temp.txt )
  echo $(cat 1temp.txt | awk '$1=$1' FS=">" OFS="--> ${lightgreen}" | awk '$1=$1' FS="<" OFS="${red}<${CVE[i]}>" )
  echo -e "${normal}"
done

echo $(rm temp.txt 1temp.txt)
