#!/bin/bash
# https://www.nongnu.org/avr-libc/user-manual/install_tools.html#install_avr_binutils

# Make AVR-Binutils
MYNAME="binutils"
echo "\n*** Making ${MYNAME} ***\n"

$PREFIX/bin/avr-objdump --version || true
VER_BIN=$($PREFIX/bin/avr-objdump --version | sed -n "/${VER_BINUTILS}/p")
if [ ! -z "$VER_BIN" ] ; then
  echo "${MYNAME} is already OK for version ${VER_BINUTILS} --> We will do nothing"
  exit 0
fi

echo "\n\nDownloading and extracting ${MYNAME} ...\n"
wget http://ftp.gnu.org/gnu/binutils/${BINUTILS}.tar.xz &&
tar xf ${BINUTILS}.tar.xz &&

echo "\n\nConfigure ${MYNAME} ...\n" &&
mkdir -p ${BINUTILS}/obj-avr && cd ${BINUTILS}/obj-avr &&
../configure --prefix="$PREFIX" --target=avr --disable-nls > /dev/null &&

echo "\n\nBuild ${MYNAME} ...\n" &&
make -j $JOBCOUNT > /dev/null &&

echo "\n\nInstall ${MYNAME} ...\n" &&
make install > /dev/null &&

cd ../../ &&
echo ""
