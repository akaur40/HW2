#!/usr/bin/env nextflow

params.input_file = "data/test/test_input.csv"

include { ads8192_heatmap; summarize_outputs } from "./modules/ADS8192.nf"

workflow {
    ch_input = channel.fromPath(params.input_file, checkIfExists: true)
    ch_input = ch_input.map { it }

    ads8192_heatmap(ch_input)
    summarize_outputs(ads8192_heatmap.out)
}