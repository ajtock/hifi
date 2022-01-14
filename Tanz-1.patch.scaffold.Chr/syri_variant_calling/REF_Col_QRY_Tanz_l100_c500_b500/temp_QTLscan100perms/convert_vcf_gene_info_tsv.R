#!/applications/R/R-4.0.0/bin/Rscript

# Usage:
# ./convert_vcf2tsv.R t2t-col.20210610.Chr Tanz-1.patch.scaffold.Chr QTL1 ''

#ref <- "t2t-col.20210610.Chr"
#qry <- "Tanz-1.patch.scaffold.Chr"
#qtl <- "QTL1"
#ann <- ""

args <- commandArgs(trailingOnly = T)
ref <- args[1]
qry <- args[2]
qtl <- args[3]
ann <- args[4]

options(stringsAsFactors = F)
library(stringr)

vcf <- read.table(paste0(ref, "_", qry, "_nm3_syri_filt.SnpSift_interval_", qtl, ann, ".vcf"),
                  header = T, skip = 37, comment.char = "", colClasses = "character")
colnames(vcf)[1] <- "CHROM"

func <- read.csv("TAIR10_functional_descriptions.csv", header = T)
meio <- read.csv("meiotic_RNA_expression.csv", header = T)


geneID_ranges_list <- str_extract_all(string = vcf$INFO, pattern = "AT\\dG[0-9]+-AT\\dG[0-9]+")
geneID_list <- str_extract_all(string = vcf$INFO, pattern = "AT\\dG[0-9]+")

sub(pattern = "\\.\\d+", replacement = "", x = tmp$name)


#if(ann %in% c("LOF_AND_HIGH", "LOF_NMD_AND_HIGH")) {
#  geneIDs <- str_extract_all(vcf$INFO, paste0(gsub("_.+", "", ann), "=\\(AT\\dG[0-9]+"))
#  geneIDs <- unique(gsub(paste0(gsub("_.+", "", ann), "=\\("), "", unlist(geneIDs)))
#} else {
#  geneIDs <- str_extract_all(vcf$INFO, paste0(gsub("_.+", "", ann), "\\|AT\\dG[0-9]+"))
#  geneIDs <- unique(gsub(paste0(gsub("_.+", "", ann), "\\|"), "", unlist(geneIDs)))
#}
#print(geneIDs)
#print(length(geneIDs))

write.table(vcf,
            file = paste0(ref, "_", qry, "_nm3_syri_filt.SnpSift_interval_", qtl, ann, ".tsv"),
            quote = F, sep = "\t", row.names = F, col.names = T)
