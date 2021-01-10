# Automated Linux From Scratch 10.0 (SysV)

Tested with Debian 10 Buster.

*This project is based on the Official LFS 10.0 Book*

http://lfs.mirror.fileplanet.com/lfs/view/10.0/

## Package Requirements

Add the following packages 

```
sudo apt install build-essential bison gawk git htop texinfo
```

Set these Enviornment Variables

```bash
export LFS=/mnt/lfs
export ALFS=/mnt/lfs/alfs
```

## LFS Partition

| :warning: wipes the /dev/sdb drive |
| --- |

Create a new ext4 parition **/dev/sdb1** (option n) and make it bootable (option a)

```bash
sudo fdisk /dev/sdb
```

Mount new ext4 partition

```bash
sudo mkdir $LFS
sudo mount -t ext4 /dev/sdb1 $LFS
```

## Prepare Host

Grab the alfs project files

```bash
sudo git clone https://github.com/mattwind/alfs.git $ALFS
cd $ALFS
```

Verify required programs

`sudo $ALFS/version_check.sh`

Download toolchain source code from wget-list

`sudo -E $ALFS/get_packages.sh`

Setup the LFS user environment

`sudo -E $ALFS/useradd_lfs.sh`

## Build Toolchain

These scripts are required to run as the new lfs user

```bash
sudo su lfs 
$ALFS/scripts/build_toolchain.sh
$ALFS/scripts/build_temp-toolchain.sh
exit
```

## Build LFS System

Run as root with environment variables set earlier

```bash
sudo -E $ALFS/scripts/build_lfs.sh
```

## Grub Bootloader

Below the warning is how I installed grub while inside the chrooted LFS system

Consider reading the LFS book for backing up your bootloader.

http://lfs.mirror.fileplanet.com/lfs/view/stable/chapter10/grub.html

| :warning: make certain you are in chroot |
| --- |


```bash
grub-install --root-directory=/ /dev/sdb
grub-mkconfig -o /boot/grub/grub.cfg
```

### Grub Tweaks

Updating grub defaults 

`vi /etc/default/grub`

Get friendly eth0 network names and qemu console on boot.

```bash
GRUB_TERMINAL=console
GRUB_CMDLINE_LINUX_DEFAULT="net.ifnames=0 biosdevname=0"
```

Remember to run *grub-mkconfig* to apply new grub default settings.

```bash
grub-mkconfig
```

## Extra Scripts

Confirm that LFS and ALFS environment variables are both set and LFS partition is mounted.

Re-enter chroot and pass partition

```bash
sudo -E $ALFS/extras/chroot.sh /dev/sdb1
```

Emulate the LFS system with qemu (pass drive)

```bash
sudo -E $ALFS/extras/qemu.sh /dev/sdb
```

## Notes

The root password in the LFS chrooted system is root.

### LFS User

The lfs user on the host system can be deleted with `sudo deluser lfs` the lfs user */home/lfs* folder can also be removed. It is only required to build the first toolchain.

### Kernel Panic

This can happen if you are trying to boot from qemu and the entry for **root=/dev/???** is not **sda** 

Simply edit `vi /boot/grub/grub.cfg` and change root references to sda1

```bash
root=/dev/sda1
```

When I am booting from my physical server I had to set it back to sdb1, because sda is my primary Debian installation.

```bash
root=/dev/sdb1
```

### References

*Linux From Scratch 10 Book*

http://lfs.mirror.fileplanet.com/lfs/view/10.0/

*Beyond Linux From Scrach 10 Book*

http://lfs.mirror.fileplanet.com/blfs/view/10.0/

*Added compressed single page versions to the books directory*

