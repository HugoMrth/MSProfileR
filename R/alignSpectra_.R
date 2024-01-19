alignSpectra_ <- function(spectra,
                          peaks,
                          reference,
                          params) {
  if (is.null(peaks) | is.null(reference) | isFALSE(params)) return (spectra)
  warpingFunctions <- determineWarpingFunctions(peaks,
                                                reference = reference,
                                                tolerance = params$referencePeaksTolerance,
                                                method = params$alignmentWarpingMethod,
                                                allowNoMatches = TRUE)
  return(warpMassSpectra(spectra, warpingFunctions, emptyNoMatches = TRUE))
}
