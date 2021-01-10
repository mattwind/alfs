#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=autoconf-2.69.tar.xz
SRC_FOLDER=autoconf-2.69

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD

sed -i '361 s/{/\\{/' bin/autoscan.in

./configure --prefix=/usr

make
#make check
make install

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
