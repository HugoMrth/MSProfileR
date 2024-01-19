writeReferencePeaksPlot <- function(file, values) {
  if (is.null(values$referencePeaks)) { return () }
  svg(file=file, width = 8, height = 4)
  plot(values$referencePeaks)
  dev.off()
}
