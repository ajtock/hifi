#!/bin/bash

# Usage:
# ./convert_gene_Liftoff_GFF3_to_GTF.sh Cvi-0.ragtag_scaffolds.Chr

genome=$1

/applications/cufflinks/cufflinks-2.2.1.Linux_x86_64/gffread ${genome}.genes.gff3 \
                                                             -T -o ${genome}.genes.gtf
