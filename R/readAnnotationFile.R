readAnnotationFile <- function(file, values) {
  ext <- tools::file_ext(file)
  if (ext == 'csv') {
    values$rawAnnotations <- read.csv(file, header=TRUE, sep=';')
  } else if (ext == 'xlsx' || ext == 'xls') {
    values$rawAnnotations <- read_excel(file)
  }
}
