#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=wget-1.21.tar.gz
SRC_FOLDER=wget-1.21

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD 

./configure --prefix=/usr      \
            --sysconfdir=/etc  \
            --with-ssl=openssl &&
make
make install

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE

