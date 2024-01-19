computeIntensityMatrixPheatmap <- function(intensityMatrix_, spectra, showRownames) {
  if (is.null(intensityMatrix_)) { return () }
  savedColnames <- colnames(intensityMatrix_)
  savedRownames <- rownames(intensityMatrix_)
  colnames(intensityMatrix_) <- paste(round(as.double(colnames(intensityMatrix_)), 1), 'm/z')
  rownames(intensityMatrix_) <- extractSpectraMetadata(spectra)$sampleName
  pheatmap_ <- pheatmap(intensityMatrix_,
                        cluster_rows = TRUE,
                        cluster_cols= FALSE,
                        show_colnames = FALSE,
                        show_rownames = showRownames)
  colnames(intensityMatrix_) <- savedColnames
  rownames(intensityMatrix_) <- savedRownames
  return(pheatmap_)
}
