#!/bin/bash

# Run snpEff v5.0e on SyRi v1.5 output VCF file

# For details of the file format, please check https://schneebergerlab.github.io/syri/fileformat.html

# Usage:
# csmit -m 20G -c 1 "bash ./SnpSift_interval.sh t2t-col.20210610.Chr Tanz-1.patch.scaffold.Chr QTL1"

REF=$1
QRY=$2
QTL=$3

#source activate syri
#
#echo $(which SnpSift)

java -jar /home/ajt200/miniconda3/envs/syri/share/snpsift-4.3.1t-3/SnpSift.jar \
     intervals ${REF}_interval_${QTL}.bed \
     -i ${REF}_${QRY}_nm3_syri_filt.snpEff.vcf \
     > ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}.vcf

head -n 38 ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}.vcf > ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}_HEADER.vcf

grep "HIGH" ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}.vcf | cat ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}_HEADER.vcf - > ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}_HIGH.vcf
grep "MODERATE" ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}.vcf | cat ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}_HEADER.vcf - > ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}_MODERATE.vcf
grep "LOW" ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}.vcf | cat ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}_HEADER.vcf - > ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}_LOW.vcf
grep "MODIFIER" ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}.vcf | cat ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}_HEADER.vcf - > ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}_MODIFIER.vcf
grep "LOF" ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}.vcf | grep "HIGH" - | cat ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}_HEADER.vcf - > ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}_LOF_AND_HIGH.vcf
grep "NMD" ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}.vcf | grep "HIGH" - | cat ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}_HEADER.vcf - > ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}_NMD_AND_HIGH.vcf
grep "LOF" ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}.vcf | grep "NMD" - | grep "HIGH" - | cat ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}_HEADER.vcf - > ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}_LOF_NMD_AND_HIGH.vcf
grep "LOF" ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}.vcf | grep -v "HIGH" - | cat ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}_HEADER.vcf - > ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}_LOF_NOT_HIGH.vcf
grep "NMD" ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}.vcf | grep -v "HIGH" - | cat ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}_HEADER.vcf - > ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}_NMD_NOT_HIGH.vcf

rm ${REF}_${QRY}_nm3_syri_filt.SnpSift_interval_${QTL}_HEADER.vcf

#source deactivate
