scale_expression_matrix <- function(mat, method = "zscore") {
  if (method == "zscore") {
    mat_scaled <- t(scale(t(mat)))
  } else if (method == "minmax") {
    mat_scaled <- t(apply(mat, 1, function(x){
      (x-min(x)) / (max(x) - min(x))
    }))
  } else if (method == "none") {
    mat_scaled <- mat
  } else {
    stop("Invalid method. Choose 'zscore', 'minmax', or 'none'")
  }
  return(mat_scaled)
}
