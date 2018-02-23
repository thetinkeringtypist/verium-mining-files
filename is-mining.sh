#!/bin/bash
#
#! Script to determine if the miner is running
hostname=$(hostname)

result=$(systemctl status minerd | grep "Active" | grep "running")

if [ $? -eq 0 ]; then
   echo "true"
else
   echo "false"
fi
