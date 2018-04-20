#!/bin/bash
#
#! Script to capture and compress a linux image on an sdcard. This was designed
#  for ODROID XU4s, which is why there is two partitions (one for the root
#  filesystem and another for the boot filesystem). 
PROGNAME=$(basename "$0")
MOUNT_DIR="/media/$USERNAME/rootfs"
MOUNT_DIR_BOOT="/media/$USERNAME/boot"
date=$(date "+%d%b%Y")
imgdir="$HOME/sbc-images/odroid"
imgfile="$imgdir/optimized-verium-miner_$date.img"


if [ "$USER" != "root" ]; then
	echo "$PROGNAME: must run as root. Exit."
	exit
fi

if [ ! -d "$MOUNT_DIR" ]; then
	echo "$PROGNAME: sdcard not mounted. Exit."
	exit
fi


echo "Beginning defrag of $MOUNT_DIR..."
sleep 1
cd "$MOUNT_DIR"
e4defrag "$MOUNT_DIR"


echo -e "\nZeroing out free space on $MOUNT_DIR..."
dd if=/dev/zero of=./zero.dat bs=4M
sync
sleep 1
sync
rm -f ./zero.dat
sync


echo -e "\nShrinking filesystem on $MOUNT_DIR..."
sleep 1
cd "/root"
e2fsck -f /dev/mmcblk1p2
resize2fs -M "$MOUNT_DIR"


echo -e "\nManual resize of underlying partition..."
sleep 1
umount "$MOUNT_DIR" "$MOUNT_DIR_BOOT"
gparted /dev/mmcblk1


echo -e "\nCapturing image of SD card to $imgfile..."
mkdir -p "$imgdir"
dd if=/dev/mmcblk1 of="$imgfile" bs=4M conv=fsync
sync
sleep 1
sync


echo -e "\nTruncating newly created OS image..."
cd "$imgdir"
END_POINT=$(fdisk -l "$imgfile" | grep "Linux" | awk '{print $3}')
truncate -s $(((END_POINT + 1) * 512)) "$imgfile"

echo -e "\nFinished."
