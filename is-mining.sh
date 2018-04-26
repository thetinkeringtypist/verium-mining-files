#!/bin/bash
#
#! Script to determine if the miner is running
#  Fireworm's cpuminer is running under a service I created called cpuminerd
hostname=$(hostname)

result=$(systemctl status cpuminerd | grep "Active" | grep "running")

if [ $? -eq 0 ]; then
   echo "true"
	exit 0
else
   echo "false"
	exit 1
fi
