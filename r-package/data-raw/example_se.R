## code to prepare `example_se` dataset goes here

library(fission)
library(SummarizedExperiment)

data(fission)
example_se <- fission

usethis::use_data(example_se, overwrite = TRUE)
