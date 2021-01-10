#!/bin/bash

# Quick way to enter your LFS
# set your partition with LFS

PART=$1

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
echo lfs_chroot > $LFS/etc/lfs_chroot
chroot $LFS /bin/bash
umount $LFS/{proc,sys,dev}
rm -rf $LFS/etc/lfs_chroot
echo
echo "Exited chroot."
echo
