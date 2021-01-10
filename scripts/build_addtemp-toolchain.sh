#!/bin/bash

#Chapter 7. Entering Chroot and Building Additional Temporary Tools

# 7.7. Libstdc++ from GCC-10.2.0, Pass 2
/alfs/toolchain/libstdc-pass-2.sh
# 7.8. Gettext-0.21
/alfs/toolchain/gettext.sh
# 7.9. Bison-3.7.1
/alfs/toolchain/bison.sh
# 7.10. Perl-5.32.0
/alfs/toolchain/perl.sh
# 7.11. Python-3.8.5
/alfs/toolchain/python.sh
# 7.12. Texinfo-6.7
/alfs/toolchain/texinfo.sh
# 7.13. Util-linux-2.36
/alfs/toolchain/util-linux.sh

# 7.14. Cleaning up and Saving the Temporary System
find /usr/{lib,libexec} -name \*.la -delete
rm -rf /usr/share/{info,man,doc}/*

