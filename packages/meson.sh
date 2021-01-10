#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=meson-0.55.0.tar.gz
SRC_FOLDER=meson-0.55.0

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD

python3 setup.py build

python3 setup.py install --root=dest
cp -rv dest/* /

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
