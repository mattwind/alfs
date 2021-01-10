#!/bin/bash

if [ "$(whoami)" != "lfs" ]; then
        echo "Script must be run as user: lfs"
        exit 255
fi

cd $LFS/sources

tar xvf grep-3.4.tar.xz

cd grep-3.4

./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --bindir=/bin

make

make DESTDIR=$LFS install

cd $LFS/sources

rm -rf grep-3.4

echo "Done"

