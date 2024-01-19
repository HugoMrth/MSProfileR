plotSpectrumWithPeaks <- function(spectrum, peaks) {
  plot(spectrum)
  index <- sort(intensity(peaks), decreasing=TRUE, index.return=TRUE)$ix
  labelPeaks(peaks, index=index, labels=1:length(peaks@mass), underline=FALSE)
}
