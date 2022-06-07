#!/bin/bash
cd "$(dirname "$0")"
rm -R ./out/upload || true

mkdir ./out/upload
mkdir ./out/upload/mac_x64
mkdir ./out/upload/mac_x64_debug
mkdir ./out/upload/mac_arm64
mkdir ./out/upload/mac_arm64_debug
mkdir ./out/upload/mac_combined
mkdir ./out/upload/mac_combined_debug

cp ./out/Release_x64/libEGL.dylib ./out/upload/mac_x64/libEGL.dylib
cp ./out/Release_x64/libGLESv2.dylib ./out/upload/mac_x64/libGLESv2.dylib

cp ./out/Release_arm64/libEGL.dylib ./out/upload/mac_arm64/libEGL.dylib
cp ./out/Release_arm64/libGLESv2.dylib ./out/upload/mac_arm64/libGLESv2.dylib

lipo -create ./out/upload/mac_x64/libEGL.dylib ./out/upload/mac_arm64/libEGL.dylib -output ./out/upload/mac_combined/libEGL.dylib
lipo -create ./out/upload/mac_x64/libGLESv2.dylib ./out/upload/mac_arm64/libGLESv2.dylib -output ./out/upload/mac_combined/libGLESv2.dylib

cp ./out/Debug_x64/libEGL.dylib ./out/upload/mac_x64_debug/libEGL.dylib
cp ./out/Debug_x64/libGLESv2.dylib ./out/upload/mac_x64_debug/libGLESv2.dylib

cp ./out/Debug_arm64/libEGL.dylib ./out/upload/mac_arm64_debug/libEGL.dylib
cp ./out/Debug_arm64/libGLESv2.dylib ./out/upload/mac_arm64_debug/libGLESv2.dylib

lipo -create ./out/upload/mac_x64_debug/libEGL.dylib ./out/upload/mac_arm64_debug/libEGL.dylib -output ./out/upload/mac_combined_debug/libEGL.dylib
lipo -create ./out/upload/mac_x64_debug/libGLESv2.dylib ./out/upload/mac_arm64_debug/libGLESv2.dylib -output ./out/upload/mac_combined_debug/libGLESv2.dylib

mkdir ./out/upload/mac_x64/unstripped
mkdir ./out/upload/mac_arm64/unstripped
mkdir ./out/upload/mac_combined/unstripped

cp ./out/upload/mac_x64/libEGL.dylib ./out/upload/mac_x64/unstripped/libEGL.dylib
cp ./out/upload/mac_x64/libGLESv2.dylib ./out/upload/mac_x64/unstripped/libGLESv2.dylib

cp ./out/upload/mac_arm64/libEGL.dylib ./out/upload/mac_arm64/unstripped/libEGL.dylib
cp ./out/upload/mac_arm64/libGLESv2.dylib ./out/upload/mac_arm64/unstripped/libGLESv2.dylib

cp ./out/upload/mac_combined/libEGL.dylib ./out/upload/mac_combined/unstripped/libEGL.dylib
cp ./out/upload/mac_combined/libGLESv2.dylib ./out/upload/mac_combined/unstripped/libGLESv2.dylib

strip -x ./out/upload/mac_x64/libEGL.dylib
strip -x ./out/upload/mac_x64/libGLESv2.dylib

strip -x ./out/upload/mac_arm64/libEGL.dylib
strip -x ./out/upload/mac_arm64/libGLESv2.dylib

strip -x ./out/upload/mac_combined/libEGL.dylib
strip -x ./out/upload/mac_combined/libGLESv2.dylib

pushd ./out/upload/mac_x64
zip ../mac_x64.zip libEGL.dylib libGLESv2.dylib
pushd unstripped
zip ../../mac_x64_unstripped.zip libEGL.dylib libGLESv2.dylib
popd
popd

pushd ./out/upload/mac_arm64
zip ../mac_arm64.zip libEGL.dylib libGLESv2.dylib
pushd unstripped
zip ../../mac_arm64_unstripped.zip libEGL.dylib libGLESv2.dylib
popd
popd

pushd ./out/upload/mac_combined
zip ../mac_combined.zip libEGL.dylib libGLESv2.dylib
pushd unstripped
zip ../../mac_combined_unstripped.zip libEGL.dylib libGLESv2.dylib
popd
popd

pushd ./out/upload/mac_x64_debug
zip ../mac_x64_debug.zip libEGL.dylib libGLESv2.dylib
popd

pushd ./out/upload/mac_arm64_debug
zip ../mac_arm64_debug.zip libEGL.dylib libGLESv2.dylib
popd

pushd ./out/upload/mac_combined_debug
zip ../mac_combined_debug.zip libEGL.dylib libGLESv2.dylib
popd

#this file is not uploaded: mac_combined_debug.zip
