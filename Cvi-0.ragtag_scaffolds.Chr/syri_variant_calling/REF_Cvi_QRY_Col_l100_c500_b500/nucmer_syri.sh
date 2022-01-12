#!/bin/bash

# Pairwise align assemblies using nucmer v3.1 from the MUMmer4 toolbox with parameter setting “--maxmatch -l 40 -g 90 -c 100 -b 200"
# Filter resulting alignments for alignment length (>100) and identity (>90)
# Call structural rearrangements and local variations using SyRI v1.5 (https://github.com/schneebergerlab/syri).

# For details of the file format, please check https://schneebergerlab.github.io/syri/fileformat.html
# Usage:
# csmit -m 50G -c 32 "bash ./nucmer_syri.sh Cvi-0.ragtag_scaffolds.Chr t2t-col.20210610.Chr"

REF=$1
QRY=$2

source activate syri

echo $(which nucmer)
echo $(nucmer --version)

nucmer --maxmatch -l 100 -g 90 -c 500 -b 500 ${REF}.fa ${QRY}.fa

mv out.delta ${REF}_${QRY}_nm3.delta

delta-filter -m -i 90 -l 100 ${REF}_${QRY}_nm3.delta > ${REF}_${QRY}_nm3_m_i90_l100.delta

show-coords -THrd ${REF}_${QRY}_nm3_m_i90_l100.delta > ${REF}_${QRY}_nm3_m_i90_l100.coords

/home/ajt200/envs_miniconda3/syri_1.5/syri/bin/syri -c ${REF}_${QRY}_nm3_m_i90_l100.coords \
                                                    -d ${REF}_${QRY}_nm3_m_i90_l100.delta \
                                                    -r ${REF}.fa -q ${QRY}.fa \
                                                    --prefix ${REF}_${QRY}_nm3_ \
                                                    --nc 5 --all -k

source deactivate
