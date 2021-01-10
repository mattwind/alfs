#!/bin/bash

cd /sources/

tar xvf util-linux-2.36.tar.xz
cd util-linux-2.36

mkdir -pv /var/lib/hwclock
./configure ADJTIME_PATH=/var/lib/hwclock/adjtime    \
            --docdir=/usr/share/doc/util-linux-2.36 \
            --disable-chfn-chsh  \
            --disable-login      \
            --disable-nologin    \
            --disable-su         \
            --disable-setpriv    \
            --disable-runuser    \
            --disable-pylibmount \
            --disable-static     \
            --without-python
make
make install

cd /sources/
rm -rf util-linux-2.36

echo "Done"
