writePeaksCountsBySNRPlot <- function(file, values) {
  if (is.null(values$peakCountsBySNR)) { return() }
  svg(file=file, width = 8, height = 4)
  boxplot(values$peakCountsBySNR)
  dev.off()
}
