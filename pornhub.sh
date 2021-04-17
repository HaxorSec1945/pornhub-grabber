#!/bin/bash
blue='\e[0;34'
cyan='\e[0;36m'
green='\e[0;34m'
okegreen='\033[92m'
lightgreen='\e[1;32m'
white='\e[1;37m'
red='\e[1;31m'
yellow='\e[1;33m'

banner(){
echo -e $yellow"====================================="
echo -e $yellow"        Mass Pornhub Grabber         "
echo -e $yellow"       Copyright Mrcakil@2020        "
echo -e $yellow"====================================="
read -p "Category : " ca;
read -p "Page : " pagen;
read -p "To Page : " pagenya;
}
banner

checker(){
video=$(curl -s "https://www.pornhub.com/video/search?search=$ca&page=$page" -L | grep -oP '<a href="/view_video\K[^ ]+"' | cut -d '"' -f1 | sort -u > res.txt)
videonya=$(curl -s "https://www.pornhub.com/video/search?search=$ca&page=$page" -L | grep -oP '<a href="/view_video\K[^ ]+"' | cut -d '"' -f1)
title=$(curl -s "https://www.pornhub.com/video/search?search=$ca&page=$page" -L | grep -oP '<a href="/view_video\K[^ ]+" title="(.*?)"' | cut -d '"' -f3 | sort -u > title.txt)
#v=$(echo "$videonya")
if [[ -z "${videonya}" ]];
then
echo -e "$cyan[+] Site :$yellow https://www.pornhub.com/video/search?search=$ca&page=$page =>$red Failed!"
else
for i in $(seq $(cat res.txt | wc -l));
do
echo -e "$cyan[+] Site :$yellow https://www.pornhub.com/video/search?search=$ca&page=$page =>$okegreen Grabbed!"
echo -e "$cyan[+] Title : $okegreen"$(cat title.txt | sed -n "${i}p")
echo -e "$cyan[+] Link :$okegreen https://www.pornhub.com/view_video"$(cat res.txt | sed -n "${i}p")
done
fi
}

for page in $(seq $pagen $pagenya);
do
checker $page
done