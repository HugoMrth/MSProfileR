extractAllPreprocessingParams <- function(params, values) {
  params$trimParams <- values$trimParams
  params$conformityParams <- values$conformityParams
  params$cleanParams <- values$cleanParams
  params$screenParams <- values$screenParams
  params$mergeParams <- values$mergeParams
  return(params)
}
