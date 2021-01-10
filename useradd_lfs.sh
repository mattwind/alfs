#!/bin/bash

# new lfs user pwd set to lfs

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
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

MAKEFLAGS=-j`nproc`

# Create LFS folders
# Set permissions

mkdir -pv $LFS/tools

chmod -v a+wt $LFS/sources

mkdir -pv $LFS/{bin,etc,lib,sbin,usr,var}
case $(uname -m) in
  x86_64) mkdir -pv $LFS/lib64 ;;
esac

# Create lfs users

groupadd lfs
useradd -s /bin/bash -g lfs -m -k /dev/null lfs

echo
echo "Please set the lfs user password"
echo

echo 'lfs:lfs' | sudo chpasswd

chown -v lfs $LFS/{usr,lib,var,etc,bin,sbin,tools,alfs}
case $(uname -m) in
  x86_64) chown -v lfs $LFS/lib64 ;;
esac

chown -v lfs $LFS/sources

cat > /home/lfs/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

cat > /home/lfs/.bashrc << "EOF"
set +h
umask 022
MAKEFLAGS=-j`nproc`
LFS=/mnt/lfs
ALFS=/mnt/lfs/alfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
export ALFS LFS LC_ALL LFS_TGT PATH MAKEFLAGS
EOF

chown lfs:lfs /home/lfs/.bash_profile
chown lfs:lfs /home/lfs/.bashrc

echo
echo "Done"
echo
