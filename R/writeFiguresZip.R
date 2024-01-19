writeFiguresZip <- function(file, values) {
  tmp <- tempfile()
  dir.create(tmp)
  writeFigures(tmp, values)
  zipfile <- tempfile(fileext = ".zip")
  zip(file, "figures", root = tmp)
}
