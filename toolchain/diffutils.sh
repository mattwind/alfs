#!/bin/bash

if [ "$(whoami)" != "lfs" ]; then
        echo "Script must be run as user: lfs"
        exit 255
fi

cd $LFS/sources

tar xvf diffutils-3.7.tar.xz

cd diffutils-3.7

./configure --prefix=/usr --host=$LFS_TGT

make

make DESTDIR=$LFS install

cd $LFS/sources

rm -rf diffutils-3.7

echo "Done"

