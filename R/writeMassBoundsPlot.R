writeMassBoundsPlot <- function(file, values) {
  if (is.null(values$trimmedSpectra)) { return() }
  ggsave(file, computeMassBoundsPlot(values$trimmedSpectra))
}
