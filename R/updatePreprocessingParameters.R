updatePreprocessingParameters <- function(session, input, values) {
  updateTrimParams(session, input, values$updateParameters$trimParams, values)
  updateTrim(values)
  updateConformityParams(session, input, values$updateParameters$conformityParams, values)
  updateConformity(values)
  updateCleanParams(session, input, values$updateParameters$cleanParams, values)
  updateClean(values)
  updateScreenParams(session, input, values$updateParameters$screenParams, values)
  updateScreen(values)
  updateMergeParams(session, input, values$updateParameters$mergeParams, values)
  updateMerge(values)
}
