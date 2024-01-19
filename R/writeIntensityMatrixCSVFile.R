writeIntensityMatrixCSVFile <- function(file, values) {
  if (is.null(values$intensityMatrix)) { return() }
  intensityMatrix <- values$intensityMatrix
  intensityMatrix <- cbind(extractSpectraMetadata(values$peakDetectionSpectra)[,'sampleName'], intensityMatrix)
  write.matrix(intensityMatrix, file=file, sep = ';')
}
