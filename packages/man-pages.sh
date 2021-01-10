#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

cd /sources

tar xvf man-pages-5.08.tar.xz

cd man-pages-5.08

make install

cd /sources

rm -rf man-pages-5.08

echo "Done"

