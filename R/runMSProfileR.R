runMSProfileR <- function() {
  options(shiny.maxRequestSize = 500*1024^2)

  ui <- dashboardPage(
    dashboardHeader(title = "MSProfileR Tool"),
    dashboardSidebar(sidebarMenu(id = "sidebarMenu",
                                 menuItem("1. Data loading", tabName = "data_loading", icon = icon("upload")),
                                 menuItem("2. Preprocessing", tabName = "preprocessing", icon = icon("gear")),
                                 menuItem("3. Processing", tabName = "processing", icon = icon("gear")),
                                 menuItem("4. Annotations", tabName = "annotation", icon = icon("upload")),
                                 menuItem("5. Output", tabName = "output", icon = icon("download"))
    )
    ),
    dashboardBody(
      useShinyjs(),
      add_busy_spinner(spin = "fading-circle"),
      tabItems(
        tabItem(tabName = "data_loading", fluidPage(dataLoadingUI("data_loading"))),
        tabItem(tabName = "preprocessing", fluidPage(preprocessingUI("preprocessing"))),
        tabItem(tabName = "processing", fluidPage(processingUI("processing"))),
        tabItem(tabName = "annotation", fluidPage(annotationUI("annotation"))),
        tabItem(tabName = "output", fluidPage(reportingUI("reporting")))
      )
    )
  )

  server <- function(input, output, session) {
    data(Legs_Guiana_Culex)
    values <- reactiveValues(newParams=list(),
                             spectra = Legs_Guiana_Culex)
    dataLoadingServer("data_loading", values)
    preprocessingServer("preprocessing", values)
    processingServer("processing", values)
    annotationServer("annotation", values)
    reportingServer("reporting", values)
  }

  app <- shinyApp(ui, server)

  # list.of.packages <- c("MALDIquantForeign", "MALDIrppa","MALDIquant","hdf5r","shiny","shinydashboard",
  #                       "shinyFiles","shinyWidgets","shinyjs","shinybusy","DT","ggplot2","pheatmap","pandoc",
  #                       "rjson","fontawesome","shinyBS","svglite","readxl","writexl","tools","knitr","tinytex")
  #
  # new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
  # if(length(new.packages)) install.packages(new.packages, repos='http://cran.us.r-project.org')
  # if (!tinytex::is_tinytex()) { tinytex::install_tinytex() }


  shiny::runApp(app,launch.browser = TRUE)
}
