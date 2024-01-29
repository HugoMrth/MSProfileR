dataLoadingUI <- function(id) {
  ns <- NS(id)
  tagList(
    box(title="Data loading", width = 12, solidHeader = TRUE, status = "primary",

        br(),
        numericInput(
          inputId = ns("directoryLevel"),
          label = tags$span("Level of directories from sample name:",
                            tags$i(
                              class = "glyphicon glyphicon-info-sign",
                              style = "margin-left:10px;color:#0072B2;",
                              title = "Select the path of the folder containing the spectra files to analyse which is the number of folders generated between the sampleName and the fid or acqu files of Bruker"
                            )),
          value = 4
        ),
        shinyDirButton(ns("directory"),
                       "Choose spectra directory",
                       "Choose spectra directory"),
        # icon("info-circle",class = "glyphicon glyphicon-info-sign", id=ns("icon_help"), style="margin-left:10px;color:#0072B2;"),
        # bsTooltip(id = ns("icon_help"), title = "Select the mass spectrum directory to analyze from your computer",
        #           placement = "right", trigger = "hover"),
        br(),
        br(),
        infoBoxOutput(ns("infoBox"), width=12),
        DT::dataTableOutput(ns("metadata"))
    ),



    box(title="Parameters", width = 12, solidHeader = TRUE, status = "primary",
        fileInput(ns('uploadParameters'),
                  label = tags$span("Upload parameters",
                                    tags$i(
                                      class = "glyphicon glyphicon-info-sign",
                                      style = "margin-left:10px;color:#0072B2;",
                                      title = "Loading previous parameters (optional)"
                                    )),
                  accept = ".json")
    ),
  )

}
