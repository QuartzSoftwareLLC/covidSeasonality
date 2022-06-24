#' main UI Function
#'
#' @noRd
#' @importFrom shiny NS tagList
#' @import shiny.quartz
mod_main_ui <- function(id) {
    ns <- NS(id)
    shiny.quartz::QCard(
        VStack(
            QSelect.shinyInput(
                ns("country"),
                options = make_options(shiny.covidSeasonality::country_options),
                value = "United States",
                label = "Country"
            ),
            plotly::plotlyOutput(ns("plot"))
        )
    )
}


#' main Server Funciton
#'
#' @noRd
mod_main_server <- function(id) {
    moduleServer(id, function(input, output, session) {
        ns <- session$ns
        output$plot <- plotly::renderPlotly({
            req(input$country)
            plotter(
                locales = input$country,
                decomposition.method = "twitter",
                anomalize.method = "gesd"
            ) %>%
                plotly::ggplotly()
        })
    })
}

