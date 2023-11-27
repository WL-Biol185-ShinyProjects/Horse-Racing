library(shiny)
library(tidyverse)
library(plotly)

coral <- read.csv("global_bleaching_environmental.csv", na.strings = "nd")

Coral_Ordered1 <- coral %>% group_by(Country_Name, Date_Year) %>% summarise(aveTemp = mean(Temperature_Mean, na.rm = TRUE))

function(input, output) {
  
  output$Temperature_Mean <- renderPlot({
    
    coral %>%
      filter(Ocean_Name == input$Ocean_Name) %>%
      ggplot(aes(Date, Temperature_Mean)) + geom_point(color = "blue")
    
  })
  
  output$Percent_Bleaching <- renderPlot({
    
    coral %>%
      filter(Ocean_Name == input$Ocean_Name1) %>%
      ggplot(aes(Date, Percent_Bleaching)) + geom_point(color = "blue")
  })
  
  output$Temperature_Mean1 <- renderPlot({
    
    coral %>%
      filter(Ecoregion_Name == input$Ecoregion_Name) %>%
      ggplot(aes(Date, Temperature_Mean)) + geom_point(color = "blue")
  })
  
  output$Percent_Bleaching1 <- renderPlot({
    
    coral %>%
      filter(Ecoregion_Name == input$Ecoregion_Name1) %>%
      ggplot(aes(Date, Percent_Bleaching)) + geom_point(color = "blue")
  })
  
  output$Temperature_Mean2 <- renderPlot({
    
    Coral_Ordered1 %>%
      filter(Date_Year == input$Date_Year) %>%
      ggplot(aes(Country_Name, aveTemp)) + geom_bar(stat = 'identity', position = "jitter")
  })
  
  output$zoomableDensityPlot <- renderPlotly({
    p <- ggplot(coral, aes(x = Percent_Bleaching, fill = as.factor(Date_Year))) +
      geom_density(alpha = 0.5) +
      labs(title = "Density Plot of Percent Bleaching by Year",
           x = "Percent Bleaching",
           y = "Density") +
      theme_minimal()
    
    ggplotly(p) %>%
      layout(dragmode = "select")  # Allow for box selection
  })
  
  output$map <- renderLeaflet({
    
    unique_sites <- coral %>% 
      distinct(Site_Name, .keep_all = TRUE)  # Keep only the first occurrence of each unique Site_Name
    
    leaflet(data = unique_sites) %>%
      addTiles() %>%
      addMarkers(~Longitude_Degrees, ~Latitude_Degrees, popup = ~Site_Name)
  })
  
  output$location_info <- renderPrint({
    click <- input$map_marker_click
    if (!is.null(click)) {
      selected_row <- coral[coral$Site_Name == click$id, ]
      selected_info <- paste(
        "Site Name: ", selected_row$Site_Name,
        "\nOcean Name: ", selected_row$Ocean_Name,
        "\nReef ID: ", selected_row$Reef_ID,
        "\nEcoregion: ", selected_row$Ecoregion_Name,
        "\nCountry: ", selected_row$Country_Name,
        "\nLatitude: ", selected_row$Latitude_Degrees,
        "\nLongitude: ", selected_row$Longitude_Degrees,
        "\nPercent Bleaching: ", selected_row$Percent_Bleaching,
        "\nTemperature (Kelvin): ", selected_row$Temperature_Kelvin
        # Add other columns as needed
      )
      return(selected_info)
    }
  })
}




