writeDendrogramPlot <- function(file, values) {
  if (is.null(values$intensityMatrix)) { return () }
  svg(file=file, width = 16, height = 8)
  par(mar = c(0, 0, 0, 10))
  pheatmap_ = computeIntensityMatrixPheatmap(values$intensityMatrix, values$alignedSpectra, TRUE)
  plot(as.dendrogram(pheatmap_$tree_row), horiz=TRUE)
  dev.off()
}
