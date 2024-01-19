writeIntensityMatrixPlot <- function(file, values, width, height, showRownames) {
  if (is.null(values$intensityMatrix)) { return () }
  svg(file=file, width = width, height = height)
  computeIntensityMatrixPheatmap(values$intensityMatrix, values$alignedSpectra, showRownames)
  dev.off()
}
