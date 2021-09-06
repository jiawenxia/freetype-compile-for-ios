#/bin/bash
SCRIPT_PATH=`dirname $0`
if [[ "$NDK_STANDALONE_TOOLCHAIN" == "" ]]; then
    if [[ "$NDK" == "" ]]; then
        echo "You should set the NDK environment variable!"
        exit 1
    fi
export NDK_STANDALONE_TOOLCHAIN=$NDK
fi

buildFolder="$SCRIPT_PATH""/build-Android"
rm -r $buildFolder
mkdir -p $buildFolder && cd $buildFolder
#armeabi-v7a  arm64-v8a
cmake -DCMAKE_TOOLCHAIN_FILE=$NDK_STANDALONE_TOOLCHAIN/build/cmake/android.toolchain.cmake \
    -DANDROID_ABI=armeabi-v7a \
    -DANDROID_ARM_NEON=TRUE \
    -DANDROID_ARM_MODE=arm \
    -DANDROID_STL=c++_static \
    -DANDROID_NDK=$ANDROID_NDK \
    -DANDROID_PLATFORM=android-21 \
    -DANDROID_TOOLCHAIN=clang \
    -DRUN_EDITOR=FALSE \
    -DPLATFORM=Android \
    -DCMAKE_BUILD_TYPE=Release \
    -DBUILD_SHARED_LIBS=true \
    ..

make -j6
cd ..