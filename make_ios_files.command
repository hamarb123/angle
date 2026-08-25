#!/bin/bash
cd "$(dirname "$0")"
rm -R ./out/upload || true

mkdir ./out/upload
mkdir ./out/upload/ios_arm64
mkdir ./out/upload/ios_arm64/symbols
mkdir ./out/upload/ios_arm64_checked
mkdir ./out/upload/ios_arm64_debug
mkdir ./out/upload/iossimulator_arm64
mkdir ./out/upload/iossimulator_arm64/symbols
mkdir ./out/upload/iossimulator_arm64_checked
mkdir ./out/upload/iossimulator_arm64_debug
mkdir ./out/upload/iossimulator_x64
mkdir ./out/upload/iossimulator_x64/symbols
mkdir ./out/upload/iossimulator_x64_checked
mkdir ./out/upload/iossimulator_x64_debug
mkdir ./out/upload/iossimulator_combined
mkdir ./out/upload/iossimulator_combined_checked
mkdir ./out/upload/iossimulator_combined_debug
mkdir ./out/upload/maccatalyst_arm64
mkdir ./out/upload/maccatalyst_arm64/symbols
mkdir ./out/upload/maccatalyst_arm64_checked
mkdir ./out/upload/maccatalyst_arm64_debug
mkdir ./out/upload/maccatalyst_x64
mkdir ./out/upload/maccatalyst_x64/symbols
mkdir ./out/upload/maccatalyst_x64_checked
mkdir ./out/upload/maccatalyst_x64_debug
mkdir ./out/upload/maccatalyst_combined
mkdir ./out/upload/maccatalyst_combined_checked
mkdir ./out/upload/maccatalyst_combined_debug
mkdir ./out/upload/ioslike_combined
mkdir ./out/upload/ioslike_combined_checked
mkdir ./out/upload/ioslike_combined_debug

cp -R ./out/Release_ios_arm64/libEGL.framework ./out/upload/ios_arm64/libEGL.framework
cp -R ./out/Release_ios_arm64/libGLESv2.framework ./out/upload/ios_arm64/libGLESv2.framework
cp -R ./out/Release_ios_arm64/libGLESv1_CM.framework ./out/upload/ios_arm64/libGLESv1_CM.framework

cp -R ./out/Release_simulator_arm64/libEGL.framework ./out/upload/iossimulator_arm64/libEGL.framework
cp -R ./out/Release_simulator_arm64/libGLESv2.framework ./out/upload/iossimulator_arm64/libGLESv2.framework
cp -R ./out/Release_simulator_arm64/libGLESv1_CM.framework ./out/upload/iossimulator_arm64/libGLESv1_CM.framework

cp -R ./out/Release_simulator_x64/libEGL.framework ./out/upload/iossimulator_x64/libEGL.framework
cp -R ./out/Release_simulator_x64/libGLESv2.framework ./out/upload/iossimulator_x64/libGLESv2.framework
cp -R ./out/Release_simulator_x64/libGLESv1_CM.framework ./out/upload/iossimulator_x64/libGLESv1_CM.framework

cp -R ./out/Release_catalyst_arm64/libEGL.framework ./out/upload/maccatalyst_arm64/libEGL.framework
cp -R ./out/Release_catalyst_arm64/libGLESv2.framework ./out/upload/maccatalyst_arm64/libGLESv2.framework
cp -R ./out/Release_catalyst_arm64/libGLESv1_CM.framework ./out/upload/maccatalyst_arm64/libGLESv1_CM.framework

cp -R ./out/Release_catalyst_x64/libEGL.framework ./out/upload/maccatalyst_x64/libEGL.framework
cp -R ./out/Release_catalyst_x64/libGLESv2.framework ./out/upload/maccatalyst_x64/libGLESv2.framework
cp -R ./out/Release_catalyst_x64/libGLESv1_CM.framework ./out/upload/maccatalyst_x64/libGLESv1_CM.framework

dsymutil ./out/upload/ios_arm64/libEGL.framework/libEGL -o ./out/upload/ios_arm64/symbols/libEGL.framework.dSYM
dsymutil ./out/upload/ios_arm64/libGLESv2.framework/libGLESv2 -o ./out/upload/ios_arm64/symbols/libGLESv2.framework.dSYM
dsymutil ./out/upload/ios_arm64/libGLESv1_CM.framework/libGLESv1_CM -o ./out/upload/ios_arm64/symbols/libGLESv1_CM.framework.dSYM

dsymutil ./out/upload/iossimulator_arm64/libEGL.framework/libEGL -o ./out/upload/iossimulator_arm64/symbols/libEGL.framework.dSYM
dsymutil ./out/upload/iossimulator_arm64/libGLESv2.framework/libGLESv2 -o ./out/upload/iossimulator_arm64/symbols/libGLESv2.framework.dSYM
dsymutil ./out/upload/iossimulator_arm64/libGLESv1_CM.framework/libGLESv1_CM -o ./out/upload/iossimulator_arm64/symbols/libGLESv1_CM.framework.dSYM

dsymutil ./out/upload/iossimulator_x64/libEGL.framework/libEGL -o ./out/upload/iossimulator_x64/symbols/libEGL.framework.dSYM
dsymutil ./out/upload/iossimulator_x64/libGLESv2.framework/libGLESv2 -o ./out/upload/iossimulator_x64/symbols/libGLESv2.framework.dSYM
dsymutil ./out/upload/iossimulator_x64/libGLESv1_CM.framework/libGLESv1_CM -o ./out/upload/iossimulator_x64/symbols/libGLESv1_CM.framework.dSYM

dsymutil ./out/upload/maccatalyst_arm64/libEGL.framework/Versions/A/libEGL -o ./out/upload/maccatalyst_arm64/symbols/libEGL.framework.dSYM
dsymutil ./out/upload/maccatalyst_arm64/libGLESv2.framework/Versions/A/libGLESv2 -o ./out/upload/maccatalyst_arm64/symbols/libGLESv2.framework.dSYM
dsymutil ./out/upload/maccatalyst_arm64/libGLESv1_CM.framework/Versions/A/libGLESv1_CM -o ./out/upload/maccatalyst_arm64/symbols/libGLESv1_CM.framework.dSYM

dsymutil ./out/upload/maccatalyst_x64/libEGL.framework/Versions/A/libEGL -o ./out/upload/maccatalyst_x64/symbols/libEGL.framework.dSYM
dsymutil ./out/upload/maccatalyst_x64/libGLESv2.framework/Versions/A/libGLESv2 -o ./out/upload/maccatalyst_x64/symbols/libGLESv2.framework.dSYM
dsymutil ./out/upload/maccatalyst_x64/libGLESv1_CM.framework/Versions/A/libGLESv1_CM -o ./out/upload/maccatalyst_x64/symbols/libGLESv1_CM.framework.dSYM

codesign --remove-signature ./out/upload/ios_arm64/libEGL.framework
codesign --remove-signature ./out/upload/ios_arm64/libGLESv2.framework
codesign --remove-signature ./out/upload/ios_arm64/libGLESv1_CM.framework

codesign --remove-signature ./out/upload/iossimulator_arm64/libEGL.framework
codesign --remove-signature ./out/upload/iossimulator_arm64/libGLESv2.framework
codesign --remove-signature ./out/upload/iossimulator_arm64/libGLESv1_CM.framework

codesign --remove-signature ./out/upload/iossimulator_x64/libEGL.framework
codesign --remove-signature ./out/upload/iossimulator_x64/libGLESv2.framework
codesign --remove-signature ./out/upload/iossimulator_x64/libGLESv1_CM.framework

codesign --remove-signature ./out/upload/maccatalyst_arm64/libEGL.framework
codesign --remove-signature ./out/upload/maccatalyst_arm64/libGLESv2.framework
codesign --remove-signature ./out/upload/maccatalyst_arm64/libGLESv1_CM.framework

codesign --remove-signature ./out/upload/maccatalyst_x64/libEGL.framework
codesign --remove-signature ./out/upload/maccatalyst_x64/libGLESv2.framework
codesign --remove-signature ./out/upload/maccatalyst_x64/libGLESv1_CM.framework

strip -x ./out/upload/ios_arm64/libEGL.framework/libEGL
strip -x ./out/upload/ios_arm64/libGLESv2.framework/libGLESv2
strip -x ./out/upload/ios_arm64/libGLESv1_CM.framework/libGLESv1_CM

strip -x ./out/upload/iossimulator_arm64/libEGL.framework/libEGL
strip -x ./out/upload/iossimulator_arm64/libGLESv2.framework/libGLESv2
strip -x ./out/upload/iossimulator_arm64/libGLESv1_CM.framework/libGLESv1_CM

strip -x ./out/upload/iossimulator_x64/libEGL.framework/libEGL
strip -x ./out/upload/iossimulator_x64/libGLESv2.framework/libGLESv2
strip -x ./out/upload/iossimulator_x64/libGLESv1_CM.framework/libGLESv1_CM

strip -x ./out/upload/maccatalyst_arm64/libEGL.framework/Versions/A/libEGL
strip -x ./out/upload/maccatalyst_arm64/libGLESv2.framework/Versions/A/libGLESv2
strip -x ./out/upload/maccatalyst_arm64/libGLESv1_CM.framework/Versions/A/libGLESv1_CM

strip -x ./out/upload/maccatalyst_x64/libEGL.framework/Versions/A/libEGL
strip -x ./out/upload/maccatalyst_x64/libGLESv2.framework/Versions/A/libGLESv2
strip -x ./out/upload/maccatalyst_x64/libGLESv1_CM.framework/Versions/A/libGLESv1_CM

cp -R ./out/upload/iossimulator_arm64/libEGL.framework ./out/upload/iossimulator_combined/libEGL.framework
cp -R ./out/upload/iossimulator_arm64/libGLESv2.framework ./out/upload/iossimulator_combined/libGLESv2.framework
cp -R ./out/upload/iossimulator_arm64/libGLESv1_CM.framework ./out/upload/iossimulator_combined/libGLESv1_CM.framework

cp -R ./out/upload/maccatalyst_arm64/libEGL.framework ./out/upload/maccatalyst_combined/libEGL.framework
cp -R ./out/upload/maccatalyst_arm64/libGLESv2.framework ./out/upload/maccatalyst_combined/libGLESv2.framework
cp -R ./out/upload/maccatalyst_arm64/libGLESv1_CM.framework ./out/upload/maccatalyst_combined/libGLESv1_CM.framework

lipo -create ./out/upload/iossimulator_arm64/libEGL.framework/libEGL ./out/upload/iossimulator_x64/libEGL.framework/libEGL -output ./out/upload/iossimulator_combined/libEGL.framework/libEGL
lipo -create ./out/upload/iossimulator_arm64/libGLESv2.framework/libGLESv2 ./out/upload/iossimulator_x64/libGLESv2.framework/libGLESv2 -output ./out/upload/iossimulator_combined/libGLESv2.framework/libGLESv2
lipo -create ./out/upload/iossimulator_arm64/libGLESv1_CM.framework/libGLESv1_CM ./out/upload/iossimulator_x64/libGLESv1_CM.framework/libGLESv1_CM -output ./out/upload/iossimulator_combined/libGLESv1_CM.framework/libGLESv1_CM

lipo -create ./out/upload/maccatalyst_arm64/libEGL.framework/Versions/A/libEGL ./out/upload/maccatalyst_x64/libEGL.framework/Versions/A/libEGL -output ./out/upload/maccatalyst_combined/libEGL.framework/Versions/A/libEGL
lipo -create ./out/upload/maccatalyst_arm64/libGLESv2.framework/Versions/A/libGLESv2 ./out/upload/maccatalyst_x64/libGLESv2.framework/Versions/A/libGLESv2 -output ./out/upload/maccatalyst_combined/libGLESv2.framework/Versions/A/libGLESv2
lipo -create ./out/upload/maccatalyst_arm64/libGLESv1_CM.framework/Versions/A/libGLESv1_CM ./out/upload/maccatalyst_x64/libGLESv1_CM.framework/Versions/A/libGLESv1_CM -output ./out/upload/maccatalyst_combined/libGLESv1_CM.framework/Versions/A/libGLESv1_CM

xcodebuild -create-xcframework -framework ./out/upload/ios_arm64/libEGL.framework -framework ./out/upload/iossimulator_combined/libEGL.framework -framework ./out/upload/maccatalyst_combined/libEGL.framework -output ./out/upload/ioslike_combined/libEGL.xcframework
xcodebuild -create-xcframework -framework ./out/upload/ios_arm64/libGLESv2.framework -framework ./out/upload/iossimulator_combined/libGLESv2.framework -framework ./out/upload/maccatalyst_combined/libGLESv2.framework -output ./out/upload/ioslike_combined/libGLESv2.xcframework
xcodebuild -create-xcframework -framework ./out/upload/ios_arm64/libGLESv1_CM.framework -framework ./out/upload/iossimulator_combined/libGLESv1_CM.framework -framework ./out/upload/maccatalyst_combined/libGLESv1_CM.framework -output ./out/upload/ioslike_combined/libGLESv1_CM.xcframework

cp -R ./out/Checked_ios_arm64/libEGL.framework ./out/upload/ios_arm64_checked/libEGL.framework
cp -R ./out/Checked_ios_arm64/libGLESv2.framework ./out/upload/ios_arm64_checked/libGLESv2.framework
cp -R ./out/Checked_ios_arm64/libGLESv1_CM.framework ./out/upload/ios_arm64_checked/libGLESv1_CM.framework

cp -R ./out/Checked_simulator_arm64/libEGL.framework ./out/upload/iossimulator_arm64_checked/libEGL.framework
cp -R ./out/Checked_simulator_arm64/libGLESv2.framework ./out/upload/iossimulator_arm64_checked/libGLESv2.framework
cp -R ./out/Checked_simulator_arm64/libGLESv1_CM.framework ./out/upload/iossimulator_arm64_checked/libGLESv1_CM.framework

cp -R ./out/Checked_simulator_x64/libEGL.framework ./out/upload/iossimulator_x64_checked/libEGL.framework
cp -R ./out/Checked_simulator_x64/libGLESv2.framework ./out/upload/iossimulator_x64_checked/libGLESv2.framework
cp -R ./out/Checked_simulator_x64/libGLESv1_CM.framework ./out/upload/iossimulator_x64_checked/libGLESv1_CM.framework

cp -R ./out/Checked_catalyst_arm64/libEGL.framework ./out/upload/maccatalyst_arm64_checked/libEGL.framework
cp -R ./out/Checked_catalyst_arm64/libGLESv2.framework ./out/upload/maccatalyst_arm64_checked/libGLESv2.framework
cp -R ./out/Checked_catalyst_arm64/libGLESv1_CM.framework ./out/upload/maccatalyst_arm64_checked/libGLESv1_CM.framework

cp -R ./out/Checked_catalyst_x64/libEGL.framework ./out/upload/maccatalyst_x64_checked/libEGL.framework
cp -R ./out/Checked_catalyst_x64/libGLESv2.framework ./out/upload/maccatalyst_x64_checked/libGLESv2.framework
cp -R ./out/Checked_catalyst_x64/libGLESv1_CM.framework ./out/upload/maccatalyst_x64_checked/libGLESv1_CM.framework

codesign --remove-signature ./out/upload/ios_arm64_checked/libEGL.framework
codesign --remove-signature ./out/upload/ios_arm64_checked/libGLESv2.framework
codesign --remove-signature ./out/upload/ios_arm64_checked/libGLESv1_CM.framework

codesign --remove-signature ./out/upload/iossimulator_arm64_checked/libEGL.framework
codesign --remove-signature ./out/upload/iossimulator_arm64_checked/libGLESv2.framework
codesign --remove-signature ./out/upload/iossimulator_arm64_checked/libGLESv1_CM.framework

codesign --remove-signature ./out/upload/iossimulator_x64_checked/libEGL.framework
codesign --remove-signature ./out/upload/iossimulator_x64_checked/libGLESv2.framework
codesign --remove-signature ./out/upload/iossimulator_x64_checked/libGLESv1_CM.framework

codesign --remove-signature ./out/upload/maccatalyst_arm64_checked/libEGL.framework
codesign --remove-signature ./out/upload/maccatalyst_arm64_checked/libGLESv2.framework
codesign --remove-signature ./out/upload/maccatalyst_arm64_checked/libGLESv1_CM.framework

codesign --remove-signature ./out/upload/maccatalyst_x64_checked/libEGL.framework
codesign --remove-signature ./out/upload/maccatalyst_x64_checked/libGLESv2.framework
codesign --remove-signature ./out/upload/maccatalyst_x64_checked/libGLESv1_CM.framework

cp -R ./out/upload/iossimulator_arm64_checked/libEGL.framework ./out/upload/iossimulator_combined_checked/libEGL.framework
cp -R ./out/upload/iossimulator_arm64_checked/libGLESv2.framework ./out/upload/iossimulator_combined_checked/libGLESv2.framework
cp -R ./out/upload/iossimulator_arm64_checked/libGLESv1_CM.framework ./out/upload/iossimulator_combined_checked/libGLESv1_CM.framework

cp -R ./out/upload/maccatalyst_arm64_checked/libEGL.framework ./out/upload/maccatalyst_combined_checked/libEGL.framework
cp -R ./out/upload/maccatalyst_arm64_checked/libGLESv2.framework ./out/upload/maccatalyst_combined_checked/libGLESv2.framework
cp -R ./out/upload/maccatalyst_arm64_checked/libGLESv1_CM.framework ./out/upload/maccatalyst_combined_checked/libGLESv1_CM.framework

lipo -create ./out/upload/iossimulator_arm64_checked/libEGL.framework/libEGL ./out/upload/iossimulator_x64_checked/libEGL.framework/libEGL -output ./out/upload/iossimulator_combined_checked/libEGL.framework/libEGL
lipo -create ./out/upload/iossimulator_arm64_checked/libGLESv2.framework/libGLESv2 ./out/upload/iossimulator_x64_checked/libGLESv2.framework/libGLESv2 -output ./out/upload/iossimulator_combined_checked/libGLESv2.framework/libGLESv2
lipo -create ./out/upload/iossimulator_arm64_checked/libGLESv1_CM.framework/libGLESv1_CM ./out/upload/iossimulator_x64_checked/libGLESv1_CM.framework/libGLESv1_CM -output ./out/upload/iossimulator_combined_checked/libGLESv1_CM.framework/libGLESv1_CM

lipo -create ./out/upload/maccatalyst_arm64_checked/libEGL.framework/Versions/A/libEGL ./out/upload/maccatalyst_x64_checked/libEGL.framework/Versions/A/libEGL -output ./out/upload/maccatalyst_combined_checked/libEGL.framework/Versions/A/libEGL
lipo -create ./out/upload/maccatalyst_arm64_checked/libGLESv2.framework/Versions/A/libGLESv2 ./out/upload/maccatalyst_x64_checked/libGLESv2.framework/Versions/A/libGLESv2 -output ./out/upload/maccatalyst_combined_checked/libGLESv2.framework/Versions/A/libGLESv2
lipo -create ./out/upload/maccatalyst_arm64_checked/libGLESv1_CM.framework/Versions/A/libGLESv1_CM ./out/upload/maccatalyst_x64_checked/libGLESv1_CM.framework/Versions/A/libGLESv1_CM -output ./out/upload/maccatalyst_combined_checked/libGLESv1_CM.framework/Versions/A/libGLESv1_CM

xcodebuild -create-xcframework -framework ./out/upload/ios_arm64_checked/libEGL.framework -framework ./out/upload/iossimulator_combined_checked/libEGL.framework -framework ./out/upload/maccatalyst_combined_checked/libEGL.framework -output ./out/upload/ioslike_combined_checked/libEGL.xcframework
xcodebuild -create-xcframework -framework ./out/upload/ios_arm64_checked/libGLESv2.framework -framework ./out/upload/iossimulator_combined_checked/libGLESv2.framework -framework ./out/upload/maccatalyst_combined_checked/libGLESv2.framework -output ./out/upload/ioslike_combined_checked/libGLESv2.xcframework
xcodebuild -create-xcframework -framework ./out/upload/ios_arm64_checked/libGLESv1_CM.framework -framework ./out/upload/iossimulator_combined_checked/libGLESv1_CM.framework -framework ./out/upload/maccatalyst_combined_checked/libGLESv1_CM.framework -output ./out/upload/ioslike_combined_checked/libGLESv1_CM.xcframework

cp -R ./out/Debug_ios_arm64/libEGL.framework ./out/upload/ios_arm64_debug/libEGL.framework
cp -R ./out/Debug_ios_arm64/libGLESv2.framework ./out/upload/ios_arm64_debug/libGLESv2.framework
cp -R ./out/Debug_ios_arm64/libGLESv1_CM.framework ./out/upload/ios_arm64_debug/libGLESv1_CM.framework

cp -R ./out/Debug_simulator_arm64/libEGL.framework ./out/upload/iossimulator_arm64_debug/libEGL.framework
cp -R ./out/Debug_simulator_arm64/libGLESv2.framework ./out/upload/iossimulator_arm64_debug/libGLESv2.framework
cp -R ./out/Debug_simulator_arm64/libGLESv1_CM.framework ./out/upload/iossimulator_arm64_debug/libGLESv1_CM.framework

cp -R ./out/Debug_simulator_x64/libEGL.framework ./out/upload/iossimulator_x64_debug/libEGL.framework
cp -R ./out/Debug_simulator_x64/libGLESv2.framework ./out/upload/iossimulator_x64_debug/libGLESv2.framework
cp -R ./out/Debug_simulator_x64/libGLESv1_CM.framework ./out/upload/iossimulator_x64_debug/libGLESv1_CM.framework

cp -R ./out/Debug_catalyst_arm64/libEGL.framework ./out/upload/maccatalyst_arm64_debug/libEGL.framework
cp -R ./out/Debug_catalyst_arm64/libGLESv2.framework ./out/upload/maccatalyst_arm64_debug/libGLESv2.framework
cp -R ./out/Debug_catalyst_arm64/libGLESv1_CM.framework ./out/upload/maccatalyst_arm64_debug/libGLESv1_CM.framework

cp -R ./out/Debug_catalyst_x64/libEGL.framework ./out/upload/maccatalyst_x64_debug/libEGL.framework
cp -R ./out/Debug_catalyst_x64/libGLESv2.framework ./out/upload/maccatalyst_x64_debug/libGLESv2.framework
cp -R ./out/Debug_catalyst_x64/libGLESv1_CM.framework ./out/upload/maccatalyst_x64_debug/libGLESv1_CM.framework

codesign --remove-signature ./out/upload/ios_arm64_debug/libEGL.framework
codesign --remove-signature ./out/upload/ios_arm64_debug/libGLESv2.framework
codesign --remove-signature ./out/upload/ios_arm64_debug/libGLESv1_CM.framework

codesign --remove-signature ./out/upload/iossimulator_arm64_debug/libEGL.framework
codesign --remove-signature ./out/upload/iossimulator_arm64_debug/libGLESv2.framework
codesign --remove-signature ./out/upload/iossimulator_arm64_debug/libGLESv1_CM.framework

codesign --remove-signature ./out/upload/iossimulator_x64_debug/libEGL.framework
codesign --remove-signature ./out/upload/iossimulator_x64_debug/libGLESv2.framework
codesign --remove-signature ./out/upload/iossimulator_x64_debug/libGLESv1_CM.framework

codesign --remove-signature ./out/upload/maccatalyst_arm64_debug/libEGL.framework
codesign --remove-signature ./out/upload/maccatalyst_arm64_debug/libGLESv2.framework
codesign --remove-signature ./out/upload/maccatalyst_arm64_debug/libGLESv1_CM.framework

codesign --remove-signature ./out/upload/maccatalyst_x64_debug/libEGL.framework
codesign --remove-signature ./out/upload/maccatalyst_x64_debug/libGLESv2.framework
codesign --remove-signature ./out/upload/maccatalyst_x64_debug/libGLESv1_CM.framework

cp -R ./out/upload/iossimulator_arm64_debug/libEGL.framework ./out/upload/iossimulator_combined_debug/libEGL.framework
cp -R ./out/upload/iossimulator_arm64_debug/libGLESv2.framework ./out/upload/iossimulator_combined_debug/libGLESv2.framework
cp -R ./out/upload/iossimulator_arm64_debug/libGLESv1_CM.framework ./out/upload/iossimulator_combined_debug/libGLESv1_CM.framework

cp -R ./out/upload/maccatalyst_arm64_debug/libEGL.framework ./out/upload/maccatalyst_combined_debug/libEGL.framework
cp -R ./out/upload/maccatalyst_arm64_debug/libGLESv2.framework ./out/upload/maccatalyst_combined_debug/libGLESv2.framework
cp -R ./out/upload/maccatalyst_arm64_debug/libGLESv1_CM.framework ./out/upload/maccatalyst_combined_debug/libGLESv1_CM.framework

lipo -create ./out/upload/iossimulator_arm64_debug/libEGL.framework/libEGL ./out/upload/iossimulator_x64_debug/libEGL.framework/libEGL -output ./out/upload/iossimulator_combined_debug/libEGL.framework/libEGL
lipo -create ./out/upload/iossimulator_arm64_debug/libGLESv2.framework/libGLESv2 ./out/upload/iossimulator_x64_debug/libGLESv2.framework/libGLESv2 -output ./out/upload/iossimulator_combined_debug/libGLESv2.framework/libGLESv2
lipo -create ./out/upload/iossimulator_arm64_debug/libGLESv1_CM.framework/libGLESv1_CM ./out/upload/iossimulator_x64_debug/libGLESv1_CM.framework/libGLESv1_CM -output ./out/upload/iossimulator_combined_debug/libGLESv1_CM.framework/libGLESv1_CM

lipo -create ./out/upload/maccatalyst_arm64_debug/libEGL.framework/Versions/A/libEGL ./out/upload/maccatalyst_x64_debug/libEGL.framework/Versions/A/libEGL -output ./out/upload/maccatalyst_combined_debug/libEGL.framework/Versions/A/libEGL
lipo -create ./out/upload/maccatalyst_arm64_debug/libGLESv2.framework/Versions/A/libGLESv2 ./out/upload/maccatalyst_x64_debug/libGLESv2.framework/Versions/A/libGLESv2 -output ./out/upload/maccatalyst_combined_debug/libGLESv2.framework/Versions/A/libGLESv2
lipo -create ./out/upload/maccatalyst_arm64_debug/libGLESv1_CM.framework/Versions/A/libGLESv1_CM ./out/upload/maccatalyst_x64_debug/libGLESv1_CM.framework/Versions/A/libGLESv1_CM -output ./out/upload/maccatalyst_combined_debug/libGLESv1_CM.framework/Versions/A/libGLESv1_CM

xcodebuild -create-xcframework -framework ./out/upload/ios_arm64_debug/libEGL.framework -framework ./out/upload/iossimulator_combined_debug/libEGL.framework -framework ./out/upload/maccatalyst_combined_debug/libEGL.framework -output ./out/upload/ioslike_combined_debug/libEGL.xcframework
xcodebuild -create-xcframework -framework ./out/upload/ios_arm64_debug/libGLESv2.framework -framework ./out/upload/iossimulator_combined_debug/libGLESv2.framework -framework ./out/upload/maccatalyst_combined_debug/libGLESv2.framework -output ./out/upload/ioslike_combined_debug/libGLESv2.xcframework
xcodebuild -create-xcframework -framework ./out/upload/ios_arm64_debug/libGLESv1_CM.framework -framework ./out/upload/iossimulator_combined_debug/libGLESv1_CM.framework -framework ./out/upload/maccatalyst_combined_debug/libGLESv1_CM.framework -output ./out/upload/ioslike_combined_debug/libGLESv1_CM.xcframework

pushd ./out/upload/ios_arm64
zip -r ../ios_arm64.zip libEGL.framework libGLESv2.framework
zip -r ../ios_arm64_extra_gles1.zip libGLESv1_CM.framework
pushd symbols
zip -r ../../ios_arm64_symbols.zip libEGL.framework.dSYM libGLESv2.framework.dSYM libGLESv1_CM.framework.dSYM
popd
popd

pushd ./out/upload/ios_arm64_checked
zip -r ../ios_arm64_checked.zip libEGL.framework libGLESv2.framework libGLESv1_CM.framework
popd

pushd ./out/upload/ios_arm64_debug
zip -r ../ios_arm64_debug.zip libEGL.framework libGLESv2.framework libGLESv1_CM.framework
popd

pushd ./out/upload/iossimulator_arm64
zip -r ../iossimulator_arm64.zip libEGL.framework libGLESv2.framework
zip -r ../iossimulator_arm64_extra_gles1.zip libGLESv1_CM.framework
pushd symbols
zip -r ../../iossimulator_arm64_symbols.zip libEGL.framework.dSYM libGLESv2.framework.dSYM libGLESv1_CM.framework.dSYM
popd
popd

pushd ./out/upload/iossimulator_x64
zip -r ../iossimulator_x64.zip libEGL.framework libGLESv2.framework
zip -r ../iossimulator_x64_extra_gles1.zip libGLESv1_CM.framework
pushd symbols
zip -r ../../iossimulator_x64_symbols.zip libEGL.framework.dSYM libGLESv2.framework.dSYM libGLESv1_CM.framework.dSYM
popd
popd

pushd ./out/upload/iossimulator_combined
zip -r ../iossimulator_combined.zip libEGL.framework libGLESv2.framework
zip -r ../iossimulator_combined_extra_gles1.zip libGLESv1_CM.framework
popd

pushd ./out/upload/iossimulator_arm64_checked
zip -r ../iossimulator_arm64_checked.zip libEGL.framework libGLESv2.framework libGLESv1_CM.framework
popd

pushd ./out/upload/iossimulator_x64_checked
zip -r ../iossimulator_x64_checked.zip libEGL.framework libGLESv2.framework libGLESv1_CM.framework
popd

pushd ./out/upload/iossimulator_combined_checked
zip -r ../iossimulator_combined_checked.zip libEGL.framework libGLESv2.framework libGLESv1_CM.framework
popd

pushd ./out/upload/iossimulator_arm64_debug
zip -r ../iossimulator_arm64_debug.zip libEGL.framework libGLESv2.framework libGLESv1_CM.framework
popd

pushd ./out/upload/iossimulator_x64_debug
zip -r ../iossimulator_x64_debug.zip libEGL.framework libGLESv2.framework libGLESv1_CM.framework
popd

pushd ./out/upload/iossimulator_combined_debug
zip -r ../iossimulator_combined_debug.zip libEGL.framework libGLESv2.framework libGLESv1_CM.framework
popd

pushd ./out/upload/maccatalyst_arm64
zip -r ../maccatalyst_arm64.zip libEGL.framework libGLESv2.framework
zip -r ../maccatalyst_arm64_extra_gles1.zip libGLESv1_CM.framework
pushd symbols
zip -r ../../maccatalyst_arm64_symbols.zip libEGL.framework.dSYM libGLESv2.framework.dSYM libGLESv1_CM.framework.dSYM
popd
popd

pushd ./out/upload/maccatalyst_x64
zip -r ../maccatalyst_x64.zip libEGL.framework libGLESv2.framework
zip -r ../maccatalyst_x64_extra_gles1.zip libGLESv1_CM.framework
pushd symbols
zip -r ../../maccatalyst_x64_symbols.zip libEGL.framework.dSYM libGLESv2.framework.dSYM libGLESv1_CM.framework.dSYM
popd
popd

pushd ./out/upload/maccatalyst_combined
zip -r ../maccatalyst_combined.zip libEGL.framework libGLESv2.framework
zip -r ../maccatalyst_combined_extra_gles1.zip libGLESv1_CM.framework
popd

pushd ./out/upload/maccatalyst_arm64_checked
zip -r ../maccatalyst_arm64_checked.zip libEGL.framework libGLESv2.framework libGLESv1_CM.framework
popd

pushd ./out/upload/maccatalyst_x64_checked
zip -r ../maccatalyst_x64_checked.zip libEGL.framework libGLESv2.framework libGLESv1_CM.framework
popd

pushd ./out/upload/maccatalyst_combined_checked
zip -r ../maccatalyst_combined_checked.zip libEGL.framework libGLESv2.framework libGLESv1_CM.framework
popd

pushd ./out/upload/maccatalyst_arm64_debug
zip -r ../maccatalyst_arm64_debug.zip libEGL.framework libGLESv2.framework libGLESv1_CM.framework
popd

pushd ./out/upload/maccatalyst_x64_debug
zip -r ../maccatalyst_x64_debug.zip libEGL.framework libGLESv2.framework libGLESv1_CM.framework
popd

pushd ./out/upload/maccatalyst_combined_debug
zip -r ../maccatalyst_combined_debug.zip libEGL.framework libGLESv2.framework libGLESv1_CM.framework
popd

pushd ./out/upload/ioslike_combined
zip -r ../ioslike_combined.zip libEGL.xcframework libGLESv2.xcframework
zip -r ../ioslike_combined_extra_gles1.zip libGLESv1_CM.xcframework
popd

pushd ./out/upload/ioslike_combined_checked
zip -r ../ioslike_combined_checked.zip libEGL.xcframework libGLESv2.xcframework libGLESv1_CM.xcframework
popd

pushd ./out/upload/ioslike_combined_debug
zip -r ../ioslike_combined_debug.zip libEGL.xcframework libGLESv2.xcframework libGLESv1_CM.xcframework
popd
