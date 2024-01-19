extractScreenParams <- function(input, values) {
  values$screenParams <- list(
    scaleEstimator=input$scaleEstimator,
    atypicalIdentificationMethod=input$atypicalIdentificationMethod,
    threshold=input$threshold,
    includeLowerSpectra=input$includeLowerSpectra
  )
  updateScreen(values)
}
