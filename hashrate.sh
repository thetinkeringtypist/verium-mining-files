#!/bin/bash
#
#! Script to calculate the hashrate of this machine
hostname=$(hostname)
script_dir="$HOME"

is_mining=$("$script_dir/is-mining.sh")

if [ "$is_mining" == "false" ]; then
   echo -e "[$hostname]:\tnot mining"
   exit
fi

hash_1way=$(grep "H/m" /var/log/cpuminerd/cpuminerd-1way.log | tail -n 1 | egrep -o "[0-9]+\.[0-9]{3}")
hash_3way=$(grep "H/m" /var/log/cpuminerd/cpuminerd-3way.log | tail -n 1 | egrep -o "[0-9]+\.[0-9]{3}")

hash_sum=$(echo "$hash_1way + $hash_3way" | bc -l)

echo -e -n "[$hostname]:\t"
if [ "$1" == "--1way" ] || [ "$1" == "--one-way" ] || [ "$1" == "--oneway" ]; then
   echo "1-Way: $hash_1way H/m"
elif [ "$1" == "--3way" ] || [ "$1" == "--three-way" ] || [ "$1" == "--threeway" ]; then
   echo "3-Way: $hash_3way H/m"
else
   echo "Total: $hash_sum H/m"
fi
