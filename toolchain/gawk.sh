#!/bin/bash

if [ "$(whoami)" != "lfs" ]; then
        echo "Script must be run as user: lfs"
        exit 255
fi

cd $LFS/sources

tar xvf gawk-5.1.0.tar.xz

cd gawk-5.1.0

sed -i 's/extras//' Makefile.in

./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(./config.guess)

make

make DESTDIR=$LFS install

cd $LFS/sources

rm -rf gawk-5.1.0

echo "Done"

