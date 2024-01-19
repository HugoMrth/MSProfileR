extractMergeParams <- function(input, values) {
  values$mergeParams <- list(
    averageMassSpectraMethod=input$averageMassSpectraMethod
  )
  updateMerge(values)
}
