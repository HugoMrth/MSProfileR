updateScreen <- function(values) {
  enableOrDisableParams(c('scaleEstimator',
                          'atypicalIdentificationMethod',
                          'threshold',
                          'includeLowerSpectra'), values$screenParams)
  screenResults <- screenSpectra_(values$cleanedSpectra, values$screenParams)
  values$typicalSpectra <- screenResults$typicalSpectra
  values$atypicalSpectra <- screenResults$atypicalSpectra
  values$screeningPlot <- screenResults$screeningPlot
  values$screeningEstTable <- screenResults$screeningEstTable
  values$selectedSpectra <- values$typicalSpectra
  values$atypicalSpectraAfterSelection <- values$atypicalSpectra
  removeMergeParams(values)
}
