extractAlignSpectraParams <- function(input, values) {
  values$alignSpectraParams <- list(
    referencePeaksTolerance=input$referencePeaksTolerance,
    alignmentWarpingMethod=input$alignmentWarpingMethod
  )
  updateAlignSpectra(values)
}
