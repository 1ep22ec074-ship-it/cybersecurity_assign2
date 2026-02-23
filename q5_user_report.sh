#!/bin/bash



echo "=== USER STATISTICS ==="

total_users=$(wc -l < /etc/passwd)
system_users=$(awk -F: '$3 < 1000 {print $1}' /etc/passwd | wc -l)
regular_users=$(awk -F: '$3 >= 1000 {print $1}' /etc/passwd | wc -l)
logged_in=$(who | awk '{print $1}' | sort -u | wc -l)

echo "Total Users: $total_users"
echo "System Users (UID < 1000): $system_users"
echo "Regular Users (UID >= 1000): $regular_users"
echo "Currently Logged In: $logged_in"

echo
echo "=== REGULAR USER DETAILS ==="
printf "%-15s %-8s %-20s %-15s\n" "Username" "UID" "Home Directory" "Shell"

awk -F: '$3 >= 1000 {
    printf "%-15s %-8s %-20s %-15s\n", $1, $3, $6, $7
}' /etc/passwd

echo
echo "=== GROUP INFORMATION ==="

awk -F: '{print $1}' /etc/group

echo
echo "Group Member Count:"
awk -F: '{
    if ($4 == "")
        count = 0
    else
        count = split($4, a, ",")
    printf "%-15s : %d\n", $1, count
}' /etc/group

echo
echo "=== SECURITY CHECK ==="

echo "Users with UID 0:"
awk -F: '$3 == 0 {print "- " $1}' /etc/passwd

echo
echo "Users without passwords:"
awk -F: '$2 == "" {print "- " $1}' /etc/shadow 2>/dev/null

echo
echo "Inactive users (never logged in):"
awk -F: '$3 >= 1000 {print $1}' /etc/passwd | while read user
do
    last "$user" | grep -q "Never logged in"
    if [ $? -eq 0 ]
    then
        echo "- $user"
    fi
done
