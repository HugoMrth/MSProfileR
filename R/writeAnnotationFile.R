writeAnnotationFile <- function(file, values) {
  if (is.null(values$spectra)) { return () }
  sampleName <- unique(unlist(lapply(values$spectra, function(spectrum) { spectrum@metaData$sampleName })))
  df <- data.frame(sampleName)
  write_xlsx(df, file)
}
