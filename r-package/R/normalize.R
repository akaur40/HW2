normalize_counts <- function(se){
  mat <- SummarizedExperiment::assay(se, "counts")
  lib_sizes <- colSums(mat)
  mat_norm <- log2(t(t(mat) / lib_sizes*1e6) +1)
  return(mat_norm)
}
