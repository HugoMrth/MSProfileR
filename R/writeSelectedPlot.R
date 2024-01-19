writeSelectedPlot <- function(file, values) {
  if (is.null(values$selectedSpectrum)) { return() }
  svg(file=file, width=8, height=4)
  if (values$selectedSpectrumState == 'atypical') {
    plot(values$atypicalSpectraAfterSelection[[values$selectedSpectrum]])
  } else {
    plot(values$selectedSpectra[[values$selectedSpectrum]])
  }
  dev.off()
}
