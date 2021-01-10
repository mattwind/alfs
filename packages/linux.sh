#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

SRC_FILE=linux-5.8.3.tar.xz
SRC_FOLDER=linux-5.8.3

cd /sources

tar xvf $SRC_FILE

cd $SRC_FOLDER

# BUILD

make mrproper

# generate config close to current running system
make defconfig
#make menuconfig
make
make modules_install

cp -v arch/x86/boot/bzImage /boot/vmlinuz-5.8.3-lfs-10.0
cp -v System.map /boot/System.map-5.8.3
cp -v .config /boot/config-5.8.3
install -d /usr/share/doc/linux-5.8.3
cp -r Documentation/* /usr/share/doc/linux-5.8.3

# 10.3.2. Configuring Linux Module Load Order

install -v -m755 -d /etc/modprobe.d
cat > /etc/modprobe.d/usb.conf << "EOF"
# Begin /etc/modprobe.d/usb.conf

install ohci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i ohci_hcd ; true
install uhci_hcd /sbin/modprobe ehci_hcd ; /sbin/modprobe -i uhci_hcd ; true

# End /etc/modprobe.d/usb.conf
EOF

# EBC

cd /sources

rm -rf $SRC_FOLDER

echo Deleting $SRC_FOLDER
echo Done with $SRC_FILE
