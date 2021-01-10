#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=binutils-2.35.tar.xz
SRC_FOLDER=binutils-2.35

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD 

expect -c "spawn ls"

spawn ls

sed -i '/@\tincremental_copy/d' gold/testsuite/Makefile.in

mkdir -v build
cd       build

../configure --prefix=/usr       \
             --enable-gold       \
             --enable-ld=default \
             --enable-plugins    \
             --enable-shared     \
             --disable-werror    \
             --enable-64-bit-bfd \
             --with-system-zlib

make tooldir=/usr
#make -k check
make tooldir=/usr install

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
