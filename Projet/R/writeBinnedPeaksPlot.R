writeBinnedPeaksPlot <- function(file, values) {
  if (is.null(values$binnedPeaks)) { return () }
  svg(file=file, width = 8, height = 4)
  computeSpectraPheatmap(values$binnedPeaks)
  dev.off()
}
