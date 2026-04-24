build_heatmap <- function(mat_scaled, se, gene_k = 5, column_split_by = "strain") {

  # metadata
  strain <- se$strain
  minute <- as.character(se$minute)

  split_vec <- SummarizedExperiment::colData(se)[[column_split_by]]

  # colors
  strain_colors <- c(wt = "#027a2a", mut = "#a50181")

  minute_colors <- c(
    "0"   = "#a1a1a0",
    "15"  = "#FDCC8A",
    "30"  = "#FC8D59",
    "60"  = "#E34A33",
    "120" = "#B30000",
    "180" = "#7A0000"
  )

  module_colors <- c("#3C5488", "#00A087", "#F39B7F", "#8491B4", "#91D1C2")[seq_len(gene_k)]

  # column annotations
  col_anno <- ComplexHeatmap::HeatmapAnnotation(
    strain = strain,
    minute = minute,
    col = list(
      strain = strain_colors,
      minute = minute_colors
    )
  )

  # row annotations (k-means blocks)
  row_anno <- ComplexHeatmap::rowAnnotation(
    module = ComplexHeatmap::anno_block(
      gp = grid::gpar(fill = module_colors),
      labels = paste0("M", seq_len(gene_k)),
      labels_gp = grid::gpar(col = "white")
    )
  )

  # heatmap
  ht <- ComplexHeatmap::Heatmap(
    mat_scaled,
    name = "Z-score",
    top_annotation = col_anno,
    left_annotation = row_anno,
    row_km = gene_k,
    column_split = split_vec,
    show_row_names = FALSE,
    show_column_names = FALSE
  )

  ht_drawn <- ComplexHeatmap::draw(ht)
  return(ht_drawn)
}
