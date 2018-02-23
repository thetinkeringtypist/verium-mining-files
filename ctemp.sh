#!/bin/bash
#
#! A script that calculates the hashrate of all machines on the network.
hosts=$(cat "/home/$USERNAME/.chosts")
script_dir="/home/$USERNAME/scripts"
temp_sum=0
count=0

for host in $hosts; do
	ping -q -c 1 "$host" >/dev/null

	#! Is dead
	if [ $? -ne 0 ]; then
		echo -e "[$host]:\t\033[1;91munresponsive\033[0m"
		continue
	fi

	ssh -q "$host" "exit" > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		echo -e "[$host]:\t\033[1;91mssh error\033[0m"
		continue
	fi

	temp_string=$(ssh -q "$host" "$script_dir/cputemp.sh" | tee /dev/tty)
	temp=$(echo "$temp_string" | egrep -o "[0-9]+\.[0-9]{1}")
	temp_sum=$(echo "$temp_sum + $temp" | bc -l)
	((count++))
done

temp_average=$(echo "scale=1; $temp_sum / $count" | bc -l)
echo -e "\t\t\t Average: $temp_average°C"
