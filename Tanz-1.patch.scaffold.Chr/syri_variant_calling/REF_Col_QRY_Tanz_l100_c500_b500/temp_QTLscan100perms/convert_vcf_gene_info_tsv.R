#!/applications/R/R-4.0.0/bin/Rscript

# Usage:
# ./convert_vcf_gene_info_tsv.R t2t-col.20210610.Chr Tanz-1.patch.scaffold.Chr QTL1 '_HIGH'

#ref <- "t2t-col.20210610.Chr"
#qry <- "Tanz-1.patch.scaffold.Chr"
#qtl <- "QTL1"
#ann <- "_HIGH"

args <- commandArgs(trailingOnly = T)
ref <- args[1]
qry <- args[2]
qtl <- args[3]
ann <- args[4]

options(stringsAsFactors = F)
library(stringr)
library(dplyr)

vcf <- read.table(paste0(ref, "_", qry, "_nm3_syri_filt.SnpSift_interval_", qtl, ann, ".vcf"),
                  header = T, skip = 37, comment.char = "", colClasses = "character")
colnames(vcf)[1] <- "CHROM"

func <- read.csv("TAIR10_functional_descriptions.csv", header = T)
meio <- read.csv("meiotic_RNA_expression.csv", header = T)

func$GENE_ID <- sub(pattern = "\\.\\d+", replacement = "", x = func$Model_name)
meio$GENE_ID <- sub(pattern = "\\.\\d+", replacement = "", x = meio$target_id)

geneID_ranges_list <- str_extract_all(string = vcf$INFO, pattern = "AT\\dG[0-9]+-AT\\dG[0-9]+")
geneID_list <- str_extract_all(string = vcf$INFO, pattern = "AT\\dG[0-9]+")

geneID_ranges_seq_list <- lapply(1:length(geneID_ranges_list), function(x) {
# print(x)

 if(length(geneID_ranges_list[[x]]) > 0) {
   tmp <- str_extract_all(string = gsub(pattern = "AT\\dG",
                                        replacement = "",
                                        x = geneID_ranges_list[[x]]),
                          pattern = "[0-9]+")
  
   tmp2 <- lapply(1:length(tmp), function(y) {
     paste0(
            substr(geneID_ranges_list[[x]][y], start = 1, stop = 4),
            seq(from = min(tmp[[y]]), to = max(tmp[[y]]), by = 1)
           )
   })
  
   unique(unlist(tmp2))

 } else {
  character(0)
 }

})

geneID_list_comb <- lapply(seq_along(geneID_list), function(x) {
  sort(unique(c(geneID_list[[x]], geneID_ranges_seq_list[[x]])))
})

vcf_row_list <- lapply(1:nrow(vcf), function(x) {
#  print(x)
  if(length(geneID_list_comb[[x]]) > 0) {
    df_list <- lapply(1:length(geneID_list_comb[[x]]), function(y) {
      data.frame(vcf[x,],
                 GENE_ID = geneID_list_comb[[x]][y])
    })
    bind_rows(df_list, .id = "column_label")
  } else {
    data.frame(vcf[x,],
               GENE_ID = NA)
  }
})
                       
vcf_ext <- bind_rows(vcf_row_list, .id = "column_label")

# Append meiotic expression and functional info
vcf_ext <- merge(x = vcf_ext,
                 y = meio,
                 by.x = "GENE_ID",
                 by.y = "GENE_ID",
                 all.x = TRUE)
vcf_ext <- merge(x = vcf_ext,
                 y = func,
                 by.x = "target_id",
                 by.y = "Model_name",
                 all.x = TRUE)

vcf_ext <- vcf_ext[,-which(colnames(vcf_ext) == "column_label")]
vcf_ext$POS <- as.integer(vcf_ext$POS)
vcf_ext <- vcf_ext[ with(vcf_ext, order(CHROM, POS)) , ]

write.table(vcf_ext,
            file = paste0(ref, "_", qry, "_nm3_syri_filt.SnpSift_interval_", qtl, ann, "_extended.tsv"),
            quote = F, sep = "\t", row.names = F, col.names = T)
