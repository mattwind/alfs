#!/bin/bash

# 8.3. Man-pages-5.08
/alfs/packages/man-pages.sh
/alfs/packages/tcl.sh
/alfs/packages/expect.sh
/alfs/packages/dejagnu.sh
/alfs/packages/iana-etc.sh
/alfs/packages/glibc.sh
/alfs/packages/zlib.sh
/alfs/packages/bzip2.sh
/alfs/packages/xz.sh
/alfs/packages/zstd.sh
/alfs/packages/file.sh
/alfs/packages/readline.sh
/alfs/packages/m4.sh
/alfs/packages/bc.sh
/alfs/packages/flex.sh
/alfs/packages/binutils.sh
/alfs/packages/gmp.sh
/alfs/packages/mpfr.sh
/alfs/packages/mpc.sh
/alfs/packages/attr.sh
/alfs/packages/acl.sh
/alfs/packages/libcap.sh
/alfs/packages/shadow.sh
/alfs/packages/gcc.sh
/alfs/packages/pkg-config.sh
/alfs/packages/ncurses.sh
/alfs/packages/sed.sh
/alfs/packages/psmisc.sh
/alfs/packages/gettext.sh
/alfs/packages/bison.sh
/alfs/packages/grep.sh
/alfs/packages/bash.sh
/alfs/packages/libtool.sh
/alfs/packages/gdbm.sh
/alfs/packages/gpref.sh
/alfs/packages/expat.sh
/alfs/packages/inetutils.sh
/alfs/packages/perl.sh
/alfs/packages/xml-parser.sh
/alfs/packages/intltool.sh
/alfs/packages/autoconf.sh
/alfs/packages/automake.sh
/alfs/packages/kmod.sh
/alfs/packages/libelf.sh
/alfs/packages/libffi.sh
/alfs/packages/openssl.sh
/alfs/packages/python.sh
/alfs/packages/ninja.sh
/alfs/packages/meson.sh
/alfs/packages/coreutils.sh
/alfs/packages/check.sh
/alfs/packages/diffutils.sh
/alfs/packages/gawk.sh
/alfs/packages/findutils.sh
/alfs/packages/groff.sh
/alfs/packages/grub.sh
/alfs/packages/less.sh
/alfs/packages/gzip.sh
/alfs/packages/iproute2.sh
/alfs/packages/kbd.sh
/alfs/packages/libpipeline.sh
/alfs/packages/make.sh
/alfs/packages/patch.sh
/alfs/packages/man-db.sh
/alfs/packages/tar.sh
/alfs/packages/texinfo.sh
/alfs/packages/vim.sh
/alfs/packages/eudev.sh
/alfs/packages/procps-ng.sh
/alfs/packages/util-linux.sh
/alfs/packages/e2fsprogs.sh
/alfs/packages/sysklogd.sh
/alfs/packages/sysvinit.sh

# 8.77. Stripping Again

save_lib="ld-2.32.so libc-2.32.so libpthread-2.32.so libthread_db-1.0.so"

cd /lib

for LIB in $save_lib; do
    objcopy --only-keep-debug $LIB $LIB.dbg 
    strip --strip-unneeded $LIB
    objcopy --add-gnu-debuglink=$LIB.dbg $LIB 
done    

save_usrlib="libquadmath.so.0.0.0 libstdc++.so.6.0.28
             libitm.so.1.0.0 libatomic.so.1.2.0" 

cd /usr/lib

for LIB in $save_usrlib; do
    objcopy --only-keep-debug $LIB $LIB.dbg
    strip --strip-unneeded $LIB
    objcopy --add-gnu-debuglink=$LIB.dbg $LIB
done

unset LIB save_lib save_usrlib

find /usr/lib -type f -name \*.a \
   -exec strip --strip-debug {} ';'

find /lib /usr/lib -type f -name \*.so* ! -name \*dbg \
   -exec strip --strip-unneeded {} ';'

find /{bin,sbin} /usr/{bin,sbin,libexec} -type f \
    -exec strip --strip-all {} ';'

# 8.78. Cleaning Up

rm -rf /tmp/*

exit
