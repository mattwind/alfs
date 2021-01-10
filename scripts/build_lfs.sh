#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

if [ -z ${LFS} ]
  then echo "LFS is not defined. example; export LFS=/mnt/lfs"
  exit
fi

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

# 7.2. Changing Ownership
chown -R root:root $LFS/{usr,lib,var,etc,bin,sbin,tools,alfs}
case $(uname -m) in
  x86_64) chown -R root:root $LFS/lib64 ;;
esac

# 7.3. Preparing Virtual Kernel File Systems
mkdir -pv $LFS/{dev,proc,sys,run}

# 7.3.1. Creating Initial Device Nodes
mknod -m 600 $LFS/dev/console c 5 1
mknod -m 666 $LFS/dev/null c 1 3

# 7.3.2. Mounting and Populating /dev
mount -v --bind /dev $LFS/dev

# 7.3.3. Mounting Virtual Kernel File Systems
mount -v --bind /dev/pts $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run

if [ -h $LFS/dev/shm ]; then
  mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi

# 7.7 - 7.14

echo "Chrooting.."

chroot "$LFS" /usr/bin/env -i   \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin \
    MAKEFLAGS=-j`nproc` \
    /bin/bash --login +h -c /alfs/scripts/build_chroot.sh

umount $LFS/dev{/pts,}
umount $LFS/{sys,proc,run}

# 7.14.1. Stripping
strip --strip-debug $LFS/usr/lib/*
strip --strip-unneeded $LFS/usr/{,s}bin/*
strip --strip-unneeded $LFS/tools/bin/*

# 7.14.2. Backup
#cd $LFS &&
#tar -cJpf $HOME/lfs-temp-tools-10.0.tar.xz .

# 7.14.3. Restore
#cd $LFS &&
#rm -rf ./* &&
#tar -xpf $HOME/lfs-temp-tools-10.0.tar.xz

# (REF) 7.3.3. Mounting Virtual Kernel File Systems
mount -v --bind /dev/pts $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run

if [ -h $LFS/dev/shm ]; then
  mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi

# Building the LFS System
# Chapter 8. Installing Basic System Software

echo "Chrooting.."

chroot "$LFS" /usr/bin/env -i   \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin \
    MAKEFLAGS=-j`nproc` \
    /bin/bash --login +h -c /alfs/scripts/build_packages.sh

# 8.78. Cleaning Up

rm -f /usr/lib/lib{bfd,opcodes}.a
rm -f /usr/lib/libctf{,-nobfd}.a
rm -f /usr/lib/libbz2.a
rm -f /usr/lib/lib{com_err,e2p,ext2fs,ss}.a
rm -f /usr/lib/libltdl.a
rm -f /usr/lib/libfl.a
rm -f /usr/lib/libz.a

find /usr/lib /usr/libexec -name \*.la -delete
find /usr -depth -name $(uname -m)-lfs-linux-gnu\* | xargs rm -rf
rm -rf /tools
userdel -r tester

# Chapter 9. System Configuration

umount $LFS/dev{/pts,}
umount $LFS/{sys,proc,run}

mount -v --bind /dev/pts $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run

if [ -h $LFS/dev/shm ]; then
  mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi

chroot "$LFS" /usr/bin/env -i          \
    HOME=/root TERM="$TERM"            \
    PS1='(lfs chroot) \u:\w\$ '        \
    PATH=/bin:/usr/bin:/sbin:/usr/sbin \
    MAKEFLAGS=-j`nproc` \
    /bin/bash --login -c /alfs/scripts/config_lfs.sh

# Finished

umount $LFS/{sys,proc,run}
echo 
echo "Exiting chroot."
echo "LFS build completed."
echo
echo $LFS
echo
echo "Check out README.md for grub notes."
echo 
echo "To enter chroot; sudo -E \$ALFS/extras/chroot.sh /dev/sdb1" 
echo
