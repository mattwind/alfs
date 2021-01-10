#!/bin/bash

# Quick way to enter your LFS
# set your partition with LFS

PART=$1

if mount | grep /mnt/lfs > /dev/null; then
  echo
  echo "LFS mount found."
  echo
else
  echo
  echo "No LFS partition found at /mnt/lfs."
  echo
  echo "Check out README.md"
  echo
  exit
fi


if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [ -z ${LFS} ]
  then echo "LFS is not defined. example; export LFS=/mnt/lfs; sudo -E ./chroot.sh /dev/sdb1"
  exit
fi

if [ -z ${PART} ]
  then echo "No partition defined. example; sudo -E ./chroot.sh /dev/sdb1"
  exit
fi

cd /

mount -t proc proc $LFS/proc
mount -t sysfs sys $LFS/sys
mount -o bind /dev $LFS/dev

chroot "$LFS" /bin/bash -c '\
  USER=root; HOME=/root; \
  LANG=en_US.UTF-8; \
  SHELL=/bin/bash; \
  PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin; \
  MAKEFLAGS=-j`nproc` /bin/bash'

umount $LFS/{proc,sys,dev}

echo
echo "Exited chroot."
echo
