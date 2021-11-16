#!/bin/bash
memory=($(grep MemTotal /proc/meminfo | awk '{ print $2}'))
echo "You have a number of $memory"

echo -e "KB\t\tMB\t\tGB\t\tTB"

count=0
while [ $count -le 4 ]
  do
    for i in "${memory[@]}"
    do
    #echo "scale=6;$memory" |bc
     #echo "scale=6;$memory /1024" |bc
    # printf "%.4f\n" $memory | bc -l
     i=$memory
     echo "$memory"
     memory=$((memory / 1024))| bc
     #echo "scale=4;$memory / 1024" |bc
     #echo "$memory"
     count=$((count + 1))
    done
  done
echo ${memory[1]}
#do
 # printf "%.2f\n" $memory
  #memory=$((memory / 1024))
  #echo "$memory"
  #count=$((count +1))
#done
