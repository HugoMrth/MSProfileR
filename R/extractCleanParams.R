extractCleanParams <- function(input, values) {
  values$cleanParams <- list(
    transformIntensityMethod=input$transformIntensityMethod,
    smoothIntensityMethod=input$smoothIntensityMethod,
    halfWindowSize=input$halfWindowSize,
    removeBaselineMethod=input$removeBaselineMethod,
    removeBaselineIterations=input$removeBaselineIterations,
    calibrateIntensityMethod=input$calibrateIntensityMethod
  )
  updateClean(values)
}
