#!/bin/bash
cd "$(dirname "$0")"
rm -R ./out/upload || true

mkdir ./out/upload
mkdir ./out/upload/android_x64
mkdir ./out/upload/android_x64/unstripped
mkdir ./out/upload/android_x64_checked
mkdir ./out/upload/android_x64_checked/unstripped
mkdir ./out/upload/android_x64_debug
mkdir ./out/upload/android_x64_debug/unstripped
mkdir ./out/upload/android_arm64
mkdir ./out/upload/android_arm64/unstripped
mkdir ./out/upload/android_arm64_checked
mkdir ./out/upload/android_arm64_checked/unstripped
mkdir ./out/upload/android_arm64_debug
mkdir ./out/upload/android_arm64_debug/unstripped

cp ./out/Release_x64/libEGL_angle.so ./out/upload/android_x64/libEGL_angle.so
cp ./out/Release_x64/libGLESv2_angle.so ./out/upload/android_x64/libGLESv2_angle.so
cp ./out/Release_x64/libGLESv1_CM_angle.so ./out/upload/android_x64/libGLESv1_CM_angle.so

cp ./out/Release_x64/lib.unstripped/libEGL_angle.so ./out/upload/android_x64/unstripped/libEGL_angle.so
cp ./out/Release_x64/lib.unstripped/libGLESv2_angle.so ./out/upload/android_x64/unstripped/libGLESv2_angle.so
cp ./out/Release_x64/lib.unstripped/libGLESv1_CM_angle.so ./out/upload/android_x64/unstripped/libGLESv1_CM_angle.so

cp ./out/Release_arm64/libEGL_angle.so ./out/upload/android_arm64/libEGL_angle.so
cp ./out/Release_arm64/libGLESv2_angle.so ./out/upload/android_arm64/libGLESv2_angle.so
cp ./out/Release_arm64/libGLESv1_CM_angle.so ./out/upload/android_arm64/libGLESv1_CM_angle.so

cp ./out/Release_arm64/lib.unstripped/libEGL_angle.so ./out/upload/android_arm64/unstripped/libEGL_angle.so
cp ./out/Release_arm64/lib.unstripped/libGLESv2_angle.so ./out/upload/android_arm64/unstripped/libGLESv2_angle.so
cp ./out/Release_arm64/lib.unstripped/libGLESv1_CM_angle.so ./out/upload/android_arm64/unstripped/libGLESv1_CM_angle.so

cp ./out/Checked_x64/libEGL_angle.so ./out/upload/android_x64_checked/libEGL_angle.so
cp ./out/Checked_x64/libGLESv2_angle.so ./out/upload/android_x64_checked/libGLESv2_angle.so
cp ./out/Checked_x64/libGLESv1_CM_angle.so ./out/upload/android_x64_checked/libGLESv1_CM_angle.so

cp ./out/Checked_x64/lib.unstripped/libEGL_angle.so ./out/upload/android_x64_checked/unstripped/libEGL_angle.so
cp ./out/Checked_x64/lib.unstripped/libGLESv2_angle.so ./out/upload/android_x64_checked/unstripped/libGLESv2_angle.so
cp ./out/Checked_x64/lib.unstripped/libGLESv1_CM_angle.so ./out/upload/android_x64_checked/unstripped/libGLESv1_CM_angle.so

cp ./out/Checked_arm64/libEGL_angle.so ./out/upload/android_arm64_checked/libEGL_angle.so
cp ./out/Checked_arm64/libGLESv2_angle.so ./out/upload/android_arm64_checked/libGLESv2_angle.so
cp ./out/Checked_arm64/libGLESv1_CM_angle.so ./out/upload/android_arm64_checked/libGLESv1_CM_angle.so

cp ./out/Checked_arm64/lib.unstripped/libEGL_angle.so ./out/upload/android_arm64_checked/unstripped/libEGL_angle.so
cp ./out/Checked_arm64/lib.unstripped/libGLESv2_angle.so ./out/upload/android_arm64_checked/unstripped/libGLESv2_angle.so
cp ./out/Checked_arm64/lib.unstripped/libGLESv1_CM_angle.so ./out/upload/android_arm64_checked/unstripped/libGLESv1_CM_angle.so

cp ./out/Debug_x64/libEGL_angle.so ./out/upload/android_x64_debug/libEGL_angle.so
cp ./out/Debug_x64/libGLESv2_angle.so ./out/upload/android_x64_debug/libGLESv2_angle.so
cp ./out/Debug_x64/libGLESv1_CM_angle.so ./out/upload/android_x64_debug/libGLESv1_CM_angle.so

cp ./out/Debug_x64/lib.unstripped/libEGL_angle.so ./out/upload/android_x64_debug/unstripped/libEGL_angle.so
cp ./out/Debug_x64/lib.unstripped/libGLESv2_angle.so ./out/upload/android_x64_debug/unstripped/libGLESv2_angle.so
cp ./out/Debug_x64/lib.unstripped/libGLESv1_CM_angle.so ./out/upload/android_x64_debug/unstripped/libGLESv1_CM_angle.so

cp ./out/Debug_arm64/libEGL_angle.so ./out/upload/android_arm64_debug/libEGL_angle.so
cp ./out/Debug_arm64/libGLESv2_angle.so ./out/upload/android_arm64_debug/libGLESv2_angle.so
cp ./out/Debug_arm64/libGLESv1_CM_angle.so ./out/upload/android_arm64_debug/libGLESv1_CM_angle.so

cp ./out/Debug_arm64/lib.unstripped/libEGL_angle.so ./out/upload/android_arm64_debug/unstripped/libEGL_angle.so
cp ./out/Debug_arm64/lib.unstripped/libGLESv2_angle.so ./out/upload/android_arm64_debug/unstripped/libGLESv2_angle.so
cp ./out/Debug_arm64/lib.unstripped/libGLESv1_CM_angle.so ./out/upload/android_arm64_debug/unstripped/libGLESv1_CM_angle.so

pushd ./out/upload/android_x64
zip ../android_x64.zip libEGL_angle.so libGLESv2_angle.so
zip ../android_x64_extra_gles1.zip libGLESv1_CM_angle.so
pushd unstripped
zip ../../android_x64_unstripped.zip libEGL_angle.so libGLESv2_angle.so libGLESv1_CM_angle.so
popd
popd

pushd ./out/upload/android_arm64
zip ../android_arm64.zip libEGL_angle.so libGLESv2_angle.so
zip ../android_arm64_extra_gles1.zip libGLESv1_CM_angle.so
pushd unstripped
zip ../../android_arm64_unstripped.zip libEGL_angle.so libGLESv2_angle.so libGLESv1_CM_angle.so
popd
popd

pushd ./out/upload/android_x64_checked
zip -r ../android_x64_checked.zip libEGL_angle.so libGLESv2_angle.so libGLESv1_CM_angle.so unstripped
popd

pushd ./out/upload/android_arm64_checked
zip -r ../android_arm64_checked.zip libEGL_angle.so libGLESv2_angle.so libGLESv1_CM_angle.so unstripped
popd

pushd ./out/upload/android_x64_debug
zip -r ../android_x64_debug.zip libEGL_angle.so libGLESv2_angle.so libGLESv1_CM_angle.so unstripped
popd

pushd ./out/upload/android_arm64_debug
zip -r ../android_arm64_debug.zip libEGL_angle.so libGLESv2_angle.so libGLESv1_CM_angle.so unstripped
popd
