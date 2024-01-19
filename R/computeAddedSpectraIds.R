computeAddedSpectraIds <- function(atypicalSpectra, atypicalSpectraAfterSelection) {
  if (is.null(atypicalSpectra) || is.null(atypicalSpectraAfterSelection)) { return(c()) }
  atypicalSpectraIds <- names(atypicalSpectra)
  atypicalSpectraAfterSelectionIds <- names(atypicalSpectraAfterSelection)
  return(setdiff(atypicalSpectraIds, atypicalSpectraAfterSelectionIds))
}
