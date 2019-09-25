#!/bin/sh

base_dir='/home/claudio'
input_dir='/nas/annotated_assemblies/'
script=$base_dir/Comp_Genetics/scripts/17_GFF_to_fa.py

for filename in $base_dir$input_dir*;
    do python3 $script $filename;
done