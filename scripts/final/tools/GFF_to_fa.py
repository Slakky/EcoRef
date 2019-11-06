#!/usr/bin/python
from Bio import SeqIO
import os
import sys

sample = sys.argv[1]

sample_path = os.path.abspath(sample)
sample_path_clean = os.path.abspath(sample).rsplit('_', 1)[0]
for record in SeqIO.parse(sample_path, 'fasta'):
    SeqIO.write(record, sample_path_clean, 'fasta')