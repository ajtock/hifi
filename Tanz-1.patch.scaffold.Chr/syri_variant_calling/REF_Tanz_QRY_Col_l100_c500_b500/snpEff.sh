#!/bin/bash

# Run snpEff v5.0e on SyRi v1.5 output VCF file

# For details of the file format, please check https://schneebergerlab.github.io/syri/fileformat.html

# Usage:
# csmit -m 100G -c 1 "bash ./snpEff.sh Tanz-1.patch.scaffold.Chr t2t-col.20210610.Chr"

REF=$1
QRY=$2

#source activate syri
#
#echo $(which snpEff)

java -Xmx100G -jar /home/ajt200/miniconda3/envs/syri/share/snpeff-5.0-1/snpEff.jar -verbose \
              -config /home/ajt200/miniconda3/envs/syri/share/snpeff-5.0-1/snpEff.config ${REF} ${REF}_${QRY}_nm3_syri_filt.vcf \
              > ${REF}_${QRY}_nm3_syri_filt.snpEff.vcf

#source deactivate
