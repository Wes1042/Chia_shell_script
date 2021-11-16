#!/bin/bash
#You can create arrays to get a list of stuff and store them
cpu=($(lscpu|grep -E '^Thread|^Core|^Socket|^CPU\(' |awk '{ print $2, $4}'))

count=0
for i in "${cpu[@]/per}"
do
  echo "$i"
  count=$((count + 1))
done
