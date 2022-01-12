#!/bin/bash

# Pairwise align assemblies using minimap2 (v2.23-r1111)
# Filter resulting alignments for alignment length (>100) and identity (>90)
# Call structural rearrangements and local variations using SyRI v1.5 (https://github.com/schneebergerlab/syri).

# For details of the file format, please check https://schneebergerlab.github.io/syri/fileformat.html
# Usage:
# csmit -m 50G -c 32 "bash ./minimap2_syri.sh t2t-col.20210610.Chr Tanz-1.patch.scaffold.Chr asm5 32"

REF=$1
QRY=$2
ASM=$3
CPU=$4

source activate syri

echo $(which minimap2)
echo $(minimap2 --version)

minimap2 -ax ${ASM} --eqx ${REF}.fa ${QRY}.fa \
| samtools view -b -@ ${CPU} -o ${REF}_${QRY}_${ASM}_mm2.bam -

/home/ajt200/envs_miniconda3/syri_1.5/syri/bin/syri -c ${REF}_${QRY}_${ASM}_mm2.bam \
                                                    -r ${REF}.fa -q ${QRY}.fa \
                                                    --prefix ${REF}_${QRY}_${ASM}_mm2 \
                                                    --nc 5 --all -k -F B

conda deactivate
