#!/bin/bash

# Remove variants where END coordinate precedes POS coordinate,
# which cause snpEff annotation to fail

# Usage
# ./awk_filter_vcf.sh t2t-col.20210610.Chr Cvi-0.ragtag_scaffolds.Chr

REF=$1
QRY=$2

head -n 31 ${REF}_${QRY}_nm3_syri.vcf > ${REF}_${QRY}_nm3_syri_HEADER.vcf

tail -n +32 ${REF}_${QRY}_nm3_syri.vcf > ${REF}_${QRY}_nm3_syri_NOHEADER.vcf

awk 'BEGIN{FS = "\t"; OFS = "\t";}; {print substr($8, 5)}' ${REF}_${QRY}_nm3_syri_NOHEADER.vcf \
  | awk '{sub(/;.*/, ""); print}' > ${REF}_${QRY}_nm3_syri_NOHEADER_END_COORD.vcf

paste -d'\t' ${REF}_${QRY}_nm3_syri_NOHEADER.vcf ${REF}_${QRY}_nm3_syri_NOHEADER_END_COORD.vcf > ${REF}_${QRY}_nm3_syri_NOHEADER_tmp.vcf

awk 'BEGIN{FS = "\t"; OFS = "\t";}; $9 >= $2' ${REF}_${QRY}_nm3_syri_NOHEADER_tmp.vcf > ${REF}_${QRY}_nm3_syri_NOHEADER_tmp_filt.vcf

awk 'BEGIN{FS = "\t"; OFS = "\t"; first = 1; last = 8};
  {for(i = first; i < last; i++) {printf("%s\t", $i)} print $last}' ${REF}_${QRY}_nm3_syri_NOHEADER_tmp_filt.vcf \
  > ${REF}_${QRY}_nm3_syri_NOHEADER_filt.vcf  

cat ${REF}_${QRY}_nm3_syri_HEADER.vcf ${REF}_${QRY}_nm3_syri_NOHEADER_filt.vcf > ${REF}_${QRY}_nm3_syri_filt.vcf

rm *HEADER.vcf *END_COORD.vcf *tmp*.vcf
