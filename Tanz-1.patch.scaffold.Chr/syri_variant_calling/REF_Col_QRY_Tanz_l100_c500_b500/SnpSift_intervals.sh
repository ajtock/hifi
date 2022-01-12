#!/bin/bash

# Run snpEff v5.0e on SyRi v1.5 output VCF file

# For details of the file format, please check https://schneebergerlab.github.io/syri/fileformat.html

# Usage:
# csmit -m 100G -c 1 "bash ./SnpSift_intervals.sh t2t-col.20210610 Tanz-1.patch.scaffold.Chr"

REF=$1
QRY=$2

#source activate syri
#
#echo $(which SnpSift)

#java -jar /home/ajt200/miniconda3/envs/syri/share/snpsift-4.3.1t-3/SnpSift.jar \
#     intervals ${REF}_genes_QTL1.1_interval.bed \
#     -i ${REF}_${QRY}_syri_filt.snpEff.vcf \
#     > ${REF}_${QRY}_syri_filt.SnpSift_intervals.vcf

head -n 38 ${REF}_${QRY}_syri_filt.SnpSift_intervals.vcf > ${REF}_${QRY}_syri_filt.SnpSift_intervals_HEADER.vcf

grep "HIGH" ${REF}_${QRY}_syri_filt.SnpSift_intervals.vcf | cat ${REF}_${QRY}_syri_filt.SnpSift_intervals_HEADER.vcf - > ${REF}_${QRY}_syri_filt.SnpSift_intervals_HIGH.vcf
grep "MODERATE" ${REF}_${QRY}_syri_filt.SnpSift_intervals.vcf | cat ${REF}_${QRY}_syri_filt.SnpSift_intervals_HEADER.vcf - > ${REF}_${QRY}_syri_filt.SnpSift_intervals_MODERATE.vcf
grep "LOW" ${REF}_${QRY}_syri_filt.SnpSift_intervals.vcf | cat ${REF}_${QRY}_syri_filt.SnpSift_intervals_HEADER.vcf - > ${REF}_${QRY}_syri_filt.SnpSift_intervals_LOW.vcf
grep "MODIFIER" ${REF}_${QRY}_syri_filt.SnpSift_intervals.vcf | cat ${REF}_${QRY}_syri_filt.SnpSift_intervals_HEADER.vcf - > ${REF}_${QRY}_syri_filt.SnpSift_intervals_MODIFIER.vcf
grep "LOF" ${REF}_${QRY}_syri_filt.SnpSift_intervals.vcf | grep "HIGH" - | cat ${REF}_${QRY}_syri_filt.SnpSift_intervals_HEADER.vcf - > ${REF}_${QRY}_syri_filt.SnpSift_intervals_LOF_AND_HIGH.vcf
grep "NMD" ${REF}_${QRY}_syri_filt.SnpSift_intervals.vcf | grep "HIGH" - | cat ${REF}_${QRY}_syri_filt.SnpSift_intervals_HEADER.vcf - > ${REF}_${QRY}_syri_filt.SnpSift_intervals_NMD_AND_HIGH.vcf
grep "LOF" ${REF}_${QRY}_syri_filt.SnpSift_intervals.vcf | grep "NMD" - | grep "HIGH" - | cat ${REF}_${QRY}_syri_filt.SnpSift_intervals_HEADER.vcf - > ${REF}_${QRY}_syri_filt.SnpSift_intervals_LOF_NMD_AND_HIGH.vcf
grep "LOF" ${REF}_${QRY}_syri_filt.SnpSift_intervals.vcf | grep -v "HIGH" - | cat ${REF}_${QRY}_syri_filt.SnpSift_intervals_HEADER.vcf - > ${REF}_${QRY}_syri_filt.SnpSift_intervals_LOF_NOT_HIGH.vcf
grep "NMD" ${REF}_${QRY}_syri_filt.SnpSift_intervals.vcf | grep -v "HIGH" - | cat ${REF}_${QRY}_syri_filt.SnpSift_intervals_HEADER.vcf - > ${REF}_${QRY}_syri_filt.SnpSift_intervals_NMD_NOT_HIGH.vcf

rm ${REF}_${QRY}_syri_filt.SnpSift_intervals_HEADER.vcf

#source deactivate
