#!/bin/bash

if [ "$(whoami)" != "lfs" ]; then
        echo "Script must be run as user: lfs"
        exit 255
fi

cd $LFS/sources

tar xvf sed-4.8.tar.xz

cd sed-4.8

./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --bindir=/bin

make

make DESTDIR=$LFS install

cd $LFS/sources

rm -rf sed-4.8

echo "Done"

