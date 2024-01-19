conformityTests <- function(spectra) {
  emptySpectraCount <- sum(sapply(spectra, isEmpty))
  irregularSpectraCount <- sum(!sapply(spectra, isRegular))
  lengthTable <- table(sapply(spectra, length))
  differentSpectraLengthCount <- (dim(lengthTable) > 10)
  results <- data.frame(
    Criteria = c("Number of empty spectra",
                 "Number of irregular spectra",
                 "Number of different lengths"),
    Results = c(emptySpectraCount, irregularSpectraCount, differentSpectraLengthCount)
  )
  return(results)
}
