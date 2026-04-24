#' Run the full heatmap analysis pipeline
#'
#' @param se A SummarizedExperiment object.
#' @param n_top Number of top variable genes to keep.
#' @param scale_method Scaling method: "zscore", "minmax", or "none".
#' @param gene_k Number of row k-means clusters.
#' @param column_split_by Metadata column used for sample splitting.
#' @param output_dir Optional output directory for TSV outputs.
#'
#' @return A list containing the heatmap, scaled matrix, and gene module assignments.
#' @export
#' @examples
#' \dontrun{
#' data("example_se", package = "ADS8192")
#' result <- run_heatmap_analysis(
#'   se = example_se,
#'   n_top = 100,
#'   scale_method = "zscore",
#'   gene_k = 5,
#'   column_split_by = "strain"
#' )
#' }
run_heatmap_analysis <- function(se,
                                 n_top = 500,
                                 scale_method = "zscore",
                                 gene_k = 5,
                                 column_split_by = "strain",
                                 output_dir = NULL) {

  if (!is.numeric(n_top) || length(n_top) !=1 || n_top <=0) {
    stop("n_top must be a positive number")
  }

  # Step 1: normalize counts
  mat_norm <- normalize_counts(se)

  # Step 2: select top variable genes
  mat_top <- select_top_variable_genes(mat_norm, n_top)

  # Step 3: scale matrix
  mat_scaled <- scale_expression_matrix(mat_top, scale_method)

  # Step 4: build heatmap
  ht <- build_heatmap(mat_scaled, se, gene_k, column_split_by)

  # Step 5: extract gene modules
  module_df <- extract_gene_modules(ht, mat_scaled)

  # Step 6: export results
  if (!is.null(output_dir)) {
    export_results(mat_scaled, module_df, output_dir, heatmap=ht)
  }

  # return
  list(
    heatmap = ht,
    scaled_matrix = mat_scaled,
    gene_modules = module_df
  )
}
