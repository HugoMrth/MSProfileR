removeTrimParams <- function(values) {
  values$trimParams <- FALSE
  updateTrim(values)
}
