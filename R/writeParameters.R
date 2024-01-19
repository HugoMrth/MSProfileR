writeParameters <- function(file, values) {
  params <- extractParameters(values)
  write(toJSON(params), file)
}
