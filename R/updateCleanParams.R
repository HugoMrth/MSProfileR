updateCleanParams <- function(session, input, params, values) {
  values$cleanParams <- params
  if (isFALSE(params)) { return() }
  updateRadioButtons(session,'transformIntensityMethod',
                     selected=params$transformIntensityMethod)
  updateRadioButtons(session,'smoothIntensityMethod',
                     selected=params$smoothIntensityMethod)
  updateNumericInput(session,'halfWindowSize',
                     value=params$halfWindowSize)
  updateRadioButtons(session,'removeBaselineMethod',
                     selected=params$removeBaselineMethod)
  updateNumericInput(session,'removeBaselineIterations',
                     value=params$removeBaselineIterations)
  updateRadioButtons(session,'calibrateIntensityMethod',
                     selected=params$calibrateIntensityMethod)
}
