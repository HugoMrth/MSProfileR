writeFigures <- function(path, values) {
  dir.create(file.path(path, "figures"))
  writeMassBoundsPlot(file.path(path, "figures", "mass_bounds.svg"), values)
  writeScreeningPlot(file.path(path, "figures", "screening.svg"), values)
  writePeaksCountsBySNRPlot(file.path(path, "figures", "peak_counts_by_SNR.svg"), values)
  writeReferencePeaksPlot(file.path(path, "figures", "reference_peaks.svg"), values)
  writeAlignedSpectraPlot(file.path(path, "figures", "spectra_aligned.svg"), values)
  writeBinnedPeaksPlot(file.path(path, "figures", "peaks_binned.svg"), values)
  writeFilteredPeaksPlot(file.path(path, "figures", "peaks_filtered.svg"), values)
  writeIntensityMatrixPlot(file.path(path, "figures", "intensity_matrix_32x16.svg"), values, 32, 16, TRUE)
  writeIntensityMatrixPlot(file.path(path, "figures", "intensity_matrix_16x8.svg"), values, 16, 8, TRUE)
  writeIntensityMatrixPlot(file.path(path, "figures", "intensity_matrix_8x4.svg"), values, 8, 4, FALSE)
  writeDendrogramPlot(file.path(path, "figures", "dendrogram.svg"), values)
}
