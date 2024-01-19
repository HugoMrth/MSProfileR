computePeakCount <- function(peaks) {
  differentMass <- c()
  for (massPeaks in peaks) {
    differentMass <- c(differentMass, mass(massPeaks))
    differentMass <- differentMass[!duplicated(differentMass)]
  }
  return(length(differentMass))
}
