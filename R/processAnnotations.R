processAnnotations <- function(values) {
  values$annotations <- NULL
  values$annotationError <- NULL
  values$annotationStatistics <- NULL

  if (is.null(values$rawAnnotations)) {
    return()
  }

  if(!("sampleName" %in% colnames(values$rawAnnotations)))
  {
    values$annotationError <- 'Error: Column "sampleName" does not exist.'
    return ()
  }

  annotationSampleNames <- values$rawAnnotations$sampleName
  duplicatedSampleNames <- annotationSampleNames[duplicated(annotationSampleNames)]

  if (length(duplicatedSampleNames) > 0) {
    values$annotationError <- paste('Error: Column "sampleName" contains duplicated names (',
                                    paste(duplicatedSampleNames, collapse = ', '),
                                    ')', sep='')
    return ()
  }

  if(is.null(values$spectra)) {
    return()
  }

  extractSampleName <- function(spectrum) { spectrum@metaData$sampleName }
  spectraSampleNames <- unique(unlist(lapply(values$spectra, function(spectrum) { spectrum@metaData$sampleName })))

  values$annotationStatistics <- data.frame(
    Names = c("Number of annotations",
              "Number of spectra",
              "Number of annotation without spectrum",
              "Number of spectra without annotation"),
    Values = c(length(annotationSampleNames),
               length(spectraSampleNames),
               length(setdiff(annotationSampleNames, spectraSampleNames)),
               length(setdiff(spectraSampleNames, annotationSampleNames)))
  )

  values$annotations <- values$rawAnnotations
}
