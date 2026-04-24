process ads8192_heatmap {

    container "ads8192-hw2"

    input:
    path input_file

    output:
    path "results/"

    script:
    """
    mkdir -p results
   Rscript -e 'data("example_se", package = "ADS8192"); ADS8192::run_heatmap_analysis(example_se, output_dir = "results")'
    """
}

process summarize_outputs {

input:
path results_dir

output:
path "summary/"

script:
"""
mkdir -p summary
echo "ADS8192 pipeline completed successfully" > summary/pipeline_summary.txt
echo "Output files:" >> summary/pipeline_summary.txt
find ${results_dir} -type f >> summary/pipeline_summary.txt
"""
}