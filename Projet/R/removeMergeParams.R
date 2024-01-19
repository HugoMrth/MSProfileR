removeMergeParams <- function(values) {
  values$mergeParams <- FALSE
  updateMerge(values)
}
