#!/bin/bash


# generate chia commands based on resources
chia_generator(){
    # memory=$1
    # threads=$2
    # temp=$3
    # final=$4
    echo "chia plots create -k 32 -b "$1" -r "$2" -t "$3" -d "$4""
}

#Returns number of threads of the cpu
find_cpu_threads(){
    cores=$(( $(lscpu | awk '/^Socket\(s\)/{ print $2 }') * $(lscpu | awk '/^Core\(s\) per socket/{ print $4 }') ))
    threads_per_core=$(( $(lscpu |awk '/^Thread\(s\) per core/{ print $4 }') ))
    threads=( "$cores" * "$threads_per_core")
    # threads= (Sockets X Cores per socket) X threads_per_core 
    echo "$threads" 
}
# Returns total memory
find_total_memory(){
    memory=("$(grep MemTotal /proc/meminfo |awk '{ print $2}')")
    total_memory=$(echo "scale=3";"$memory"/1024 |bc )

    echo "$total_memory"
}

# Returns total _space
find_total_space(){
    total_space=$(df /mnt/chia/ |grep dev |awk '{print $2}')

    echo "$total_space"
}
# Returns available space
# find_available_space(){
#     available_space=$(df /mnt/chia/ |grep dev|awk '{print $2}')

#     echo "$available_space"
# }
#Finds amount of plots based on space
space_per_plot(){
    available_space=$(df /mnt/chia |grep dev|awk '{print $3}')
    space=$(echo "scale=3";"$available_space"/1024 |bc )
    plots=("$("$space" /365500)")

    echo "$plots"
}
space_per_plot