writeFilteredPeaksPlot <- function(file, values) {
  if (is.null(values$filteredPeaks)) { return () }
  svg(file=file, width = 8, height = 4)
  computeSpectraPheatmap(values$filteredPeaks)
  dev.off()
}
