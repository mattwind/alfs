#!/bin/bash

cd /sources/

tar xvf texinfo-6.7.tar.xz
cd texinfo-6.7

./configure --prefix=/usr
make
make install

cd /sources/
rm -rf texinfo-6.7

echo "Done"
