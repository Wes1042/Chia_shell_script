#!/bin/bash


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
    echo "$threads" 
}

plotting_threads(){
    plots=("$plots_per_space")
    echo "hahahah $plots"
    threads=("$find_cpu_threads")

    #plotting_threads=$(echo "$threads"  "$plots" |awk '{print $2 / $1}')
    plotting_threads=( "$plots" / "$threads" )
    echo "$plotting_threads"

}
# Returns total memory
find_total_memory(){
    memory=("$(grep MemTotal /proc/meminfo |awk '{ print $2}')")
    total_memory=$(echo "scale=3;$memory/1024"|bc )

    echo "$total_memory"
}

# Return memory that can be divided based on plots
plotting_memory(){
    total_memory=$(find_total_memory)
    plots=$(plots_per_space)
    plotting_memory=$(echo "$total_memory $plots" | awk '{print $1 / $2}')
    #plotting_memory=$(echo "scale=3; $total_memory / $plots" |bc)
    echo "$plotting_memory"
}

# Returns total _space
find_total_space(){
    total_space=$(df /mnt/chia/ |grep dev |awk '{print $2}')

    echo "$total_space"
}

#Finds amount of plots based on space size
plots_per_space(){
    space=$(available_space)
    #available_space=$(df /mnt/chia/ |grep dev |awk '{print $3}')
    #space=$(("$available_space" /1024 |bc  ))
    plots=$(("$space"/365500)) 

    echo $plots
}



#Finds available space based on drive location
available_space(){
    available_space=$(df /mnt/chia/ |grep dev |awk '{print $3}')
    space=$(("$available_space" /1024 |bc  ))

    echo $space

}
# Returns temporary chia directory
temp_location(){
    temp="/mnt/chia/temp"
    echo $temp
}
# Returns destination chia directory
dest_location(){
    final="/mnt/chia/plots"
    echo $final
}

find_total_memory
available_space
plots_per_space
plotting_threads
plotting_memory


temp_location
dest_location

chia_generator "$plotting_memory" "$plotting_threads" "$temp_location" "$dest_location"
