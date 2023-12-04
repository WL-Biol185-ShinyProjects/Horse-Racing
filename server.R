library(shiny)
library(tidyverse)

coral <- read.csv("global_bleaching_environmental.csv", na.strings = "nd")

Coral_Ordered1 <- coral %>% mutate(across(.cols = starts_with('Temperature_Mean'),.fns = function(x) x - 273.15)) %>% group_by(Country_Name, Date_Year) %>% summarise(aveTemp = mean(Temperature_Mean, na.rm = TRUE)) 
Coral_Ordered2 <- coral %>% group_by(Ecoregion_Name, Date_Year) %>% summarise(aveBleach = mean(Percent_Bleaching, na.rm = TRUE))
Coral_Ordered3 <- coral %>% mutate(across(.cols = starts_with('Temperature_Mean'),.fns = function(x) x - 273.15)) %>% group_by(Ocean_Name, Date_Year) %>% summarise(aveTemp = mean(Temperature_Mean, na.rm = TRUE))
Coral_Ordered4 <- coral %>% group_by(Ocean_Name, Date_Year) %>% summarise(aveBleach = mean(Percent_Bleaching, na.rm = TRUE))
Coral_Ordered5 <- coral %>% mutate(across(.cols = starts_with('Temperature_Mean'),.fns = function(x) x - 273.15)) %>% group_by(Ecoregion_Name, Date_Year) %>% summarise(aveTemp = mean(Temperature_Mean, na.rm = TRUE))
Coral_Ordered6 <- coral %>% mutate(across(.cols = starts_with('Temperature_Mean'),.fns = function(x) x - 273.15)) %>% group_by(Country_Name, Date_Year) %>% summarise(aveTemp = mean(Temperature_Mean, na.rm = TRUE), aveBleach = mean(Percent_Bleaching, na.rm = TRUE)) 


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
      geom_smooth(method = "lm", se = FALSE, color = "red") +  
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
      geom_smooth(method = "lm", se = FALSE, color = "red") +  
      
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
      geom_smooth(method = "lm", se = FALSE, color = "red") +  
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
      ggplot(aes(Country_Name, aveTemp)) + geom_bar(stat = 'identity', position = "identity") + scale_x_discrete(guide = guide_axis(angle = 90)) 
  })
  
  #droppy7
  
  # output$Regression <- renderPlot({
  #   
  #   Coral_Ordered6 %>%
  #     ggplot(aes(x = aveTemp, y = aveBleach)) + geom_point(aes(colour = as.factor(Date_Year)))
  # })
  
  output$Regression <- renderPlot({
    ggplot(Coral_Ordered6, aes(x = aveTemp, y = aveBleach, color = as.factor(Date_Year))) +
      geom_point() +
      geom_smooth(method = "lm", se = FALSE) +
      labs(
        title = "Temperature vs. Bleaching",
        x = "Average Temperature",
        y = "Average Bleaching"
      )
  })
  
  
  
  
  #density1
  
  output$zoomableDensityPlot <- renderPlotly({
    plot_ly(data = coral, x = ~Percent_Bleaching, color = ~as.factor(Date_Year), type = 'histogram') %>%
      layout(title = "Density Plot of Percent Bleaching by Year",
             xaxis = list(title = "Percent Bleaching"),
             yaxis = list(title = "Density", type = "log"),  # Apply log scale to y-axis
             dragmode = "zoom")  # Enable zoom only
  })
  
  #references
  
  output$mytable <- DT::renderDataTable(coral,
                                        options = list(scrollX = TRUE),
                                        rownames = FALSE)
  
  #MAP 
  
  get_selected_info <- reactive({
    req(input$map_marker_click)
    
    click <- input$map_marker_click
    print(click)  
    if (is.null(click))
      return(NULL)
    
    lat <- click$lat
    lng <- click$lng
    
    nearest_site <- coral[which.min((coral$Latitude_Degrees - lat)^2 + (coral$Longitude_Degrees - lng)^2), ]
    nearest_site
  })

  
  output$map <- renderLeaflet({
    most_recent_data <- coral %>%
      group_by(Site_Name) %>%
      filter(Date_Year == max(Date_Year)) %>%
      distinct(Site_Name, .keep_all = TRUE)
    
    leaflet(data = most_recent_data) %>%
      addTiles() %>%
      addMarkers(~Longitude_Degrees, ~Latitude_Degrees, popup = ~Site_Name)
  })
  
  output$site_info_Site_Name <- renderText({
    selected_info <- get_selected_info()
    if (!is.null(selected_info) && nrow(selected_info) > 0) {
      site_name <- selected_info$Site_Name
      paste("Site Name:", site_name)
    } else {
      "No data available"
    }
  })
  
  
  output$site_info_Ocean_Name <- renderText({
    selected_info <- get_selected_info()
    if (!is.null(selected_info) && nrow(selected_info) > 0) {
      oceanname <- selected_info$Ocean_Name
      paste("Ocean Name:", oceanname)
    } else {
      "No data available"
    }
  })
  
  output$site_info_Ecoregion_Name <- renderText({
    selected_info <- get_selected_info()
    if (!is.null(selected_info) && nrow(selected_info) > 0) {
      ecoregionname <- selected_info$Ecoregion_Name
      paste("Ecoregion Name:", ecoregionname)
    } else {
      "No data available"
    }
  })
  
  output$site_info_Distance_to_Shore <- renderText({
    selected_info <- get_selected_info()
    if (!is.null(selected_info) && nrow(selected_info) > 0) {
      disttoshore <- selected_info$Distance_to_Shore
      paste("Distance To Shore:", disttoshore)
    } else {
      "No data available"
    }
  })
  
  output$site_info_Exposure <- renderText({
    selected_info <- get_selected_info()
    if (!is.null(selected_info) && nrow(selected_info) > 0) {
      exp <- selected_info$Exposure
      paste("Exposure:", exp)
    } else {
      "No data available"
    }
  })
  
  output$site_info_Turbidity <- renderText({
    selected_info <- get_selected_info()
    if (!is.null(selected_info) && nrow(selected_info) > 0) {
      turb <- selected_info$Turbidity
      paste("Turbidity:", turb)
    } else {
      "No data available"
    }
  })
  
  output$site_info_Cyclone_Frequency <- renderText({
    selected_info <- get_selected_info()
    if (!is.null(selected_info) && nrow(selected_info) > 0) {
      cycl <- selected_info$Cyclone_Frequency
      paste("Cyclone Frequency:", cycl)
    } else {
      "No data available"
    }
  })
  
  output$site_info_Date_Day <- renderText({
    selected_info <- get_selected_info()
    if (!is.null(selected_info) && nrow(selected_info) > 0) {
      dateday <- selected_info$Date_Day
      paste("Day of Data Collection:", dateday)
    } else {
      "No data available"
    }
  })
  
  output$site_info_Date_Month <- renderText({
    selected_info <- get_selected_info()
    if (!is.null(selected_info) && nrow(selected_info) > 0) {
      month <- selected_info$Date_Month
      paste("Month of Data Collection:", month)
    } else {
      "No data available"
    }
  })
  
  output$site_info_Date_Year <- renderText({
    selected_info <- get_selected_info()
    if (!is.null(selected_info) && nrow(selected_info) > 0) {
      yr <- selected_info$Date_Year
      paste("Year of Data Collection:", yr)
    } else {
      "No data available"
    }
  })
  
  output$site_info_Depth_m <- renderText({
    selected_info <- get_selected_info()
    if (!is.null(selected_info) && nrow(selected_info) > 0) {
      depth <- selected_info$Depth_m
      paste("Depth (m):", depth)
    } else {
      "No data available"
    }
  })
  
  output$site_info_Substrate_Name <- renderText({
    selected_info <- get_selected_info()
    if (!is.null(selected_info) && nrow(selected_info) > 0) {
      subst <- selected_info$Substrate_Name
      paste("Substrate Name:", subst)
    } else {
      "No data available"
    }
  })
  
  output$site_info_Percent_Bleaching <- renderText({
    selected_info <- get_selected_info()
    if (!is.null(selected_info) && nrow(selected_info) > 0) {
      percbl <- selected_info$Percent_Bleaching
      paste("Percent Bleaching:", percbl)
    } else {
      "No data available"
    }
  })
  
  output$site_info_Temperature_Kelvin <- renderText({
    selected_info <- get_selected_info()
    if (!is.null(selected_info) && nrow(selected_info) > 0) {
      tempK <- selected_info$Temperature_Kelvin
      tempC <- tempK - 273.15
      paste("Temperature (C):", tempC)
    } else {
      "No data available"
    }
  })
  
  output$site_info_Windspeed <- renderText({
    selected_info <- get_selected_info()
    if (!is.null(selected_info) && nrow(selected_info) > 0) {
      windsp <- selected_info$Windspeed
      paste("Windspeed:", windsp)
    } else {
      "No data available"
    }
  })
  
  output$site_info_Site_Comments <- renderText({
    selected_info <- get_selected_info()
    if (!is.null(selected_info) && nrow(selected_info) > 0) {
      sitecomments <- selected_info$Site_Comments
      paste("Site Comments:", sitecomments)
    } else {
      "No data available"
    }
  })
  
  output$site_info_Sample_Comments <- renderText({
    selected_info <- get_selected_info()
    if (!is.null(selected_info) && nrow(selected_info) > 0) {
      samplecomm <- selected_info$Sample_Comments
      paste("Sample Comments:", samplecomm)
    } else {
      "No data available"
    }
  })
  
  output$site_info_Bleaching_Comments <- renderText({
    selected_info <- get_selected_info()
    if (!is.null(selected_info) && nrow(selected_info) > 0) {
      bleachcomm <- selected_info$Bleaching_Comments
      paste("Bleaching Comments:", bleachcomm)
    } else {
      "No data available"
    }
  })
  
}

