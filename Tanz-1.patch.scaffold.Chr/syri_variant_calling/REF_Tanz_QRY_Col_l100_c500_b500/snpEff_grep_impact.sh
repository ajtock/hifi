#!/bin/bash

# Run snpEff v5.0e on SyRi v1.5 output VCF file

# For details of the file format, please check https://schneebergerlab.github.io/syri/fileformat.html

# Usage:
# bash ./snpEff_grep_impact.sh Tanz-1.patch.scaffold.Chr t2t-col.20210610.Chr

REF=$1
QRY=$2

head -n 36 ${REF}_${QRY}_nm3_syri_filt.snpEff.vcf > ${REF}_${QRY}_nm3_syri_filt.snpEff_HEADER.vcf

grep "HIGH" ${REF}_${QRY}_nm3_syri_filt.snpEff.vcf | cat ${REF}_${QRY}_nm3_syri_filt.snpEff_HEADER.vcf - > ${REF}_${QRY}_nm3_syri_filt.snpEff_HIGH.vcf
grep "MODERATE" ${REF}_${QRY}_nm3_syri_filt.snpEff.vcf | cat ${REF}_${QRY}_nm3_syri_filt.snpEff_HEADER.vcf - > ${REF}_${QRY}_nm3_syri_filt.snpEff_MODERATE.vcf
grep "LOW" ${REF}_${QRY}_nm3_syri_filt.snpEff.vcf | cat ${REF}_${QRY}_nm3_syri_filt.snpEff_HEADER.vcf - > ${REF}_${QRY}_nm3_syri_filt.snpEff_LOW.vcf
grep "MODIFIER" ${REF}_${QRY}_nm3_syri_filt.snpEff.vcf | cat ${REF}_${QRY}_nm3_syri_filt.snpEff_HEADER.vcf - > ${REF}_${QRY}_nm3_syri_filt.snpEff_MODIFIER.vcf
grep "LOF" ${REF}_${QRY}_nm3_syri_filt.snpEff.vcf | grep "HIGH" - | cat ${REF}_${QRY}_nm3_syri_filt.snpEff_HEADER.vcf - > ${REF}_${QRY}_nm3_syri_filt.snpEff_LOF_AND_HIGH.vcf
grep "NMD" ${REF}_${QRY}_nm3_syri_filt.snpEff.vcf | grep "HIGH" - | cat ${REF}_${QRY}_nm3_syri_filt.snpEff_HEADER.vcf - > ${REF}_${QRY}_nm3_syri_filt.snpEff_NMD_AND_HIGH.vcf
grep "LOF" ${REF}_${QRY}_nm3_syri_filt.snpEff.vcf | grep "NMD" - | grep "HIGH" - | cat ${REF}_${QRY}_nm3_syri_filt.snpEff_HEADER.vcf - > ${REF}_${QRY}_nm3_syri_filt.snpEff_LOF_NMD_AND_HIGH.vcf
grep "LOF" ${REF}_${QRY}_nm3_syri_filt.snpEff.vcf | grep -v "HIGH" - | cat ${REF}_${QRY}_nm3_syri_filt.snpEff_HEADER.vcf - > ${REF}_${QRY}_nm3_syri_filt.snpEff_LOF_NOT_HIGH.vcf
grep "NMD" ${REF}_${QRY}_nm3_syri_filt.snpEff.vcf | grep -v "HIGH" - | cat ${REF}_${QRY}_nm3_syri_filt.snpEff_HEADER.vcf - > ${REF}_${QRY}_nm3_syri_filt.snpEff_NMD_NOT_HIGH.vcf

rm ${REF}_${QRY}_nm3_syri_filt.snpEff_HEADER.vcf
