#!/bin/bash

if [ "$(whoami)" != "lfs" ]; then
        echo "Script must be run as user: lfs"
        exit 255
fi

cd $LFS/sources

tar xvf linux-5.8.3.tar.xz

cd linux-5.8.3

make mrproper

make headers

find usr/include -name '.*' -delete
rm usr/include/Makefile
cp -rv usr/include $LFS/usr

cd $LFS/sources

rm -rf linux-5.8.3

echo "Done"

