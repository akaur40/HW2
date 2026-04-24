select_top_variable_genes <- function(mat, n_top = 500) {
  gene_vars <- apply(mat,1,stats::var)
  top_idx <- order(gene_vars, decreasing = TRUE)[seq_len(n_top)]
  mat_top <- mat[top_idx,,drop=FALSE]
  return(mat_top)
}
