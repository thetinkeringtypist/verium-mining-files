#!/bin/bash
#
#! Script to determine if the miner is running
#  Fireworm's cpuminer is running under a service I created called minerd
hostname=$(hostname)

result=$(systemctl status minerd | grep "Active" | grep "running")

if [ $? -eq 0 ]; then
   echo "true"
	return 0
else
   echo "false"
	return 1
fi
