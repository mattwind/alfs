#!/bin/bash

cd /sources/

tar xvf bison-3.7.1.tar.xz
cd bison-3.7.1

./configure --prefix=/usr \
            --docdir=/usr/share/doc/bison-3.7.1
make
make install

cd /sources/
rm -rf bison-3.7.1

echo "Done"
