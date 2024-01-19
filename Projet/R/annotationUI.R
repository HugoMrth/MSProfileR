annotationUI <- function(id) {
  ns <- NS(id)
  tagList(
    box(title="Empty template for annotation table", width = 12, solidHeader = TRUE, status = "primary",
        uiOutput(ns("downloadAnnotationFileButton"))
    ),
    box(title="Upload annotation table", width = 12, solidHeader = TRUE, status = "primary",
        fileInput(ns('uploadAnnotationFile'),
                  label = tags$span("Upload an annotation table",
                                    tags$i(
                                      class = "glyphicon glyphicon-info-sign",
                                      style = "margin-left:10px;color:#0072B2;",
                                      title = "Upload an annotation table to add additional information for each spectrum"
                                    )),
                  accept = c('.csv','.xls','.xlsx')),
        uiOutput(ns("removeAnnotationsButton")),
        br(),
        DT::dataTableOutput(ns("raw_annotations"))
    ),
    box(title="Annotation processing", width = 12, solidHeader = TRUE, status = "primary",
        uiOutput(ns("annotationError")),
        DT::dataTableOutput(ns("annotationStatistics"))
    )
  )
}
