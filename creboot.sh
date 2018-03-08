#!/bin/bash
#
#! A script that reboots all hosts listed in $HOME/.chosts
#
#! Assumes authorized SSH key for root
hosts=$(cat "$HOME/.chosts")
script_dir="$HOME"

for host in $hosts; do
	ping -q -c 1 "$host" >/dev/null

	#! Is dead
	if [ $? -ne 0 ]; then
		echo -e "[$host]:\t\033[1;91munresponsive\033[0m"
		continue
	fi

	ssh "root@$host" "systemctl reboot" > /dev/null 2>&1
	echo -e "[$host]:\trebooting..."
done
