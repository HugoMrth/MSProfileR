writeScreeningPlot <- function(file, values) {
  if (is.null(values$screeningPlot)) { return() }
  svg(file=file, width = 8, height = 4)
  plot(values$screeningPlot)
  dev.off()
}
