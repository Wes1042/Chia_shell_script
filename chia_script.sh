#!/bin/bash

# creates a function that generates the chia command from # can generate multiple options for k values . Ex . If space = a number in range of k value then generate 
Chia_command()   #Returns command and number that you choose that can run with the parallel plot 
#find_cpu , find_ram , findspace, 


# finds the cpu of the device 
find_cpu () 
{
echo "cpu=($(lscpu|grep -E '^Thread|^Core|^Socket|^CPU\(' |awk '{ print $2, $4}'))" #prints out what the cpu info yput device has
echo "threads= $(( ($(lscpu | awk '/^Socket\(s\)/{ print $2 }') * $(lscpu | awk '/^Core\(s\) per socket/{ print $4 }')) * $(lscpu |awk '/^Thread\(s\) per core/{ print $4 }') ))"
#print out the amount of threads you have and use. 
}


# finds the total amount of Ram 
Find_Ram() 
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


Find_space()
# Find total amount of space there is and display how much space you have left which will calculate how much space we can use 
lsblk -o name,size -lpn |grep "/dev/sd"
Parallel_plotting(chia_command)
# if user typed yes then the program will run in the command with multiple shells . Will open other shells 
Maybe open screen 

Check_venv()
# if user is not in venv mode (will have trouble figuring this out ) activate the block chain activate directory  and run 



