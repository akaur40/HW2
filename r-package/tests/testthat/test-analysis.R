test_that("run_heatmap_analysis returns correct structure", {
  data("example_se", package = "ADS8192")

  result <- run_heatmap_analysis(example_se)

  expect_type(result, "list")
  expect_named(result, c("heatmap", "scaled_matrix", "gene_modules"))
})

# expect_error(result, "Input is not correct, heatmap is not correct", fixed = TRUE)

test_that("scaled matrix has correct dimensions", {
  data("example_se", package = "ADS8192")

  result <- run_heatmap_analysis(example_se, n_top = 100)

  expect_true(nrow(result$scaled_matrix) == 100)
})

test_that("gene modules are assigned", {
  data("example_se", package = "ADS8192")

  result <- run_heatmap_analysis(example_se)

  expect_true("module" %in% colnames(result$gene_modules))
  expect_true("gene" %in% colnames(result$gene_modules))
})

test_that("run_heatmap_analysis errors on invalid n_top", {
  data("example_se", package = "ADS8192")

  expect_error(
    run_heatmap_analysis(example_se, n_top = -10),
  )
})








