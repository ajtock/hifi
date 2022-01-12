#!/bin/bash

# Usage:
# ./convert_gene_Liftoff_GFF3_to_CDS_fa.sh Tanz-1.patch.scaffold.Chr

genome=$1

/applications/cufflinks/cufflinks-2.2.1.Linux_x86_64/gffread ${genome}.genes.gff3 \
                                                             -g ../../${genome}.fa \
                                                             -x ${genome}.genes.CDS.fa
