extractComputeReferencePeaksParams <- function(input, values) {
  values$computeReferencePeaksParams <- list(
    referencePeaksMethod=input$referencePeaksMethod,
    minFrequency=input$minFrequency,
    referencePeaksTolerance=input$referencePeaksTolerance
  )
  updateComputeReferencePeaks(values)
}
