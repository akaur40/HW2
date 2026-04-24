extract_gene_modules <- function(ht_drawn, mat_scaled) {

  row_clusters <- ComplexHeatmap::row_order(ht_drawn)

  gene_modules <- integer(nrow(mat_scaled))

  for (i in seq_along(row_clusters)) {
    gene_modules[row_clusters[[i]]] <- i
  }

  names(gene_modules) <- rownames(mat_scaled)

  module_df <- data.frame(
    gene = names(gene_modules),
    module = paste0("M", gene_modules),
    stringsAsFactors = FALSE
  )

  return(module_df)
}
