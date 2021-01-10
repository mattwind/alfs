#!/bin/bash

if [ "$(whoami)" != "lfs" ]; then
        echo "Script must be run as user: lfs"
        exit 255
fi

cd $LFS/sources

tar xvf binutils-2.35.tar.xz

cd binutils-2.35

mkdir -v build
cd       build

../configure --prefix=$LFS/tools       \
             --with-sysroot=$LFS        \
             --target=$LFS_TGT          \
             --disable-nls              \
             --disable-werror
             
make

make install             

cd $LFS/sources

rm -rf binutils-2.35

echo "Done"