extractParameters <- function(values) {
  params <- list()
  params <- extractAllPreprocessingParams(params, values)
  params <- extractAllProcessingParams(params, values)
  return(params)
}
