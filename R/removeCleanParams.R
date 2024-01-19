removeCleanParams <- function(values) {
  values$cleanParams <- FALSE
  updateClean(values)
}
