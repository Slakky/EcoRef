#!/bin/sh

base_dir='/home/claudio'
input_dir='/nas/annotated_assemblies/'

for filename in $base_dir$input_dir*;
    do mv $filename $filename.fa;
done