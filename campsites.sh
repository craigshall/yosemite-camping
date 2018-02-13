#!/bin/sh
PATH=/anaconda3/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/opt/X11/bin:/usr/local/git/bin

/anaconda3/bin/python campsites.py --start_date $1 --end_date $2 > results/result_$1_$2.txt
RESULTS=`grep -E '^.*[^\n]+.*$' results/result_$1_$2.txt | wc -l`
if [ $RESULTS -gt "0" ];
then
    echo "RESULTS FOUND - "`date`
    cat results/header.txt results/result_$1_$2.txt | mail -s "Get this Campsite!" craigsh@gmail.com
    cat results/header.txt results/result_$1_$2.txt | mail -s "Get this Campsite!" craig2k@yahoo.com
else
    echo "NO RESULTS FOUND - "`date`;
fi;
