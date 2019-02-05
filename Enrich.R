############ Enrichment analysis using g:profiler tool#####################################
###################################################################################################
# Reference for package: https://cran.r-project.org/web/packages/gProfileR/gProfileR.pdf

library(gProfileR)

genes < -"genes.CSV"

QueryGenes < -read.csv(genes, header=T)

QueryGeneVector < -as.vector(QueryGenes[1])
#head(QueryGeneVector)

# Enrichment analysis
#  correction_method= "fdr",  "analytical", "gSCS",
# "fdr", "bonferroni".
EnrichmentResults = gprofiler(QueryGeneVector, organism="hsapiens", correction_method="fdr",
                              src_filter="GO:BP", exclude_iea=T, evcodes=T,
                              hier_filtering="none")
write.csv(EnrichmentResults, file="gprofileGo.csv")
