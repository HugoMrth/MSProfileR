cleanSpectra <- function(spectra, params) {
  if (is.null(spectra) | isFALSE(params)) { return (spectra) }
  spectra <- transformIntensity(spectra,
                                method=params$transformIntensityMethod)
  spectra <- smoothIntensity(spectra,
                             method=params$smoothIntensityMethod,
                             halfWindowSize=params$halfWindowSize)
  if (params$removeBaselineMethod=="SNIP") {
    spectra <- removeBaseline(spectra,
                              method=params$removeBaselineMethod,
                              iterations=params$removeBaselineIterations)
  } else {
    spectra <- removeBaseline(spectra,
                              method=params$removeBaselineMethod)
  }
  spectra <- calibrateIntensity(spectra,
                                method=params$calibrateIntensityMethod)
  names(spectra) <- seq(from=1, to=length(spectra))
  return(spectra)
}
