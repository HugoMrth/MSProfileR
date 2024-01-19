executePreprocessing <- function(values) {
  values$trimmedSpectra <- trimSpectra(values$spectra, values$trimParams)
  values$conformitySpectra <- conformitySpectra(values$trimmedSpectra, values$conformityParams)
  values$cleanedSpectra <- cleanSpectra(values$trimmedSpectra, values$cleanParams)
  screenResults <- screenSpectra_(values$cleanedSpectra, values$screenParams)
  values$typicalSpectra <- screenResults$typicalSpectra
  values$atypicalSpectra <- screenResults$atypicalSpectra
  values$screeningPlot <- screenResults$screeningPlot
  values$atypicalSpectraAfterSelection <- values$atypicalSpectra
  values$selectedSpectra <- values$typicalSpectra
  values$screeningEstTable <- screenResults$screeningEstTable
  values$mergedSpectra <- mergeSpectra(values$selectedSpectra, values$mergeParams)
  return(values)
}
