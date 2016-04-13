#!/bin/sh
# NVIDIA specific init script

# power state
if [ -e /sys/power/state ]; then
	chmod 0666 /sys/power/state
fi

# turn off low-power core migration for now
if [ -e /sys/module/cpu_tegra3/parameters/no_lp ] ; then
	echo Y > /sys/module/cpu_tegra3/parameters/no_lp
fi

# enable CPU hot-plugging
if [ -e /sys/module/cpu_tegra3/parameters/auto_hotplug ] ; then
	echo 1 > /sys/module/cpu_tegra3/parameters/auto_hotplug
fi

# lp2 idle state
if [ -e /sys/module/cpuidle/parameters/lp2_in_idle ] ; then
	echo "Y" > /sys/module/cpuidle/parameters/lp2_in_idle
fi

# mmc read ahead size
if [ -e /sys/block/mmcblk0/queue/read_ahead_kb ]; then
	echo 2048 > /sys/block/mmcblk0/queue/read_ahead_kb
fi
if [ -e /sys/block/mmcblk1/queue/read_ahead_kb ]; then
	echo 2048 > /sys/block/mmcblk1/queue/read_ahead_kb
fi
if [ -e /sys/block/mmcblk2/queue/read_ahead_kb ]; then
	echo 2048 > /sys/block/mmcblk2/queue/read_ahead_kb
fi

exit 0
