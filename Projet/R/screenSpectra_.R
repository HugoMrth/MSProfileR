screenSpectra_ <- function(spectra, params) {
  if (is.null(spectra) | isFALSE(params)) {
    return(list(
      typicalSpectra=spectra,
      atypicalSpectra=list(),
      screeningPlot=NULL
    ))
  }
  screenResults <- screenSpectra(spectra,
                                 estimator = params$scaleEstimator,
                                 method=params$atypicalIdentificationMethod,
                                 threshold = params$threshold)
  if (params$includeLowerSpectra) {
    screenResults$lower <- 0
  }
  est <- screenResults$est.table$`A score`
  typicalSpectra <- spectra[which(est <= screenResults$upper & est >= screenResults$lower)]
  atypicalSpectra <- spectra[which(est > screenResults$upper | est < screenResults$lower | is.na(est))]
  screeningPlot <- plot.scSpectra(screenResults, labels = TRUE)
  return(list(typicalSpectra=typicalSpectra,
              atypicalSpectra=atypicalSpectra,
              screeningPlot=screeningPlot,
              screeningEstTable=screenResults$est.table))
}
