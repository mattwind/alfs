#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=tar-1.32.tar.xz
SRC_FOLDER=tar-1.32

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD

FORCE_UNSAFE_CONFIGURE=1  \
./configure --prefix=/usr \
            --bindir=/bin

make
#make check
make install
make -C doc install-html docdir=/usr/share/doc/tar-1.32

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
