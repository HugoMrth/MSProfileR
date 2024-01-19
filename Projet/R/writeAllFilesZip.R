writeAllFilesZip <- function(file, values, withParameters, withSpectra, withIntensityMatrix, withAnnotations) {
  tmp <- tempfile()
  dir.create(tmp)
  dir.create(file.path(tmp, "files"))
  writeParameters(file.path(tmp, "files", "parameters.csv"), values)
  writeReport(file.path(tmp, "files", "report.pdf"), values)
  writeH5File(file.path(tmp, "files", "data.h5"), values, withParameters, withSpectra, withIntensityMatrix, withAnnotations)
  writeFigures(file.path(tmp, "files"), values)
  zipfile <- tempfile(fileext = ".zip")
  zip(file, "files", root = tmp, recurse = TRUE)
}
