#!/bin/sh
source project.cfg;

rm -rf build
mkdir -p build

# Compile
asm_file="src/$PROJECT_NAME.asm"
filename=`basename $asm_file .asm`;
ca65 -o "build/$filename.o" -g $asm_file;

# Link
ld65 build/$filename.o -C linker.cfg -o build/$PROJECT_NAME.nes \
--dbgfile build/$PROJECT_NAME.deb \
--mapfile build/$PROJECT_NAME.nes.map \
-Ln build/$PROJECT_NAME.nes.labels 

# debug symbols
./build_symbols.py $PROJECT_NAME
