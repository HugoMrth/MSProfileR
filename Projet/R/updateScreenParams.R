updateScreenParams <- function(session, input, params, values) {
  values$screenParams <- params
  if (isFALSE(params)) { return() }
  updateRadioButtons(session,'scaleEstimator',
                     selected=params$scaleEstimator)
  updateRadioButtons(session,'atypicalIdentificationMethod',
                     selected=params$atypicalIdentificationMethod)
  updateNumericInput(session,'threshold',
                     value=params$threshold)
  updateCheckboxInput(session,'includeLowerSpectra',
                      value=params$includeLowerSpectra)
}
