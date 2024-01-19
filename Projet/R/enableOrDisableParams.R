enableOrDisableParams <- function(elements, params) {
  if (isFALSE(params)) {
    for(element in elements) { enable(element) }
  } else {
    for(element in elements) { disable(element) }
  }
}
