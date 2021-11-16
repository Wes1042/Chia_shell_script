#!/bin/bash

memory=($(grep MemTotal /proc/meminfo |awk '{ print $2}'))
echo "You have a $memory of memory"

echo -e "KB\t\tMB\t\t\tGB\t\tTB"


for (( i=0; i<=3; i++ ))
do
  printf '%s\t\t%s' $memory
  memory=$(echo "scale=3;$memory/1000" |bc)
done
echo -e "\nThis device has the following memory in BiB"
memory=($(grep MemTotal /proc/meminfo |awk '{ print $2}'))
memory=$(echo "scale=3;$memory/1.024" |bc )
echo -e "\nKiB\t\t\tMiB\t\t\tGiB\t\tTiB"
for ((i=0; i<=3; i++))
do
  printf '%s\t%s\t' $memory
  memory=$(echo "scale=4;$memory/1024" |bc)
done
