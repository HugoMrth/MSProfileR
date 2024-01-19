computeMassBoundsPlot <- function(spectra) {
  if (is.null(spectra)) { return() }
  masses <- c()
  bounds <- c()
  for (i in 1:length(spectra)){
    if (length(spectra[[i]]@mass) == 0) { next }
    masses <- c(masses, min(spectra[[i]]@mass), max(spectra[[i]]@mass))
    bounds <- c(bounds, "minimum", "maximum")
  }
  if (length(masses) == 0) {
    return(NULL)
  }
  masses = masses / 1000
  plot <- ggplot2::qplot(masses, rep(0, length(spectra)*2), color=bounds) +
    ggplot2::theme(aspect.ratio=0.05,
          legend.position = "none",
          axis.title.y=ggplot2::element_blank(),
          axis.text.y=ggplot2::element_blank(),
          axis.ticks.y=ggplot2::element_blank()) +
    ggplot2::scale_x_continuous(breaks = round(seq(min(masses), max(masses), by=1), 1)) +
    ggplot2::xlab("Masses (KDa)")
  return(plot)
}
