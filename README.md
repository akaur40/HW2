# ADS8192 Nextflow Pipeline

## Overview

This project implements a Nextflow pipeline that runs the ADS8192 R package for RNA-seq heatmap analysis.

The pipeline uses Docker to ensure a reproducible environment and executes the analysis in two stages:
1. Heatmap analysis using built-in example data
2. Output summarization

---

## Setup

### 1. Install requirements

Make sure you have:

- Docker
- Nextflow

Install Nextflow with conda:

```bash
conda create -n nextflow bioconda::nextflow
conda activate nextflow
```

### Build Docker Image
```bash
docker build -t ads8192-hw2 .
```

### Usage
Run the pipeline:
```bash
nextflow run main.nf -profile docker
```
```md
### Output
Results directory (`results/`)
- heatmap.pdf
- scaled_expression.tsv
- gene_modules.tsv
- module_gene_lists.tsv

Summary directory (`summary/`)
- pipeline_summary.txt
```