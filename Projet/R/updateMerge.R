updateMerge <- function(values) {
  enableOrDisableParams(c('averageMassSpectraMethod'), values$mergeParams)
  values$mergedSpectra <- mergeSpectra(values$selectedSpectra,
                                       values$mergeParams)
  values$clearProcessing <- TRUE
}
