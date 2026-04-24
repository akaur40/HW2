#!/bin/bash -ue
mkdir -p summary
echo "ADS8192 pipeline completed successfully" > summary/pipeline_summary.txt
echo "Output files:" >> summary/pipeline_summary.txt
find results -type f >> summary/pipeline_summary.txt
