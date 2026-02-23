#!/bin/bash

# check if argument is given
if [ $# -ne 1 ]
then
    echo "Usage: ./log_analyzer.sh <logfile>"
    exit 1
fi

logfile=$1

# check if file exists
if [ ! -f "$logfile" ]
then
    echo "File not found."
    exit 1
fi

# check if file is empty
if [ ! -s "$logfile" ]
then
    echo "Log file is empty."
    exit 1
fi

echo
echo "===   LOG FILE    ==="
echo "Log File: $logfile"
echo

# total entries
total=$(wc -l < "$logfile")
echo "Total Entries: $total"
echo

# unique IP addresses
echo "Unique IP Addresses:"
awk '{print $1}' "$logfile" | sort | uniq
count_ip=$(awk '{print $1}' "$logfile" | sort | uniq | wc -l)
echo "Total Unique IPs: $count_ip"
echo

# status code summary
echo "Status Code Summary:"
awk '{print $NF}' "$logfile" | sort | uniq -c | awk '{print $2 ": " $1 " requests"}'
echo

# most accessed page
echo "Most Accessed Page:"
awk '{print $6}' "$logfile" | tr -d '"' | sort | uniq -c | sort -nr | head -1
echo

# top 3 IP addresses
echo "Top 3 IP Addresses:"
awk '{print $1}' "$logfile" | sort | uniq -c | sort -nr | head -3
echo
