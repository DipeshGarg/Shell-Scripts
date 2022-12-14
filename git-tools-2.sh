#!/bin/bash

{
normal=`echo -en "\e[0m"`
red=`echo -en "\e[31m"`
green=`echo -en "\e[32m"`
orange=`echo -en "\e[33m"`
blue=`echo -en "\e[34m"`
purple=`echo -en "\e[35m"`
aqua=`echo -en "\e[36m"`
gray=`echo -en "\e[37m"`
lightgreen=`echo -en "\e[92m"`
lightyellow=`echo -en "\e[93m"`
lightblue=`echo -en "\e[94m"`
lightpurple=`echo -en "\e[95m"`
lightaqua=`echo -en "\e[96m"`
#----------------
# red='\e[31m'
# green='\e[32m'
# blue='\e[34m'
# cyan='\e[96m'
# ltcyan='\e[96m'
# yellow='\e[33m'
# black='\e[38;5;016m'
# bluebg='\e[48;5;038m'${black}
# normal='\e[0m'
}

url=(
'https://github.com/commixproject/commix.git'
'https://github.com/epi052/feroxbuster.git'
'https://github.com/ffuf/ffuf.git'
'https://github.com/haccer/subjack.git'
'https://github.com/hakluke/hakrawler.git'
'https://github.com/jaeles-project/gospider.git'
'https://github.com/java-decompiler/jd-gui.git'
'https://github.com/projectdiscovery/dnsx.git'
'https://github.com/projectdiscovery/nuclei.git'
'https://github.com/projectdiscovery/subfinder.git'
'https://github.com/robertdavidgraham/masscan.git'
'https://github.com/skylot/jadx.git'
'https://github.com/sqlmapproject/sqlmap.git'
'https://github.com/projectdiscovery/httpx-toolkit.git'
'https://github.com/OWASP/amass.git'
'https://github.com/tomnomnom/assetfinder.git' #last one
'https://github.com/0xInfection/XSRFProbe.git'
'https://github.com/codingo/NoSQLMap.git'
'https://github.com/defparam/smuggler.git'
'https://github.com/FortyNorthSecurity/EyeWitness.git'
'https://github.com/hahwul/XSpear.git'
'https://github.com/chenjj/CORScanner.git'
'https://github.com/s0md3v/Corsy.git'
'https://github.com/projectdiscovery/chaos-client.git'
'https://github.com/michenriksen/aquatone.git'
'https://github.com/projectdiscovery/uncover.git'
'https://github.com/lc/gau.git'
'https://github.com/projectdiscovery/chaos-client.git'
'https://github.com/projectdiscovery/shuffledns.git'
'https://github.com/s0md3v/XSStrike.git'
'https://github.com/sensepost/gowitness.git'
'https://github.com/swisskyrepo/SSRFmap.git'
'https://github.com/Dewalt-arch/pimpmykali.git'
'https://github.com/r0oth3x49/ghauri.git'
'https://github.com/Dheerajmadhukar/4-ZERO-3.git'
 #'https://github.com/tomnomnom/gf.git'
'https://github.com/1ndianl33t/Gf-Patterns.git'
'https://github.com/initstring/cloud_enum.git'
'https://github.com/GerbenJavado/LinkFinder.git'
'https://github.com/urbanadventurer/WhatWeb.git'
'https://github.com/D4Vinci/Clickjacking-Tester.git'
'https://github.com/tomnomnom/qsreplace.git'
)

real() {
if [ $i -lt 10 ]
then
  echo -e " $i. \c"
  echo -e "$(echo "${url[i]}" | cut -d "." -f2 | cut -d "/" -f3) \c"
  i=$(($i+1))
  echo -e "\t\t $i. \c"
  echo "$(echo "${url[i]}" | cut -d "." -f2 | cut -d "/" -f3)"
else
  echo -e "$i. \c"
  echo -e "$(echo "${url[i]}" | cut -d "." -f2 | cut -d "/" -f3) \c"
  i=$(($i+1))
  echo -e "\t\t$i. \c"
  echo "$(echo "${url[i]}" | cut -d "." -f2 | cut -d "/" -f3)"
fi
}

n=`echo "${#url[@]}"`
echo -e "List of tools which can be installed...\n"
for ((i=0; i<$n ;i++))
do
  if [ $i -eq 16 ]
  then
   echo -e "\n# Github Tools below..."
  fi
  # a=`echo $(expr $i % 2)`
  # echo "value of a "=$a
  # if [ $a -eq 0 ]
  # then
    echo -ne "${green}"
    real
    echo -ne "${normal}"
  # else
  #   echo -ne "${gray}"
  #   real
  #   echo -ne "${normal}"
  # fi
done

echo -e "\nSyntax: 3,2,4 or exit"
echo "Which of these tools you want to install ?"
read input

IFS="," read -a ans <<< $input
n=`echo "${#ans[@]}"`
echo -e "\nStarted installing the tools...\n"

for ((i=0; i<n; i++))
do
  name=`echo $(echo ${url[${ans[i]}]} | cut -d "." -f2 | cut -d "/" -f3 )`
  if [ ${ans[i]} -lt 16 ]
  then
    echo "$(sudo apt-get install $name -y )"
  else
    echo "$(sudo git clone ${url[${ans[i]}]})"
  fi
done
