#!/bin/bash
echo "Starting values"
Threads=0
Memory=0
echo $Threads 
echo $Memory

Chia_command(){
#chia=(("chia plots create -k $kValue -b $kRAM -r kThreads-t $kTemp -d $kfinal"))
echo "test"
}

find_cpu(){
# Finds cpu & amount of threads and will hold them in variables for later use
Threads=$(( ($(lscpu | awk '/^Socket\(s\)/{ print $2 }') * $(lscpu | awk '/^Core\(s\) per socket/{ print $4 }')) * $(lscpu |awk '/^Thread\(s\) per core/{ print $4 }') ))
#echo "Cores   = $Cores" ; echo "Threads = $Threads"

}


x = find_memory()

find_memory(){
# Finds memeory in KB
memory=($(grep MemTotal /proc/meminfo |awk '{ print $2}'))
Memory=($(grep MemTotal /proc/meminfo |awk '{ print $2 }'));Memory=$(echo "scale=3;$Memory/1024" |bc)

echo "This device has $memory KB of memory"
echo -e "\nKB\t\t\tMB\t\t\tGB\t\tTB"
# calculate from KiB -> TiB
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

# calculate from KiB -> TiB
for ((i=0; i<=3; i++))
do
  printf '%s\t%s\t' $memoryib
  memoryib=$(echo "scale=4;$memoryib/1024" |bc)
done
echo -e "\n\n"

}

find_space(){
  #Finds space from mountint points 
lsblk -o name,size,mountpoint -lpn |grep "/dev/sd"
 total_memory=$(df /mnt/chia/ |grep dev | awk '{print $2}')
used_memory=$(df /mnt/chia/ |grep dev | awk '{print $3}')
available_memory=$(df /mnt/chia/ |grep dev | awk '{print $4}')

GbTotal=$(($total_memory /1024/1024 |bc))
echo "$GbTotal"
echo "$available_memory"
Gbavalable=$(($available_memory / 1024/|bc))
echo "available human readable : $Gbavalable "

# perhaps have a input where it holds where you want to hold the temp and plots folder
#create flag / option that the user can input and will store it here.
# perhaps have a input where it holds where you want to hold the temp and plots folder
}
find_memory
find_cpu
echo "ending values"
echo $Threads
echo $Memory

