computeListForSelection <- function(spectra, estTable, decreasing) {
  displayName <- function(spectrum) {
    paste(spectrum@metaData$id,': ', spectrum@metaData$sampleName,' [',spectrum@metaData$replicateName,']',sep='')
  }
  if (!is.null(estTable)) {
    ids <- data.frame('ID'=names(spectra), 'displayName'=unlist(lapply(spectra, displayName)))
    dataframe <- merge(x = ids, y = estTable, by = "ID", all.x = TRUE)
    dataframe <- dataframe[order(dataframe[['A score']], decreasing=decreasing),]
    row.names(dataframe) <- dataframe[['ID']]
    tryCatch(
      {dataframe[['str']] <- paste(dataframe[['displayName']],' (', round(dataframe[['A score']],2),')', sep='')},
      error=function(cond) {}
    )
    result <- as.list(dataframe[['ID']])
    names(result) <- dataframe[['str']]
    return(result)
  } else {
    result <- names(spectra)
    names(result) <- unlist(lapply(spectra, displayName))
    return(result)
  }
}
