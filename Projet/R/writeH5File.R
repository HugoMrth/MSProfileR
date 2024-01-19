writeH5File <- function(file, values, withParameters, withSpectra, withIntensityMatrix, withAnnotations) {
  file.h5 <- H5File$new(file, mode="w")
  if (withParameters) {
    file.h5[['parameters']] <- toJSON(extractParameters(values))
  }
  if (withSpectra && !is.null(values$mergedSpectra)) {
    spectra <- values$mergedSpectra
    file.h5$create_group('spectra')
    for (id in names(spectra)) {
      spectrum <- spectra[[id]]
      path <- paste('spectra', id, sep='/')
      file.h5[[path]] <- rbind(intensity(spectrum), mass(spectrum))
      h5attr(file.h5[[path]], 'sampleName') <- spectrum@metaData$sampleName
      h5attr(file.h5[[path]], 'replicateName') <-spectrum@metaData$replicateName
      h5attr(file.h5[[path]], 'acquisitionDate') <- spectrum@metaData$acquisitionDate
    }
  }
  if (withIntensityMatrix && !is.null(values$intensityMatrix)) {
    file.h5$create_group('intensity_matrix')
    intensityMatrix <- values$intensityMatrix
    spectra <- values$mergedSpectra
    file.h5[['intensity_matrix/matrix']] <- intensityMatrix
    file.h5[['intensity_matrix/mass']] <- as.double(colnames(intensityMatrix))
    file.h5[['intensity_matrix/id']] <- names(spectra)
  }

  if (withAnnotations && !is.null(values$annotations)) {
    file.h5[['annotations']] <- values$annotations
  }

  file.h5$close_all()
}
