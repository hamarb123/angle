#!/bin/bash
cd "$(dirname "$0")"
rm -R ./out/upload || true

mkdir ./out/upload
mkdir ./out/upload/mac_x64
mkdir ./out/upload/mac_x64_checked
mkdir ./out/upload/mac_x64_debug
mkdir ./out/upload/mac_arm64
mkdir ./out/upload/mac_arm64_checked
mkdir ./out/upload/mac_arm64_debug
mkdir ./out/upload/mac_combined
mkdir ./out/upload/mac_combined_checked
mkdir ./out/upload/mac_combined_debug

cp ./out/Release_x64/libEGL.dylib ./out/upload/mac_x64/libEGL.dylib
cp ./out/Release_x64/libGLESv2.dylib ./out/upload/mac_x64/libGLESv2.dylib
cp ./out/Release_x64/libGLESv1_CM.dylib ./out/upload/mac_x64/libGLESv1_CM.dylib

cp ./out/Release_arm64/libEGL.dylib ./out/upload/mac_arm64/libEGL.dylib
cp ./out/Release_arm64/libGLESv2.dylib ./out/upload/mac_arm64/libGLESv2.dylib
cp ./out/Release_arm64/libGLESv1_CM.dylib ./out/upload/mac_arm64/libGLESv1_CM.dylib

lipo -create ./out/upload/mac_x64/libEGL.dylib ./out/upload/mac_arm64/libEGL.dylib -output ./out/upload/mac_combined/libEGL.dylib
lipo -create ./out/upload/mac_x64/libGLESv2.dylib ./out/upload/mac_arm64/libGLESv2.dylib -output ./out/upload/mac_combined/libGLESv2.dylib
lipo -create ./out/upload/mac_x64/libGLESv1_CM.dylib ./out/upload/mac_arm64/libGLESv1_CM.dylib -output ./out/upload/mac_combined/libGLESv1_CM.dylib

cp ./out/Checked_x64/libEGL.dylib ./out/upload/mac_x64_checked/libEGL.dylib
cp ./out/Checked_x64/libGLESv2.dylib ./out/upload/mac_x64_checked/libGLESv2.dylib
cp ./out/Checked_x64/libGLESv1_CM.dylib ./out/upload/mac_x64_checked/libGLESv1_CM.dylib

cp ./out/Checked_arm64/libEGL.dylib ./out/upload/mac_arm64_checked/libEGL.dylib
cp ./out/Checked_arm64/libGLESv2.dylib ./out/upload/mac_arm64_checked/libGLESv2.dylib
cp ./out/Checked_arm64/libGLESv1_CM.dylib ./out/upload/mac_arm64_checked/libGLESv1_CM.dylib

lipo -create ./out/upload/mac_x64_checked/libEGL.dylib ./out/upload/mac_arm64_checked/libEGL.dylib -output ./out/upload/mac_combined_checked/libEGL.dylib
lipo -create ./out/upload/mac_x64_checked/libGLESv2.dylib ./out/upload/mac_arm64_checked/libGLESv2.dylib -output ./out/upload/mac_combined_checked/libGLESv2.dylib
lipo -create ./out/upload/mac_x64_checked/libGLESv1_CM.dylib ./out/upload/mac_arm64_checked/libGLESv1_CM.dylib -output ./out/upload/mac_combined_checked/libGLESv1_CM.dylib

cp ./out/Debug_x64/libEGL.dylib ./out/upload/mac_x64_debug/libEGL.dylib
cp ./out/Debug_x64/libGLESv2.dylib ./out/upload/mac_x64_debug/libGLESv2.dylib
cp ./out/Debug_x64/libGLESv1_CM.dylib ./out/upload/mac_x64_debug/libGLESv1_CM.dylib

cp ./out/Debug_arm64/libEGL.dylib ./out/upload/mac_arm64_debug/libEGL.dylib
cp ./out/Debug_arm64/libGLESv2.dylib ./out/upload/mac_arm64_debug/libGLESv2.dylib
cp ./out/Debug_arm64/libGLESv1_CM.dylib ./out/upload/mac_arm64_debug/libGLESv1_CM.dylib

lipo -create ./out/upload/mac_x64_debug/libEGL.dylib ./out/upload/mac_arm64_debug/libEGL.dylib -output ./out/upload/mac_combined_debug/libEGL.dylib
lipo -create ./out/upload/mac_x64_debug/libGLESv2.dylib ./out/upload/mac_arm64_debug/libGLESv2.dylib -output ./out/upload/mac_combined_debug/libGLESv2.dylib
lipo -create ./out/upload/mac_x64_debug/libGLESv1_CM.dylib ./out/upload/mac_arm64_debug/libGLESv1_CM.dylib -output ./out/upload/mac_combined_debug/libGLESv1_CM.dylib

#they appear to already stripped

strip -x ./out/upload/mac_x64/libEGL.dylib
strip -x ./out/upload/mac_x64/libGLESv2.dylib
strip -x ./out/upload/mac_x64/libGLESv1_CM.dylib

strip -x ./out/upload/mac_arm64/libEGL.dylib
strip -x ./out/upload/mac_arm64/libGLESv2.dylib
strip -x ./out/upload/mac_arm64/libGLESv1_CM.dylib

strip -x ./out/upload/mac_combined/libEGL.dylib
strip -x ./out/upload/mac_combined/libGLESv2.dylib
strip -x ./out/upload/mac_combined/libGLESv1_CM.dylib

mkdir ./out/upload/mac_x64/symbols
mkdir ./out/upload/mac_arm64/symbols

cp -R ./out/Release_x64/libEGL.dylib.dSYM ./out/upload/mac_x64/symbols/libEGL.dylib.dSYM
cp -R ./out/Release_x64/libGLESv2.dylib.dSYM ./out/upload/mac_x64/symbols/libGLESv2.dylib.dSYM
cp -R ./out/Release_x64/libGLESv1_CM.dylib.dSYM ./out/upload/mac_x64/symbols/libGLESv1_CM.dylib.dSYM

cp -R ./out/Release_arm64/libEGL.dylib.dSYM ./out/upload/mac_arm64/symbols/libEGL.dylib.dSYM
cp -R ./out/Release_arm64/libGLESv2.dylib.dSYM ./out/upload/mac_arm64/symbols/libGLESv2.dylib.dSYM
cp -R ./out/Release_arm64/libGLESv1_CM.dylib.dSYM ./out/upload/mac_arm64/symbols/libGLESv1_CM.dylib.dSYM

pushd ./out/upload/mac_x64
zip ../mac_x64.zip libEGL.dylib libGLESv2.dylib
zip ../mac_x64_extra_gles1.zip libGLESv1_CM.dylib
pushd symbols
zip -r ../../mac_x64_symbols.zip libEGL.dylib.dSYM libGLESv2.dylib.dSYM libGLESv1_CM.dylib.dSYM
popd
popd

pushd ./out/upload/mac_arm64
zip ../mac_arm64.zip libEGL.dylib libGLESv2.dylib
zip ../mac_arm64_extra_gles1.zip libGLESv1_CM.dylib
pushd symbols
zip -r ../../mac_arm64_symbols.zip libEGL.dylib.dSYM libGLESv2.dylib.dSYM libGLESv1_CM.dylib.dSYM
popd
popd

pushd ./out/upload/mac_combined
zip ../mac_combined.zip libEGL.dylib libGLESv2.dylib
zip ../mac_combined_extra_gles1.zip libGLESv1_CM.dylib
popd

pushd ./out/upload/mac_x64_checked
zip ../mac_x64_checked.zip libEGL.dylib libGLESv2.dylib libGLESv1_CM.dylib
popd

pushd ./out/upload/mac_arm64_checked
zip ../mac_arm64_checked.zip libEGL.dylib libGLESv2.dylib libGLESv1_CM.dylib
popd

pushd ./out/upload/mac_combined_checked
zip ../mac_combined_checked.zip libEGL.dylib libGLESv2.dylib libGLESv1_CM.dylib
popd

pushd ./out/upload/mac_x64_debug
zip ../mac_x64_debug.zip libEGL.dylib libGLESv2.dylib libGLESv1_CM.dylib
popd

pushd ./out/upload/mac_arm64_debug
zip ../mac_arm64_debug.zip libEGL.dylib libGLESv2.dylib libGLESv1_CM.dylib
popd

pushd ./out/upload/mac_combined_debug
zip ../mac_combined_debug.zip libEGL.dylib libGLESv2.dylib libGLESv1_CM.dylib
popd
