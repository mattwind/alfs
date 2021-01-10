#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=zstd-1.4.5.tar.gz
SRC_FOLDER=zstd-1.4.5

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD 

make

make prefix=/usr install

rm -v /usr/lib/libzstd.a
mv -v /usr/lib/libzstd.so.* /lib
ln -sfv ../../lib/$(readlink /usr/lib/libzstd.so) /usr/lib/libzstd.so

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE

