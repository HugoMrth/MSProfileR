computeNameFromSpectraIds <- function(spectra, ids) {
  displayName <- function(id) {
    paste(spectra[[id]]@metaData$id,': ', spectra[[id]]@metaData$sampleName,' [',spectra[[id]]@metaData$replicateName,']',sep='')
  }
  return (unlist(lapply(ids, displayName)))
}
