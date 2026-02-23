#!/bin/bash

#echo is use to diplay text
echo "SYSTEM INFORMATION"

#print the system information
echo "Username     : $(whoami)"
echo "Hostname     : $(hostname)"
echo "Date & Time  : $(date '+%Y-%m-%d %H:%M:%S')"
echo "OS           : $(uname -s)"
echo "Current Dir  : $(pwd)"
echo "Home Dir     : $HOME"
echo "Users Online : $(who | wc -l)"
echo "Uptime       : $(uptime -p)"
