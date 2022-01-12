#!/bin/bash

# Generate graphical representation of genomic structure using output of SyRI variant calling on nucmer-aligned assemblies
# SyRI v1.5 (https://github.com/schneebergerlab/syri).

# For details of the file format, please check https://schneebergerlab.github.io/syri/plotsr.html
# Usage:
# bash ./nucmer_plotsr.sh t2t-col.20210610.Chr Tanz-1.patch.scaffold.Chr

REF=$1
QRY=$2

source activate syri

echo $(which nucmer)
echo $(nucmer --version)
echo $(which plotsr)

/home/ajt200/envs_miniconda3/syri_1.5/syri/bin/plotsr ${REF}_${QRY}_nm3_syri.out \
                                                      ${REF}.fa ${QRY}.fa

mv syri.pdf ${REF}_${QRY}_nm3_syri_plotsr.pdf

conda deactivate


