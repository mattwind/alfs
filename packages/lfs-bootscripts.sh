#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=lfs-bootscripts-20200818.tar.xz
SRC_FOLDER=lfs-bootscripts-20200818

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD

make install

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
