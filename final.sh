#!/bin/bash
# Created global variables that every function can use. Avoid the unnecessary oytput information. 

# generate chia commands based on resources
chia_generator(){
    # memory=$1
    # threads=$2
    # temp=$3
    # final=$4
    echo chia plots create -k 32 -b "$1" -r "$2" -t "$3" -d "$4"
}

#Returns number of threads of the cpu
find_cpu_threads(){
    cores=$(( $(lscpu | awk '/^Socket\(s\)/{ print $2 }') * $(lscpu | awk '/^Core\(s\) per socket/{ print $4 }') ))
    threads_per_core=$(( $(lscpu |awk '/^Thread\(s\) per core/{ print $4 }') ))
    threads=( "$cores" * "$threads_per_core")
    # threads= (Sockets X Cores per socket) X threads_per_core 
    #echo "$threads" 
}
threads=0
find_cpu_threads

    
plotting_threads(){
    plotting_threads=$(echo "$threads"  "$plots" |awk '{print $1 / $2}')
    #echo "$plotting_threads"
}
plotting_threads=0


# Returns total memory
find_total_memory(){
    memory=("$(grep MemTotal /proc/meminfo |awk '{ print $2}')")
    total_memory=$(echo "scale=3;$memory/1024"|bc )
    #echo "$total_memory"
}
total_memory=0
find_total_memory
echo $total_memory

# Return memory that can be divided based on plots
plotting_memory(){
    plotting_memory=$(echo "$total_memory $plots" | awk '{print $1 / $2}')
    #echo "$plotting_memory"
}
plotting_memory=0

#Finds amount of plots based on space size
plots_per_space(){
    
    #available_space=$(df /mnt/chia/ |grep dev |awk '{print $3}')
    #space=$(("$available_space" /1024 |bc  ))
    plots=$(("$space"/365500)) 

    #echo $plots
}
plots=0

#Finds available space based on drive location
available_space(){
    available_space=$(df /mnt/chia/ |grep dev |awk '{print $4}')
    space=$(("$available_space" /1024  ))

    #echo $space

}
space=0
available_space
# Returns temporary chia directory
temp_location(){
    temp="/mnt/chia/temp"
    #echo "$temp"
}
temp=""
temp_location
# Returns destination chia directory
dest_location(){
    final="/mnt/chia/plots"
    #echo $final
}
final=""
dest_location 

plots_per_space
plotting_threads
plotting_memory

outputs(){
    echo "You have a total of $space Gb available space"
    echo "You can create $plots plots based on your available space"
    echo "This is your command: "
    command=$(chia_generator "$plotting_memory" "$plotting_threads" "$temp" "$final") 
    echo $command
}

outputs

#chia_generator "$plotting_memory" "$plotting_threads" "$temp" "$final"
