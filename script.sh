#!/bin/bash
# Shell Script To List All Top Hitting IP Address to your webserver.
rm -f iplist.txt

# top hitted ips list 
echo " " " " " " " " "Top Hitted IPs"
echo " " " " " " " " "--------------"
ips= awk '{print $1}'  logs.txt | grep -ivE "(127.0.0.1)"| sort -n | uniq -c | sort -nr | head -5
echo $ips

awk '{print $1}'  logs.txt | grep -ivE "(127.0.0.1)"| sort -n | uniq -c | sort -nr | head -5 | awk '{print $2}' >> iplist.txt

# top hitted isp
echo "" " " " " " " " Top Hitted ISP"
echo " " " " " " " " "--------------"

cat iplist.txt | while read line 
do 
printf "%b\t"
CC= curl ipinfo.io/$line --silent | grep org | awk -F ""\" '{print $4}' | cut -c 9- 
done

echo
#top accessed urls
echo "" " " " " " " " Top accessed URLs"
echo " " " " " " " " "-----------------"
awk '{print $7}'  logs.txt  | sort -n | uniq -c | sort -nr | head -5
echo
