#!/bin/bash

set -e

output_dir="${HOME}/Desktop/freetype.ios"
min_iphoneos="7.0"
AR_POS="/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ar"

green='\033[38;5;82m'
ngreen='\033[0m'
info='\033[38;5;2m'
ninfo='\033[0m'

export CC=$CC_POS

ARCH="x86_64"
export CFLAGS="-arch ${ARCH} -pipe -Wno-trigraphs -fpascal-strings -O2 -Wreturn-type -Wunused-variable -fmessage-length=0 -fvisibility=hidden -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"

# export CPPFLAGS="-D__IPHONE_OS_VERSION_MIN_REQUIRED=${IPHONEOS_DEPLOYMENT_TARGET%%.*}0000"
export LDFLAGS="-arch ${ARCH} -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk"
./configure --without-zlib --without-png --without-bzip2 --disable-shared --enable-static --host="${ARCH}-apple-darwin13"
make clean
make
mkdir -p $output_dir && cp objs/.libs/libfreetype.a "$output_dir/libfreetype-${ARCH}.a"
S3="$ARCH"


echo -e "\n $green Success: $S0 $S3 $ngreen"

lipo -create "$output_dir/libfreetype-x86_64.a"

echo -e "\n $info $lipolog $ninfo"
echo -e "\n $green Completed! $ngreen"
