# ---  Global Map of Happiness Indicators across Years ---

library(shiny)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(ggplot2)
library(dplyr)
library(viridis)
library(readr) 

# Read the Data

merged_data <- read_csv("PaneledData.csv")

# Define the UI
ui <- fluidPage(
  titlePanel("Global Map of Happiness Indicators"),
  sidebarLayout(
    sidebarPanel(
      selectInput("feature", 
                  "Select Feature:",
                  choices = c("Score", "GDP_per_capita", "Social_support", 
                              "Healthy_life_expectancy", "Freedom", "Generosity", "Corruption"),
                  selected = "Score"),
      selectInput("year", 
                  "Select Year:",
                  choices = c("2015", "2016", "2017", "2018", "2019", "Total"),
                  selected = "2019")
    ),
    mainPanel(
      plotOutput("mapPlot", height = "600px")
    )
  )
)

# Define the server logic
server <- function(input, output) {
  # Load the world shapefile (medium resolution)
  world <- ne_countries(scale = "medium", returnclass = "sf")
  
  # Reactive: Prepare data based on the year selection.
  dataToPlot <- reactive({
    if (input$year != "Total") {
      # For a specific year, convert input$year to numeric, and filter
      merged_data %>% filter(Year == as.numeric(input$year))
    } else {
      # For "Total", aggregate data by Country across all available years.
      merged_data %>%
        group_by(Country) %>%
        summarise(
          Score = mean(Score, na.rm = TRUE),
          GDP_per_capita = mean(GDP_per_capita, na.rm = TRUE),
          Social_support = mean(Social_support, na.rm = TRUE),
          Healthy_life_expectancy = mean(Healthy_life_expectancy, na.rm = TRUE),
          Freedom = mean(Freedom, na.rm = TRUE),
          Generosity = mean(Generosity, na.rm = TRUE),
          Corruption = mean(Corruption, na.rm = TRUE)
        )
    }
  })
  
  # Reactive: Join the chosen data with the world shapefile
  worldData <- reactive({
    dt <- dataToPlot()
    # Join on the country name ('admin' in world shapefile must match 'Country').
    left_join(world, dt, by = c("admin" = "Country"))
  })
  
  # Render the map
  output$mapPlot <- renderPlot({
    req(input$feature)
    
    world_join <- worldData()
    
    ggplot(world_join) +
      geom_sf(aes_string(fill = input$feature), color = "white") +
      scale_fill_viridis_c(option = "plasma", na.value = "grey50") +
      labs(title = paste("Global Map of", input$feature, "for", input$year),
           fill = input$feature) +
      theme_minimal() +
      theme(plot.title = element_text(size = 18, face = "bold"),
            axis.text = element_blank(),
            axis.ticks = element_blank())
  })
}

# Run the application
shinyApp(ui = ui, server = server)
