# FunVar
## A Systematic Pipeline to Unravel the Convergence Patterns of Genetic Variants in Complex Diseases
FunVar (Functional annotation of Variants ) utilizes the existing resources to streamline and to improve the functional enrichment analysis of genetic variants disrupting genes in patients. FunVar, a semi-automated pipeline consist of three different and independent modules.

## Module 1:
Module 1 encapsulate the data input and data processing functionality. It measures the quality and relevance of available data according to the final objective of the analysis.

First, the genetic variants coming out from genomic studies, which are common in healthy individuals (controls) are excluded using an R script (Frequency.R). Moreover, a manual inspection of rare genetic variants is needed to remove the genetic variants which could be artefacts or error from genetics techniques.

Second step is the screening of tissue specific genes, disrupted by rare genetic variants. Tissue specific filtration is required because the inclusion of non-disease specific genes in functional enrichment analysis may result in bias output.

## Module 2:
Module 2 performs the enrichment analysis of genes spanned by rare and tissue specific genetic variants. G:profiler tool (https://biit.cs.ut.ee/gprofiler/) was employed to find enriched Gene Ontology (GO) terms for genes. However any enrichment analysis tool like enrichr (http://amp.pharm.mssm.edu/Enrichr/) or David (https://david.ncifcrf.gov/) can be used for this purpose. G:profiler can be applied using either R (Enrich.R) or python (Enrich.py) script.

## Module 3:
Module 3 is the post-processing module. Revigo tool was employed to group highly similar GO terms, which may be misleading in interpreting the results . Revigo tool can be applied using “Revigo_ana” function in “Enrich.py” script which was obtained from the revigo.py, hosted at https://gist.github.com/SamDM/b7e8a13a5529c24291e293ee6ebe2366 or it can be applied by uploading the go terms on Revigo webpage (http://revigo.irb.hr/).

**Note: Depending upon the databases update, results may differ from the results that are presented in the FunVar paper.**
