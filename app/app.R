library(shiny)
library(ggplot2)
library(tidyverse)
library(jsonlite)

ui <- fluidPage(
  titlePanel("Odontologinės praktikos veikla"),
  sidebarLayout(
    sidebarPanel(
      selectizeInput("kodas",
                     "Iveskite Imones koda",
                     choices = NULL)),
      
  
    mainPanel(
      tableOutput("table"),
      plotOutput("plot")
    )
  )
)

server <- function(input, output, session) {
    data <- readRDS("../data/862300.rds")
    updateSelectizeInput(session, "kodas", choices = data$name, server = TRUE)
    output$plot <- renderPlot(
      data %>%
        filter(name == input$kodas) %>%
        ggplot(aes(x = ym(month), y = numInsured)) +
        geom_point() + 
        geom_line() +
        theme_classic()
        )
      
}

shinyApp(ui = ui, server = server)
