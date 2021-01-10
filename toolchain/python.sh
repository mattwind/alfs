#!/bin/bash

cd /sources/

tar xvf Python-3.8.5.tar.xz
cd Python-3.8.5

./configure --prefix=/usr   \
            --enable-shared \
            --without-ensurepip
make
make install

cd /sources/
rm -rf Python-3.8.5

echo "Done"
