updateClean <- function(values) {
  enableOrDisableParams(c('transformIntensityMethod',
                          'smoothIntensityMethod',
                          'halfWindowSize',
                          'removeBaselineMethod',
                          'removeBaselineIterations',
                          'calibrateIntensityMethod'),
                        values$cleanParams)
  values$cleanedSpectra <- cleanSpectra(values$conformitySpectra, values$cleanParams)
  removeScreenParams(values)
}
