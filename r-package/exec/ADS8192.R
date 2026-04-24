#!/usr/bin/env Rapp
#| name: ADS8192
#| title: "ADS8192 Heatmap CLI"
#| description: "Command line interface for ADS8192."

switch(
  "",

  #| title: "Run heatmap analysis"
  #| description: "Run heatmap analysis and export TSV results."
  heatmap = {

    #| description: "Path to counts matrix (TSV/CSV)"
    #| short: c
    counts <- ""

    #| description: "Path to sample metadata (TSV/CSV)"
    #| short: m
    meta <- ""

    #| description: "Output directory"
    #| short: o
    output <- ""

    #| description: "Number of top variable genes"
    #| short: n
    n_top <- 500L

    #| description: "Scaling method: zscore, minmax, or none"
    scale_method <- "zscore"

    #| description: "Number of gene modules"
    gene_k <- 5L

    #| description: "Metadata column used for column splitting"
    column_split_by <- "strain"

    if (counts == "" || meta == "" || output == "") {
      stop("--counts, --meta, and --output are required", call. = FALSE)
    }

    suppressPackageStartupMessages(library(ADS8192))
    suppressPackageStartupMessages(library(SummarizedExperiment))

    read_data_file <- function(path) {
      ext <- tolower(tools::file_ext(path))
      if (ext == "csv") {
        read.csv(path, row.names = 1, check.names = FALSE)
      } else {
        read.table(path, sep = "\t", header = TRUE, row.names = 1, check.names = FALSE)
      }
    }

    counts_df <- read_data_file(counts)
    meta_df <- read_data_file(meta)

    se <- SummarizedExperiment(
      assays = list(counts = as.matrix(counts_df)),
      colData = meta_df
    )

    run_heatmap_analysis(
      se = se,
      n_top = n_top,
      scale_method = scale_method,
      gene_k = gene_k,
      column_split_by = column_split_by,
      output_dir = output
    )

    message("Analysis complete.")
  }
)
