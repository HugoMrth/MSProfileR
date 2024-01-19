writeAlignedSpectraPlot <- function(file, values) {
  if (is.null(values$alignedSpectra)) { return () }
  svg(file=file, width = 8, height = 4)
  computeSpectraPheatmap(values$alignedSpectra)
  dev.off()
}
