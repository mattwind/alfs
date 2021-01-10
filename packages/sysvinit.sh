#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=sysvinit-2.97.tar.xz
SRC_FOLDER=sysvinit-2.97

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD

patch -Np1 -i ../sysvinit-2.97-consolidated-1.patch
make
make install

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
