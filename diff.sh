#!/bin/bash
#
#! Script to calculate the hashrate of this machine
hostname=$(hostname)
script_dir="$HOME"

is_mining=$("$script_dir/is-mining.sh")

if [ "$is_mining" == "false" ]; then
   echo -e "[$hostname]:\tnot mining"
   exit 1
fi

diff_1way=$(grep "difficulty" /var/log/cpuminerd/cpuminerd-1way.log | tail -n 1 | egrep -o "[0|1]\.[0-9]{1,}")
diff_3way=$(grep "difficulty" /var/log/cpuminerd/cpuminerd-3way.log | tail -n 1 | egrep -o "[0|1]\.[0-9]{1,}")

echo -e -n "[$hostname]:\t"
if [ "$1" == "--1way" ] || [ "$1" == "--one-way" ] || [ "$1" == "--oneway" ]; then
   echo "1-Way: $diff_1way diff"
elif [ "$1" == "--3way" ] || [ "$1" == "--three-way" ] || [ "$1" == "--threeway" ]; then
   echo "3-Way: $diff_3way diff"
else
   higher=$(echo "$diff_3way >= $diff_1way" | bc -l)

   if [ $higher -eq 1 ]; then
      diff_high=$diff_3way
   else
      diff_high=$diff_1way
   fi

   echo "Total: $diff_high diff"
fi
