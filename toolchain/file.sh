#!/bin/bash

if [ "$(whoami)" != "lfs" ]; then
        echo "Script must be run as user: lfs"
        exit 255
fi

cd $LFS/sources

tar xvf file-5.39.tar.gz

cd file-5.39

./configure --prefix=/usr --host=$LFS_TGT

make

make DESTDIR=$LFS install

cd $LFS/sources

rm -rf file-5.39

echo "Done"

