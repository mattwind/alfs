#!/bin/bash

if [ "$(whoami)" != "lfs" ]; then
        echo "Script must be run as user: lfs"
        exit 255
fi

cd $LFS/sources

tar xvf bash-5.0.tar.gz

cd bash-5.0

./configure --prefix=/usr                   \
            --build=$(support/config.guess) \
            --host=$LFS_TGT                 \
            --without-bash-malloc

make

make DESTDIR=$LFS install

mv $LFS/usr/bin/bash $LFS/bin/bash

ln -sv bash $LFS/bin/sh

cd $LFS/sources

rm -rf bash-5.0

echo "Done"

