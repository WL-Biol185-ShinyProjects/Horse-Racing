library(shiny)
library(tidyverse)

coral <- read.csv("global_bleaching_environmental.csv", na.strings = "nd")

Coral_Ordered1 <- coral %>% mutate(across(.cols = starts_with('Temperature_Mean'),.fns = function(x) x - 273.15)) %>% group_by(Country_Name, Date_Year) %>% summarise(aveTemp = mean(Temperature_Mean, na.rm = TRUE)) 
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
  #add transformation
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
  #add transformation
  
  output$Temperature_Mean1 <- renderPlot({
    plot_data <- Coral_Ordered5 %>%
      filter(Ecoregion_Name == input$Ecoregion_Name) 
    
    if(nrow(plot_data) ==0){
      return(NULL)
    }
    
    lm_model <- lm(aveTemp ~ Date_Year, data = plot_data)
    rsquared <- summary(lm_model)$r.squared
    
    p <- ggplot(plot_data, aes(Date_Year, aveTemp)) +
      geom_point(color = "blue") +
      geom_smooth(method = "lm", se = FALSE, color = "red") +  # Add red regression line
      
      labs(
        title = "Temperature by Ecoregion",
        x = "Year",
        y = "Temperature"
      ) +
      annotate("text", x = max(plot_data$Date_Year), y = max(plot_data$aveTemp), 
               label = paste("R-squared =", round(rsquared, 4)), hjust = 1, vjust = 1, color = "red")
    
    print(p)
    
  })
  
  #droppy4
  #add transformation and why isn't r squared showing
  
  output$Percent_Bleaching1 <- renderPlot({
    plot_data <- Coral_Ordered2 %>%
      filter(Ecoregion_Name == input$Ecoregion_Name)
    
    if (nrow(plot_data) == 0) {
      return(NULL)  # Return NULL if data is empty
    }
    
    p <- plot_data %>%
      ggplot(aes(Date_Year, aveBleach)) + 
      geom_point(color = "blue") +
      geom_smooth(method = "lm", se = FALSE, color = "red") +  # Add red regression line
      labs(
        title = "Percent Bleaching by Ecoregion",
        x = "Date Year",
        y = "Percent Bleaching"
      )
    
    lm_model <- lm(aveBleach ~ Date_Year, data = plot_data)
    rsquared <- summary(lm_model)$r.squared
    
    p + 
      annotate("text", x = max(plot_data$Date_Year), y = max(plot_data$aveBleach), 
               label = paste("R-squared =", round(rsquared, 4)), hjust = 1, vjust = 1, color = "red")
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
  
  
  #MAP HERE
  #why aren't the boxes populating
  get_selected_info <- function(selected_column) {
    req(input$map_marker_click)
    click <- input$map_marker_click
    selected_row <- coral[coral$Site_Name == click$id, ]
    selected_row[[selected_column]]
  }
  
  output$map <- renderLeaflet({
    # Filter data to get the most recent data for each site
    most_recent_data <- coral %>%
      group_by(Site_Name) %>%
      filter(Date_Year == max(Date_Year)) %>%
      distinct(Site_Name, .keep_all = TRUE)
    
    leaflet(data = most_recent_data) %>%
      addTiles() %>%
      addMarkers(~Longitude_Degrees, ~Latitude_Degrees, popup = ~Site_Name)
  })
  
  
}




