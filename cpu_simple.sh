#!/bin/bash
echo "Cores = $(( $(lscpu | awk '/^Socket\(s\)/{ print $2 }') * $(lscpu | awk '/^Core\(s\) per socket/{ print $4 }') ))"
echo $Cores
echo "Threads_per_core = $(( $(lscpu |awk '/^Thread\(s\) per core/{ print $4 }') ))"
#echo "threads=$(( $(lscpu | awk '/^Thread\(s\) per core/{ print $4 }') ))"

echo "test= $(( ($(lscpu | awk '/^Socket\(s\)/{ print $2 }') * $(lscpu | awk '/^Core\(s\) per socket/{ print $4 }')) * $(lscpu |awk '/^Thread\(s\) per core/{ print $4 }') ))"
echo "Threads= $((Cores * Threads_per_core))"
