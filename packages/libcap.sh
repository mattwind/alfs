#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=libcap-2.42.tar.xz
SRC_FOLDER=libcap-2.42

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD 

sed -i '/install -m.*STACAPLIBNAME/d' libcap/Makefile

make lib=lib

#make test

make lib=lib PKGCONFIGDIR=/usr/lib/pkgconfig install
chmod -v 755 /lib/libcap.so.2.42
mv -v /lib/libpsx.a /usr/lib
rm -v /lib/libcap.so
ln -sfv ../../lib/libcap.so.2 /usr/lib/libcap.so

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
