updateComputeIntensityMatrixParams <- function(session, input, params, values) {
  values$computeIntensityMatrixParams <- params
  if (isFALSE(params)) { return() }
  updateCheckboxInput(session,'fillMissingValues',
                      value=params$fillMissingValues)
}
