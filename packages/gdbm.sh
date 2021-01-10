#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=gdbm-1.18.1.tar.gz
SRC_FOLDER=gdbm-1.18.1

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD

sed -r -i '/^char.*parseopt_program_(doc|args)/d' src/parseopt.c

./configure --prefix=/usr    \
            --disable-static \
            --enable-libgdbm-compat

make
#make check
make install

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
