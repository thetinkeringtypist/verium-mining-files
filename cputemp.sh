#!/bin/bash
#
#! Script to calculate the cpu temperature of this machine
hostname=$(hostname)
script_dir="/home/evan/scripts"
sum=0
count=0
highest_temp=0

sensor_temps=$(cat /sys/devices/virtual/thermal/thermal_zone*/temp)

for temp in $sensor_temps; do
   if [ $temp -gt $highest_temp ]; then
      highest_temp=$temp
   fi

   sum=$((sum + temp))
   count=$((count + 1))
done

highest_temp=$(echo "scale=1; $highest_temp / 1000" | bc -l)
echo -e "[$hostname]:\tTemp: $highest_temp°C"
