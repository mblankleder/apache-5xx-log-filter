#!/bin/bash
LOG="*.log"
MONTH="Oct"
TEMP="/tmp/parser_$MONTH.tmp"

echo "Selecting month"
cat $LOG |grep $MONTH > $TEMP
echo "Temp file for $MONTH is created"

for f in $TEMP 
do
    echo "-------------------------"
    echo "Processing $f"
    echo "-------------------------"
    for i in {01..31}
    do
    echo "Day $i/$MONTH"
            echo "Total requests =>" `cat $f|grep "$i/$MONTH" |wc -l`
            grep 'HTTP/1.1" 50[0-9]' $f|grep -v  Baiduspider |grep -v Googlebot|grep -v YandexBot|grep "$i/$MONTH" | cut -d' ' -f9 | sort | uniq -c | sort -r
    done
done
echo "Removing temp file"
rm -rf $TEMP
exit 0
