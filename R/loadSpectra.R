loadSpectra <- function(spectraPath, directoryLevel) {
  out <- tryCatch(
    {
      spectra <- import(spectraPath, verbose=TRUE)
      names(spectra) <- seq(from=1, to=length(spectra))
      for (id in names(spectra)) {
        spectrum <- spectra[[id]]
        sampleName <- extractSampleName(spectrum@metaData$file, directoryLevel)
        metaData <- list(
          id=id,
          name=paste(sampleName,' [', spectrum@metaData$spot, ']', sep=''),
          sampleName=sampleName,
          replicateName=spectrum@metaData$spot,
          acquisitionDate=spectrum@metaData$acquisitionDate
        )
        spectra[[id]]@metaData <- metaData
        print(spectrum@metaData$name)
      }
      return(spectra)
    },
    error=function(condition) {
      return (NULL)
    }
  )
  return (out)
}
