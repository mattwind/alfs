#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=expect5.45.4.tar.gz
SRC_FOLDER=expect5.45.4

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

./configure --prefix=/usr           \
            --with-tcl=/usr/lib     \
            --enable-shared         \
            --mandir=/usr/share/man \
            --with-tclinclude=/usr/include

make
#make test
make install
ln -svf expect5.45.4/libexpect5.45.4.so /usr/lib

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE

