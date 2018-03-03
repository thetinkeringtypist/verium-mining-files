#!/bin/sh -e
#
#! Script to configure the cpu frequencies on the system at startup

cpufreq-set -g performance     #! Set the governor
cpufreq-set -r -c 7 -u 1.9GHz  #! Set the upper bound on the upper cores
cpufreq-set -r -c 3 -u 1.5GHz  #! Set the upper bound on the lower cores
