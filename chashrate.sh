#!/bin/bash
#
#! A script that calculates the hashrate of all machines on the network.
hosts=$(cat /home/evan/.chosts)
script_dir="/home/evan/scripts"
hash_sum=0
count=0

for host in $hosts; do
	#! Check to see if the host is alive
	ping -q -c 1 "$host" >/dev/null
	if [ $? -ne 0 ]; then
		echo -e "[$host]:\t\033[1;91munresponsive\033[0m"
		continue
	fi

	#! Verify that ssh is open and non-refusing
	ssh -q "$host" "exit" > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		echo -e "[$host]:\t\033[1;91mssh error\033[0m"
		continue
	fi

	#! Verify that the machine is mining
	is_mining=$(ssh -q "$host" "$script_dir/is-mining.sh")
	if [ "$is_mining" == "false" ]; then
		echo -e "[$host]:\t\033[1;91mnot mining\033[0m"
		continue
	fi

	hash_string=$(ssh -q "$host" "$script_dir/hashrate.sh $1" | tee /dev/tty)
	hashes=$(echo "$hash_string" | egrep -o "[0-9]+\.[0-9]{3}")
	hash_sum=$(echo "$hash_sum + $hashes" | bc -l)
	((count++))
done

hash_average=$(echo "scale=3; $hash_sum / $count" | bc -l)
echo -e "\n\t\t\t\tTotal: $hash_sum H/m"
echo -e "\t\t\t Average: $hash_average H/m"
