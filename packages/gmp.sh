#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=gmp-6.2.0.tar.xz
SRC_FOLDER=gmp-6.2.0

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD 

./configure --prefix=/usr    \
            --enable-cxx     \
            --disable-static \
            --docdir=/usr/share/doc/gmp-6.2.0

make
#make html

#make check 2>&1 | tee gmp-check-log
#awk '/# PASS:/{total+=$3} ; END{print total}' gmp-check-log

make install
#make install-html

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE

