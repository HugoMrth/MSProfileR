computeSpectraPheatmap <- function(spectra, width = 500,
                                   cluster_rows = FALSE) {
  if (is.null(spectra)) { return() }
  pixels <- matrix(255, ncol=width, nrow=length(spectra))
  minMass <- min(unlist(lapply(spectra, function(spectrum) { min(spectrum@mass) })))
  maxMass <- max(unlist(lapply(spectra, function(spectrum) { max(spectrum@mass) })))
  maxIntensity <- max(unlist(lapply(spectra, function(spectrum) { max(spectrum@intensity) })))
  index <- 1
  for (spectrum in spectra) {
    x <- index
    for (i in 0:length(mass(spectrum))) {
      mass <- spectrum@mass[i]
      intensity <- spectrum@intensity[i]
      y <- floor((width * (mass - minMass) / (maxMass - minMass)))
      pixels[x, y] <- floor(255 * (1 - sqrt(intensity / maxIntensity)))
    }
    index <- index + 1
  }
  colnames(pixels) <- sapply(1:width, function(i) {
    if (i%%30!=1) ""
    else paste(round(i * ((maxMass - minMass) / width) + minMass, digits=1), "m/z")
  })
  return(pheatmap(pixels,
                  color = grey(seq(0, 1, length = 256)),
                  cluster_rows=cluster_rows,
                  cluster_cols=FALSE,
                  legend = FALSE))
}
