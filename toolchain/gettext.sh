#!/bin/bash

cd /sources/
tar xvf gettext-0.21.tar.xz
cd gettext-0.21

./configure --disable-shared

make

cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /usr/bin

cd /sources/
rm -rf gettext-0.21

echo "Done"
