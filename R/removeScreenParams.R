removeScreenParams <- function(values) {
  values$screenParams <- FALSE
  updateScreen(values)
}
