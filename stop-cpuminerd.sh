#!/bin/sh -e
#
#! Script to stop the verium miner daemons
pkill --signal SIGTERM cpuminer-1way
pkill --signal SIGTERM cpuminer-3way
pkill --signal SIGTERM -f miner-apid
