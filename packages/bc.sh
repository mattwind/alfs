#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=bc-3.1.5.tar.xz
SRC_FOLDER=bc-3.1.5

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD 

PREFIX=/usr CC=gcc CFLAGS="-std=c99" ./configure.sh -G -O3

make
#make test
make install

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE

