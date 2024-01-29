updateMergeParams <- function(session, input, params, values) {
  values$mergeParams <- params
  if (isFALSE(params)) { return() }
  updateRadioButtons(session,'averageMassSpectraMethod',
                     selected=params$averageMassSpectraMethod)
}
