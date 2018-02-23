#!/bin/bash
#
#! A script that calculates the share percentage of all machines on the network
hosts=$(cat /home/evan/.chosts)
script_dir="/home/evan/scripts"
hash_sum=0
count=0

for host in $hosts; do
	ping -q -c 1 "$host" >/dev/null

	#! Is alive
	if [ $? -eq 0 ]; then
		hash_string=$(ssh -q "$host" "$script_dir/hashrate.sh" | tee /dev/tty)
		hashes=$(echo "$hash_string" | egrep -o "[0-9]+\.[0-9]{3}")
		hash_sum=$(echo "$hash_sum + $hashes" | bc -l)
		((count++))

	#! Is dead
	else
		echo -e "[$host]:\tdead"
	fi
done

hash_average=$(echo "scale=3; $hash_sum / $count" | bc -l)
echo -e "\n\t\t\t\tTotal: $hash_sum H/m"
echo -e "\t\t\t Average: $hash_average H/m"
