removeConformityParams <- function(values) {
  values$conformityParams <- FALSE
  updateConformity(values)
}
