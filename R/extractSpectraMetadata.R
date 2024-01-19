extractSpectraMetadata <- function(spectra) {
  metadata <- data.frame(matrix(nrow = 0, ncol = 4))
  colnames(metadata) <- c("id", "sampleName", "replicateName", "acquisitionDate")

  for (id in names(spectra)) {
    spectrum <- spectra[[id]]
    row <- nrow(metadata) + 1
    metadata[row, "id"] <- spectrum@metaData$id
    metadata[row, "sampleName"] <- spectrum@metaData$sampleName
    metadata[row, "replicateName"] <- spectrum@metaData$replicateName
    metadata[row, "acquisitionDate"] <- spectrum@metaData$acquisitionDate
  }

  return(metadata)
}
