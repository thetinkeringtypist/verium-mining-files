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

	echo -e "[$host]:\t\033[1;91mTODO: Reboot command\033[0m"
done
