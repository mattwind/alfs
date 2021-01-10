#!/bin/bash

# QEMU to test LFS system
# set drive LFS is installed on

# lsusb and find bus and device number
#  -usb -device usb-host,hostbus=2,hostaddr=7 \

# ssh, if you decide to go blfs
# connect from local host
# ssh username@localhost -p10022

MEMORY=1G
DRIVE=$1

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [ -z ${LFS} ]
  then echo "LFS is not defined. example; export LFS=/mnt/lfs; sudo -E ./qemu.sh /dev/sdb"
  exit
fi

if [ -z ${DRIVE} ]
  then echo "No drive defined. example; sudo -E ./qemu.sh /dev/sdb"
  exit
fi

qemu-system-x86_64		\
	-enable-kvm		\
	-curses			\
  -net user,hostfwd=tcp::10022-:22 \
  -net nic \
	-m $MEMORY		\
	-cpu host		\
	-boot d			\
	-drive format=raw,file=$DRIVE
