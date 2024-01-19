writeReport <- function(file, values) {
  params <- list(values=values)
  tempReport <- paste0(system.file(package = "MSProfileR"), "/rmd/report.Rmd")
  tempDataLoadingReport <- paste0(system.file(package = "MSProfileR"), "/rmd/data_loading_report.Rmd")
  tempPreprocessingReport <- paste0(system.file(package = "MSProfileR"), "/rmd/preprocessing_report.Rmd")
  tempProcessingReport <- paste0(system.file(package = "MSProfileR"), "/rmd/processing_report.Rmd")
  tempAnnotationReport <- paste0(system.file(package = "MSProfileR"), "/rmd/annotation_report.Rmd")
  file.copy("report.Rmd", tempReport, overwrite = TRUE)
  file.copy("data_loading_report.Rmd", tempDataLoadingReport, overwrite = TRUE)
  file.copy("preprocessing_report.Rmd", tempPreprocessingReport, overwrite = TRUE)
  file.copy("processing_report.Rmd", tempProcessingReport, overwrite = TRUE)
  file.copy("annotation_report.Rmd", tempAnnotationReport, overwrite = TRUE)
  rmarkdown::render(input = tempReport,
                    output_format = "pdf_document",
                    output_file = file,
                    params = params,
                    envir = new.env(parent = globalenv())
  )
}
