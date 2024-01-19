extractComputeIntensityMatrixParams <- function(input, values) {
  values$computeIntensityMatrixParams <- list(
    fillMissingValues=input$fillMissingValues
  )
  updateComputeIntensityMatrix(values)
}
