#!/bin/bash
clang -S -c -Xclang -disable-O0-optnone -fno-discard-value-names -emit-llvm example.c -o example.ll
opt -S -mem2reg example.ll -o example.ll

base="example"
for i in {2..5}
do
    file="$base$i.c"
    ir="$base$i.ll"
    clang -S -c -Xclang -disable-O0-optnone -fno-discard-value-names -emit-llvm $file -o $ir
    opt -S -mem2reg $ir -o $ir
done