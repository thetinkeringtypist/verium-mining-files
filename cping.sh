#!/bin/bash
#
#! A script that calculates the hashrate of all machines on the network.
hosts=$(cat /home/evan/.chosts)
script_dir="/home/evan/scripts"

for host in $hosts; do
	ping -q -c 1 "$host" >/dev/null

	#! Is dead
	if [ $? -ne 0 ]; then
		echo -e "[$host]:\t\033[1;91munresponsive\033[0m"
		continue
	fi

	is_mining=$(ssh -q "$host" "$script_dir/is-mining.sh")
	if [ "$is_mining" == "true" ]; then
		echo -e "[$host]:\t\033[1;92malive\033[0m (and \033[1;34mmining\033[0m)"
	else
		echo -e "[$host]:\t\033[1;92malive\033[0m (but \033[1;38mnot mining\033[0m)"
	fi
done
