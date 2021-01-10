#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=kbd-2.3.0.tar.xz
SRC_FOLDER=kbd-2.3.0

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD

patch -Np1 -i ../kbd-2.3.0-backspace-1.patch

sed -i '/RESIZECONS_PROGS=/s/yes/no/' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in

./configure --prefix=/usr --disable-vlock

make
#make check
make install
rm -v /usr/lib/libtswrap.{a,la,so*}

mkdir -v            /usr/share/doc/kbd-2.3.0
cp -R -v docs/doc/* /usr/share/doc/kbd-2.3.0

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
