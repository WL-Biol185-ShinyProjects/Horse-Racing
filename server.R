library(shiny)
library(tidyverse)

coral <- read.csv("global_bleaching_environmental.csv", na.strings = "nd")

Coral_Ordered1 <- coral %>% group_by(Country_Name, Date_Year) %>% summarise(aveTemp = mean(Temperature_Mean, na.rm = TRUE))
Coral_Ordered2 <- coral %>% group_by(Ecoregion_Name, Date_Year) %>% summarise(aveBleach = mean(Percent_Bleaching, na.rm = TRUE))
Coral_Ordered3 <- coral %>% group_by(Ocean_Name, Date_Year) %>% summarise(aveTemp = mean(Temperature_Mean, na.rm = TRUE))
Coral_Ordered4 <- coral %>% group_by(Ocean_Name, Date_Year) %>% summarise(aveBleach = mean(Percent_Bleaching, na.rm = TRUE))
Coral_Ordered5 <- coral %>% group_by(Ecoregion_Name, Date_Year) %>% summarise(aveTemp = mean(Temperature_Mean, na.rm = TRUE))

function(input, output) {
  
  # droppy1
  output$Temperature_Mean <- renderPlot({
    plot_data <- Coral_Ordered3 %>%
      filter(Ocean_Name == input$Ocean_Name)
    
    if (nrow(plot_data) == 0) {
      return(NULL)  # Return NULL if data is empty
    }
    
    lm_model <- lm(aveTemp ~ Date_Year, data = plot_data)
    rsquared <- summary(lm_model)$r.squared
    
    p <- ggplot(plot_data, aes(Date_Year, aveTemp)) + 
      geom_point(color = "blue") +
      geom_smooth(method = "lm", se = FALSE, color = "red") +  # Add red regression line
      labs(
        title = "Temperature by Ocean",
        x = "Year",
        y = "Temperature"
      ) +
      annotate("text", x = max(plot_data$Date_Year), y = max(plot_data$aveTemp), 
               label = paste("R-squared =", round(rsquared, 4)), hjust = 1, vjust = 1, color = "red")
    
    print(p)
  })
  
  # droppy2
  output$Percent_Bleaching <- renderPlot({
    plot_data <- Coral_Ordered4 %>%
      filter(Ocean_Name == input$Ocean_Name)
    
    if (nrow(plot_data) == 0) {
      return(NULL)  # Return NULL if data is empty
    }
    
    lm_model <- lm(aveBleach ~ Date_Year, data = plot_data)
    rsquared <- summary(lm_model)$r.squared
    
    p <- ggplot(plot_data, aes(Date_Year, aveBleach)) + 
      geom_point(color = "blue") +
      geom_smooth(method = "lm", se = FALSE, color = "red") +  # Add red regression line
      labs(
        title = "Percent Bleaching by Ocean",
        x = "Date Year",
        y = "Percent Bleaching"
      ) +
      annotate("text", x = max(plot_data$Date_Year), y = max(plot_data$aveBleach), 
               label = paste("R-squared =", round(rsquared, 4)), hjust = 1, vjust = 1, color = "red")
    
    print(p)
  })
  
  
  #droppy3
  
  output$Temperature_Mean1 <- renderPlot({
    
    Coral_Ordered5 %>%
      filter(Ecoregion_Name == input$Ecoregion_Name) %>%
      ggplot(aes(Date_Year, aveTemp)) + geom_point(color = "blue")
  })
  
  #droppy4
  
  output$Percent_Bleaching1 <- renderPlot({
    
    Coral_Ordered2 %>%
      filter(Ecoregion_Name == input$Ecoregion_Name1) %>%
      ggplot(aes(Date_Year, aveBleach)) + geom_point(color = "blue") 
  })
  
  #droppy5
  
  output$Temperature_Mean2 <- renderPlot({
    
    Coral_Ordered1 %>%
      filter(Date_Year == input$Date_Year) %>%
      ggplot(aes(Country_Name, aveTemp)) + geom_bar(stat = 'identity', position = "jitter") + scale_x_discrete(guide = guide_axis(angle = 90)) + NULL
  })

  #density1
  
    output$zoomableDensityPlot <- renderPlotly({
      plot_ly(data = coral, x = ~Percent_Bleaching, color = ~as.factor(Date_Year), type = 'histogram') %>%
        layout(title = "Density Plot of Percent Bleaching by Year",
               xaxis = list(title = "Percent Bleaching"),
               yaxis = list(title = "Density", type = "log"),  # Apply log scale to y-axis
               dragmode = "zoom")  # Enable zoom only
    })
  
 
  #MAP HERE ABBY
  
  output$map <- renderLeaflet({
    
    unique_sites <- coral %>% 
      distinct(Site_Name, .keep_all = TRUE)  # Keep only the first occurrence of each unique Site_Name
    
    leaflet(data = unique_sites) %>%
      addTiles() %>%
      addMarkers(~Longitude_Degrees, ~Latitude_Degrees, popup = ~Site_Name)
  })
    
  output$site_name_output <- renderText({
    req(input$map_marker_click)
    click <- input$map_marker_click
    selected_row <- coral[coral$Site_Name == click$id, ]
    selected_row$Site_Name  # Output the Site Name
  })
  
  output$ocean_name_output <- renderText({
    req(input$map_marker_click)
    click <- input$map_marker_click
    selected_row <- coral[coral$Site_Name == click$id, ]
    selected_row$Ocean_Name  # Output the Ocean Name
  })
  
  output$percent_bleaching_output <- renderText({
    req(input$map_marker_click)
    click <- input$map_marker_click
    selected_row <- coral[coral$Site_Name == click$id, ]
    selected_row$Percent_Bleaching  # Output the Percent Bleaching
  })
  # Add similar renderText functions for other pieces of information
}

  



