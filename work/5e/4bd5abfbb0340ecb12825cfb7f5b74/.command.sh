#!/bin/bash -ue
mkdir -p results
Rscript -e 'data("example_se", package = "ADS8192"); ADS8192::run_heatmap_analysis(example_se, output_dir = "results")'
