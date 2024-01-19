mergeSpectra <- function(spectra, params) {
  if (is.null(spectra) | isFALSE(params)) { return (spectra) }
  metadata <- extractSpectraMetadata(spectra)
  mergedSpectra <- averageMassSpectra(spectra,
                                      labels=factor(metadata$sampleName),
                                      method=params$averageMassSpectraMethod)
  names(mergedSpectra) <- seq(from=1, to=length(mergedSpectra))
  for (id in names(mergedSpectra)) {
    spectrum <- mergedSpectra[[id]]
    mergedSpectra[[id]]@metaData$id <- id
    mergedSpectra[[id]]@metaData$sampleName <- spectrum@metaData$sampleName[1]
    mergedSpectra[[id]]@metaData$replicateName <- paste(spectrum@metaData$replicateName, collapse=' ')
    mergedSpectra[[id]]@metaData$acquisitionDate <- spectrum@metaData$acquisitionDate[1]
    mergedSpectra[[id]]@metaData$name <- paste( mergedSpectra[[id]]@metaData$sampleName,
                                                ' [', mergedSpectra[[id]]@metaData$replicateName, ']', sep='')
  }
  return (mergedSpectra)
}
