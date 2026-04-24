# Internal reference so R CMD check recognizes GenomicRanges as a real
# package dependency. The bundled example_se object contains
#GenomicRanges classes through its row ranges.

.genomicranges_dependency <- function() {
  GenomicRanges::GRanges()
}
