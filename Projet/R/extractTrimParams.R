extractTrimParams <- function(input, values) {
  values$trimParams <- list(
    range=input$spectraTrimmingRange
  )
  updateTrim(values)
}
