#!/bin/bash

# Usage:
# ./convert_gene_Liftoff_GFF3_to_CDS_fa.sh Cvi-0.ragtag_scaffolds.Chr

genome=$1

/applications/cufflinks/cufflinks-2.2.1.Linux_x86_64/gffread ${genome}.genes.gff3 \
                                                             -g ../../${genome}.fa \
                                                             -x ${genome}.genes.CDS.fa
