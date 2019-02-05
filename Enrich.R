############ Enrichment analysis using g:profiler tool#####################################
###################################################################################################
# Reference for package: https://cran.r-project.org/web/packages/gProfileR/gProfileR.pdf
# Supeertive reference: 'Impact of outdate gene annotations on pathway enrichment analysis 2016'; 'pathway and network analysis of cancer genomes'

library(gProfileR)

genes < -"genes.CSV"

QueryGenes < -read.csv(genes, header=T)

QueryGeneVector < -as.vector(QueryGenes[1])
head(QueryGeneVector)

# Enrichment analysis
#  correction_method= "fdr", here value can be "analytical": value from tools (more regid), "gSCS",
# "fdr", "bonferroni".
EnrichmentResults = gprofiler(QueryGeneVector, organism="hsapiens", correction_method="fdr",
                              src_filter="GO:BP", exclude_iea=T, evcodes=T,
                              hier_filtering="none")
write.csv(EnrichmentResults, file="gprofileGo.csv")