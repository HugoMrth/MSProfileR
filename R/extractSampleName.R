extractSampleName <- function(fidFile, directoryLevel) {
  fidFile <- chartr(old="\\", new="/", x=fidFile)
  dirs <- strsplit(x=fidFile, split="/")[[1L]]
  numDirs <- length(dirs)
  if (numDirs < directoryLevel) {
    return('SampleName')
  }
  sampleName <- dirs[numDirs-directoryLevel]
  sampleName <- gsub(pattern="[[:punct:]]|[[:space:]]", replacement="_", x=sampleName)
  sampleName
}
