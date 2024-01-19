reportingUI <- function(id) {
  ns <- NS(id)
  tagList(
    box(title="Reporting (.pdf file)", width = 12, solidHeader = TRUE, status = "primary",
        downloadButton(ns("report"), "Download report")
    ),
    box(title="Parameters (.json file)", width = 12, solidHeader = TRUE, status = "primary",
        downloadButton(ns("parameters"), "Download parameters")
    ),
    box(title="Intensity matrix (.csv file)", width = 12, solidHeader = TRUE, status = "primary",
        uiOutput(ns("intensityMatrixUI"))
    ),
    box(title="Figures (.svg files)", width = 12, solidHeader = TRUE, status = "primary",
        downloadButton(ns("figures"), "Download figures")
    ),
    box(title="HDF5 file (.h5 file)", width = 12, solidHeader = TRUE, status = "primary",
        checkboxInput(ns('h5WithParameters'), label='include parameters', value=TRUE),
        uiOutput(ns("h5WithSpectraUI")),
        uiOutput(ns("h5WithIntensityMatrixUI")),
        uiOutput(ns("h5WithAnnotationsUI")),
        downloadButton(ns("h5File"), "Download HDF5 file")
    ),
    box(title="All files", width = 12, solidHeader = TRUE, status = "primary",
        downloadButton(ns("allFiles"), "Download all files")
    )
  )
}
