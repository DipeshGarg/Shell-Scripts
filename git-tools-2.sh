#!/bin/bash

#Colour-Codes
{
normal=`echo -en "\e[0m"`
red=`echo -en "\e[31m"`
green=`echo -en "\e[32m"`
orange=`echo -en "\e[33m"`
blue=`echo -en "\e[34m"`
lightgreen=`echo -en "\e[92m"`
purple=`echo -en "\e[35m"`
aqua=`echo -en "\e[36m"`
}

url=(
'https://github.com/commixproject/commix.git'
'https://github.com/epi052/feroxbuster.git'
'https://github.com/ffuf/ffuf.git'
'https://github.com/haccer/subjack.git'
#'https://github.com/jordansissel/xdotool.git'
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
'https://github.com/tomnomnom/assetfinder.git'
# Github Tools
'https://github.com/0xInfection/XSRFProbe.git'
'https://github.com/codingo/NoSQLMap.git'
'https://github.com/defparam/smuggler.git'
'https://github.com/FortyNorthSecurity/EyeWitness.git'
'https://github.com/hahwul/XSpear.git'
'https://github.com/chenjj/CORScanner.git'
'https://github.com/s0md3v/Corsy.git'
'https://github.com/michenriksen/aquatone.git'
'https://github.com/projectdiscovery/chaos-client.git'
'https://github.com/projectdiscovery/uncover.git'
'https://github.com/projectdiscovery/shuffledns.git'
'https://github.com/s0md3v/XSStrike.git'
'https://github.com/sensepost/gowitness.git'
'https://github.com/swisskyrepo/SSRFmap.git'
'https://github.com/Dewalt-arch/pimpmykali.git'
'https://github.com/r0oth3x49/ghauri.git'
'https://github.com/Dheerajmadhukar/4-ZERO-3.git'
'https://github.com/initstring/cloud_enum.git'
 #'https://github.com/tomnomnom/gf.git'
'https://github.com/1ndianl33t/Gf-Patterns.git'
'https://github.com/urbanadventurer/WhatWeb.git'
'https://github.com/D4Vinci/Clickjacking-Tester.git'
'https://github.com/GerbenJavado/LinkFinder.git'
'https://github.com/tomnomnom/qsreplace.git'
# GO Tools
'github.com/lc/subjs@latest'
'github.com/lc/gau/v2/cmd/gau@latest'
'github.com/hahwul/dalfox/v2@latest'
'github.com/Emoe/kxss@latest'
'github.com/KathanP19/Gxss@latest'
'github.com/tomnomnom/anew@latest'
'github.com/projectdiscovery/katana/cmd/katana@latest'
)

aptcount=16 ;
gocount=38 ;

{
echo "
List of tools which can be installed...

$normal# Kali Tools Below...$red
 0. commix               1. feroxbuster           2. ffuf
 3. subjack              4. hakrawler             5. gospider
 6. jd-gui               7. dnsx                  8. nuclei
 9. subfinder           10. masscan              11. jadx
12. sqlmap              13. httpx-toolkit        14. amass
15. assetfinder

$normal# Github Tools Below...$green
16. XSRFProbe           17. NoSQLMap             18. smuggler
19. EyeWitness          20. XSpear               21. CORScanner
22. Corsy               23. aquatone             24. chaos-client
25. uncover             26. shuffledns           27. XSStrike
28. gowitness           29. SSRFmap              30. pimpmykali
31. ghauri              32. 4-ZERO-3             33. cloud_enum
34. Gf-Patterns         35. WhatWeb              36. Clickjacking-Tester
37. LinkFinder          38. qsreplace

$normal# Go Tools Below...$aqua
39. subjs               40. gau                  41. dalfox
42. kxss                43. gxss                 44. Anew
45. katana
$normal "
}
# n=`echo "${#url[@]}"`
# echo -e "List of tools which can be installed...\n"
# for ((i=0; i<$n ;i++))
# do
#   if [ $i -eq $aptcount ]
#   then
#    echo -e "\n# Github Tools below..."
#  elif [[ $i -gt $gocount ]]; then
#    echo -e "\n# Go Tools below..."
#   fi
#   echo -e "$i. \c"
#   echo -e "$(echo "${url[i]}" | cut -d "." -f2 | cut -d "/" -f3) \c"
#   i=$(($i+1))
#   echo -e "\t\t$i. \c"
#   echo "$(echo "${url[i]}" | cut -d "." -f2 | cut -d "/" -f3)"
# done

echo -e "\nSyntax: 3,2,4 or exit"
echo "Which of these tools you want to install ?"
read input

if [[ $input -eq 'exit' || $input -eq 'Exit' ]]
then
  echo "${red}Closing the script...$normal"
else
  IFS="," read -a ans <<< $input
  n=`echo "${#ans[@]}"`
  echo -e "\nStarted installing the tools..."

  for ((i=0; i<n; i++))
  do
    name=`echo $(echo ${url[${ans[i]}]} | cut -d "." -f2 | cut -d "/" -f3 )`
    if [ ${ans[i]} -lt $aptcount ]; then
      echo "${red}sudo apt-get install $name $normal"
      echo "$(sudo apt-get install $name -y )"
    elif [[ ${ans[i]} -gt $gocount ]]; then
      echo "${aqua}sudo go install ${url[${ans[i]}]} $normal"
      echo "$(go install ${url[${ans[i]}]} )"
    else
      echo "${green}sudo git clone ${url[${ans[i]}]} $normal"
      echo "$(sudo git clone ${url[${ans[i]}]})"
    fi
  done
fi
