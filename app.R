#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

 # Load required libraries
library(tidyverse)
library(shiny)
library(leaflet)
library(dplyr)
library(ggplot2)
library(scales) # for rescale function

# Read the data
data <- read_csv("HTI_governance_geo.csv")

# Convert relevant columns to factors
data$City.of.Birth <- as.factor(data$City.of.Birth)
data$Name <- as.factor(data$Name)

# Define the color gradient
color_gradient <- c(
  "#CCFFCC", "#B9FFB9", "#A6FFA6", "#94FF94", "#81FF81", "#6FFF6F", "#5CFF5C", "#4AFF4A",
  "#37FF37", "#25FF25", "#12FF12", "#00FF00", "#00EC00", "#00D900", "#00C700", "#00B400",
  "#00A200", "#008F00", "#007D00", "#006A00", "#005800", "#004500"
)

# Define UI
ui <- fluidPage(
  titlePanel("Haiti's Political Elite: Governance Score Analysis"),

  sidebarLayout(
    sidebarPanel(
      selectInput("name", "Select Political Figure:", choices = c("All", levels(data$Name))),
      selectInput("city", "Select City of Birth:", choices = c("All", levels(data$City.of.Birth))),
      hr(),
      helpText("Explore governance scores among Haiti's political figures based on city of birth and their time in office.")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Map View", leafletOutput("map", height = 600)),
        tabPanel("Governance Score Analysis", plotOutput("bargraph", height = 400))
      )
    )
  )
)

# Define Server
server <- function(input, output, session) {

  # Filter data based on inputs
  filteredData <- reactive({
    df <- data
    if (input$name != "All") {
      df <- df %>% filter(Name == input$name)
    }
    if (input$city != "All") {
      df <- df %>% filter(City.of.Birth == input$city)
    }
    df
  })

  # Render Leaflet map
  output$map <- renderLeaflet({
    leaflet(filteredData()) %>%
      addTiles() %>%
      addCircleMarkers(~longitude, ~latitude,
                       popup = ~paste("<strong>Name:</strong>", Name,
                                      "<br><strong>City of Birth:</strong>", City.of.Birth,
                                      "<br><strong>Governance Score:</strong>", Governance.Score,
                                      "<br><strong>Notes:</strong>", Notes),
                       label = ~paste(Name, "(", City.of.Birth, ")"),
                       radius = ~Governance.Score / 3,
                       color = "blue",
                       fillOpacity = 0.8)
  })

  # Render Bar Graph
  output$bargraph <- renderPlot({
    # Calculate the mean governance score
    mean_score <- mean(data$Governance.Score, na.rm = TRUE)
    
    # Scale governance scores to match the length of the color gradient
    scaled_scores <- rescale(filteredData()$Governance.Score, to = c(1, length(color_gradient)))

    # Plot the bar graph with a color gradient based on governance score
    ggplot(filteredData(), aes(x = reorder(Name, -Governance.Score), y = Governance.Score)) +
      geom_bar(stat = "identity", aes(fill = Governance.Score), show.legend = FALSE) +
      geom_hline(yintercept = mean_score, color = "black", linetype = "dashed", size = 1) +
      geom_text(aes(label = round(Governance.Score, 1)), vjust = -0.5, size = 3) +
      theme_minimal() +
      coord_flip() +
      scale_fill_gradientn(colors = color_gradient) + # Apply the color gradient
      labs(x = "Political Figure", y = "Governance Score", 
           title = "Governance Scores by Political Figure", 
           subtitle = paste("Average Governance Score =", round(mean_score, 2)))
  })
}

# Run the app
shinyApp(ui = ui, server = server)