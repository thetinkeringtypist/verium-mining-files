#!/bin/sh -e
#
#! Script to configure the gpu frequencies on the system at startup

#! Set the governor
echo "powersave" \
	| tee /sys/devices/platform/11800000.mali/devfreq/devfreq0/governor \
	1>/dev/null

#! Set the lower bound
echo "177000000" \
	| tee /sys/devices/platform/11800000.mali/devfreq/devfreq0/min_freq \
	1>/dev/null

#! Set the upper bound
echo "177000000" \
	| tee /sys/devices/platform/11800000.mali/devfreq/devfreq0/max_freq \
	1>/dev/null
