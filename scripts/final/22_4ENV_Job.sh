#!/bin/sh

sed "1d" /home/claudio/nas/phenotypes/A22.0P5.tsv | cut -f 1 > /home/claudio/nas/LMM_VCF_VCF/A22.0P5_phenolist.tsv

similarity_pyseer --vcf /home/claudio/nas/snps.vcf /home/claudio/nas/LMM_VCF_VCF/A22.0P5_phenolist.tsv > /home/claudio/nas/LMM_VCF_VCF/A22.0P5_K.tsv

nohup pyseer --lmm --phenotypes /home/claudio/nas/phenotypes/A22.0P5.tsv --vcf /home/claudio/nas/snps.vcf.gz --similarity /home/claudio/nas/LMM_VCF_VCF/A22.0P5_K.tsv --output-patterns /home/claudio/nas/LMM_VCF_VCF/A22.0P5_patterns.txt --cpu 1 --min-af 0.05 --max-af 0.95 --lineage --lineage-file /home/claudio/nas/LMM_VCF_VCF/A22.0P5.lineage --distances /home/claudio/nas/LMM_VCF_VCF/A22.0P5_K.tsv > /home/claudio/nas/LMM_VCF_VCF/A22.0P5.txt 2> /home/claudio/nas/LMM_VCF_VCF/A22.0P5.out &

sed "1d" /home/claudio/nas/phenotypes/UREA.50MM.tsv | cut -f 1 > /home/claudio/nas/LMM_VCF_VCF/UREA.50MM_phenolist.tsv

similarity_pyseer --vcf /home/claudio/nas/snps.vcf /home/claudio/nas/LMM_VCF_VCF/UREA.50MM_phenolist.tsv > /home/claudio/nas/LMM_VCF_VCF/UREA.50MM_K.tsv

nohup pyseer --lmm --phenotypes /home/claudio/nas/phenotypes/UREA.50MM.tsv --vcf /home/claudio/nas/snps.vcf.gz --similarity /home/claudio/nas/LMM_VCF_VCF/UREA.50MM_K.tsv --output-patterns /home/claudio/nas/LMM_VCF_VCF/UREA.50MM_patterns.txt --cpu 1 --min-af 0.05 --max-af 0.95 --lineage --lineage-file /home/claudio/nas/LMM_VCF_VCF/UREA.50MM.lineage --distances /home/claudio/nas/LMM_VCF_VCF/UREA.50MM_K.tsv > /home/claudio/nas/LMM_VCF_VCF/UREA.50MM.txt 2> /home/claudio/nas/LMM_VCF_VCF/UREA.50MM.out &

sed "1d" /home/claudio/nas/phenotypes/AMOXICILLIN.0P25UM.tsv | cut -f 1 > /home/claudio/nas/LMM_VCF_VCF/AMOXICILLIN.0P25UM_phenolist.tsv

similarity_pyseer --vcf /home/claudio/nas/snps.vcf /home/claudio/nas/LMM_VCF_VCF/AMOXICILLIN.0P25UM_phenolist.tsv > /home/claudio/nas/LMM_VCF_VCF/AMOXICILLIN.0P25UM_K.tsv

nohup pyseer --lmm --phenotypes /home/claudio/nas/phenotypes/AMOXICILLIN.0P25UM.tsv --vcf /home/claudio/nas/snps.vcf.gz --similarity /home/claudio/nas/LMM_VCF_VCF/AMOXICILLIN.0P25UM_K.tsv --output-patterns /home/claudio/nas/LMM_VCF_VCF/AMOXICILLIN.0P25UM_patterns.txt --cpu 1 --min-af 0.05 --max-af 0.95 --lineage --lineage-file /home/claudio/nas/LMM_VCF_VCF/AMOXICILIN.0P25UM.lineage --distances /home/claudio/nas/LMM_VCF_VCF/AMOXICILLIN.0P25UM_K.tsv > /home/claudio/nas/LMM_VCF_VCF/AMOXICILLIN.0P25UM.txt 2> /home/claudio/nas/LMM_VCF_VCF/AMOXICILLIN.0P25UM.out &
