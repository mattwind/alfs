#!/bin/bash

if [ "$(whoami)" != "lfs" ]; then
        echo "Script must be run as user: lfs"
        exit 255
fi

cd $LFS/sources

tar xvf tar-1.32.tar.xz

cd tar-1.32

./configure --prefix=/usr                     \
            --host=$LFS_TGT                   \
            --build=$(build-aux/config.guess) \
            --bindir=/bin

make

make DESTDIR=$LFS install

cd $LFS/sources

rm -rf tar-1.32

echo "Done"

