#' main UI Function
#'
#' @noRd
#' @importFrom shiny NS tagList
#' @import shiny.quartz
mod_main_ui <- function(id) {
    ns <- NS(id)
    shiny.quartz::QCard(
        VStack(
             shiny.mui::Autocomplete.shinyInput(
                ns("country"),
                inputProps = list(label = "Country(ies)"),
                options = shiny.covidSeasonality::country_options,
                sx = list(mb = 1),
                multiple = T,
                value = list("United States"),
                disableCloseOnSelect = T
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

countryDebounced <- reactive(input$country) %>% debounce(500)
        output$plot <- plotly::renderPlotly({
            req(countryDebounced())
            req(countryDebounced() %>% length())
            plotter(
                locales = countryDebounced(),
                decomposition.method = "twitter",
                anomalize.method = "gesd"
            ) %>%
                plotly::ggplotly()
        })
    })
}

