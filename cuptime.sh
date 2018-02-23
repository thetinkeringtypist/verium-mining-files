#!/bin/bash
#
#! A script that calculates the hashrate of all machines on the network.
hosts=$(cat "/home/$USERNAME/.chosts")
script_dir="/home/$USERNAME/scripts"

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


	result=$(ssh -q "$host" 'uptime -p')
	echo -e "[$host]:\tUptime: $result"
done
