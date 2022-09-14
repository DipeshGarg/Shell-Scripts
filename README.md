# Shell-Scripts
Some of my personal automation shell scripts.

# Details of all scripts
Syntax --> 
./Sub-Enum-Script.sh [ filename containing all domains ]
  
  Sub-Enum_Script.sh --> This script takes a file containing all domains and enumerate subdomains for each of them using multiple tools as Subfinder , Assetfinder , Amass. Then after sorting them it check for alive subdomains and gives you 2 files one with all subdomains and other with alive ones.


Syntax --> 
./Cvss.sh  or ./Cvss.sh | tee details.txt

  Then copy all the cves you want details for like CVE-2020-0601, CVE-2020-13777, CVE-2021-40449
