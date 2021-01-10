#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=automake-1.16.2.tar.xz
SRC_FOLDER=automake-1.16.2

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD

sed -i "s/''/etags/" t/tags-lisp-space.sh

./configure --prefix=/usr --docdir=/usr/share/doc/automake-1.16.2

make
#make -j4 check
make install

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
