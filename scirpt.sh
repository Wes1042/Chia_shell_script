#bin/bash

Chia_command(){

}

find_cpu(){
# Finds cpu & amount of threads and will hold them in variables for later use
Cores=$(( $(lscpu | awk '/^Socket\(s\)/{ print $2 }') * $(lscpu | awk '/^Core\(s\) per socket/{ print $4 }') ))
Threads_per_core=$(( $(lscpu |awk '/^Thread\(s\) per core/{ print $4 }') ))
Threads=$(($Cores * $Threads_per_core))
echo "Cores   = $Cores" ; echo "Threads = $Threads"

}

find_memory(){
# Finds memeory in KB
mmemory=($(grep MemTotal /proc/meminfo |awk '{ print $2}'))
echo "This device has $memory KB of memory"
echo -e "\nKB\t\t\tMB\t\t\tGB\t\tTB"

for (( i=0; i<=3; i++ ))
do
  printf '%s\t\t%s' $memory
  memory=$(echo "scale=3;$memory/1024" |bc)
done

# Finds memory in KB and converts to KiB 
memoryib=($(grep MemTotal /proc/meminfo |awk '{ print $2}'))
memoryib=$(echo "scale=3;$memoryib/1.024" |bc )
echo -e "\n\nThis device has $memoryib KiB of memory"
echo -e "\nKiB\t\t\tMiB\t\t\tGiB\t\t\tTiB"

for ((i=0; i<=3; i++))
do
  printf '%s\t%s\t' $memoryib
  memoryib=$(echo "scale=4;$memoryib/1024" |bc)
done
echo -e "\n\n"

}

find_space(){
lsblk -o name,size,mountpoint -lpn |grep "/dev/sd"
# perhaps have a input where it holds where you want to hold the temp and plots folder
}
