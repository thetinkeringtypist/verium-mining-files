#!/bin/bash
#
#! Script to calculate the share percentage of this machine
hostname=$(hostname)
script_dir="/home/$USER"

is_mining=$("$script_dir/is-mining.sh")

if [ "$is_mining" == "false" ]; then
   echo -e "[$hostname]:\tnot mining"
   exit
fi

percent_1way=$(grep "%" /var/log/minerd/minerd-1way.log | tail -n 1 | egrep -o "[0-9]+\.[0-9]{2}" | head -n 1)
percent_3way=$(grep "%" /var/log/minerd/minerd-3way.log | tail -n 1 | egrep -o "[0-9]+\.[0-9]{2}" | head -n 1)
shares_1way=$(grep "%" /var/log/minerd/minerd-1way.log | tail -n 1 | egrep -o "[0-9]+/[0-9]*")
shares_3way=$(grep "%" /var/log/minerd/minerd-3way.log | tail -n 1 | egrep -o "[0-9]+/[0-9]*")

percent_average=$(echo "scale=2; ($percent_1way + $percent_3way) / 2" | bc -l)

echo -e -n "[$hostname]:\t"
if [ "$1" == "--1way" ] || [ "$1" == "--one-way" ] || [ "$1" == "--oneway" ]; then
   echo "1-Way: $shares_1way ($percent_1way%)"
elif [ "$1" == "--3way" ] || [ "$1" == "--three-way" ] || [ "$1" == "--threeway" ] ; then
   echo "3-Way: $shares_3way ($percent_3way%)"
else
   accepted_1way=$(echo "$shares_1way" | tr '/' ' ' | awk '{print $1}')
   total_1way=$(echo "$shares_1way" | tr '/' ' ' | awk '{print $2}')
   accepted_3way=$(echo "$shares_3way" | tr '/' ' ' | awk '{print $1}')
   total_3way=$(echo "$shares_3way" | tr '/' ' ' | awk '{print $2}')

   accepted=$((accepted_1way+accepted_3way))
   total=$((total_1way+total_3way))

   echo "Total: $accepted/$total ($percent_average%)"
fi
