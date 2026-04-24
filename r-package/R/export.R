#' Export heatmap analysis results
#'
#' Writes the scaled expression matrix, per-gene module assignments,
#' and per-module gene lists to tab-separated files in the output directory.
#'
#' @param mat_scaled A scaled genes x samples matrix.
#' @param module_df A data frame containing gene-to-module assignments.
#' @param output_dir Directory where output files will be written.
#'
#' @return Invisible NULL. Files are written to disk.
#' @export
#'
#' @examples
#' \dontrun{
#' data("example_se", package = "ADS8192")
#' result <- run_heatmap_analysis(example_se)
#' export_results(result$scaled_matrix, result$gene_modules, tempdir())
#' }
#'
#' @param heatmap Optional heatmap object to save as a PDF.
export_results <- function(mat_scaled, module_df, output_dir, heatmap =NULL) {
  if (!dir.exists(output_dir)){
    dir.create(output_dir, recursive = TRUE)
  }


  # scaled expression
  scaled_out <- as.data.frame(mat_scaled)
  scaled_out$gene <- rownames(mat_scaled)

  utils::write.table(
    scaled_out,
    file.path(output_dir, "scaled_expression.tsv"),
    sep = "\t",
    row.names = FALSE,
    quote = FALSE
  )

  # gene modules
  utils::write.table(
    module_df,
    file.path(output_dir, "gene_modules.tsv"),
    sep = "\t",
    row.names = FALSE,
    quote = FALSE
  )

  # module gene lists
  module_gene_list <- do.call(rbind, lapply(unique(module_df$module), function(m) {
    genes <- module_df$gene[module_df$module == m]
    data.frame(
      module = m,
      n_genes = length(genes),
      genes = paste(genes, collapse = ","),
      stringsAsFactors = FALSE
    )
  }))

  utils::write.table(
    module_gene_list,
    file.path(output_dir, "module_gene_lists.tsv"),
    sep = "\t",
    row.names = FALSE,
    quote = FALSE
  )

if (!is.null(heatmap)) {
  grDevices::pdf(file.path(output_dir, "heatmap.pdf"))
  ComplexHeatmap::draw(heatmap)
  grDevices::dev.off()
}
  invisible(NULL)
}
