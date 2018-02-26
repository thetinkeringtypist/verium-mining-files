#!/bin/bash
#
#! Script to start the verium miner daemons


#! Start the 3way verium miner daemon
/usr/local/bin/cpuminer-3way \
   -c /etc/cpuminer/cpuminerd-3way.conf.json \
   >> /var/log/cpuminerd/cpuminerd-3way.log 2>&1


#! Start the 1way verium miner daemon
/usr/local/bin/cpuminer-1way \
   -c /etc/cpuminer/cpuminerd-1way.conf.json \
   >> /var/log/cpuminerd/cpuminerd-1way.log 2>&1


#! Start the miner api daemon
/usr/local/bin/miner-apid.py \
   >> /var/log/cpuminerd/miner-apid.log 2>&1 &
