library(shiny)
library(tidyverse)

coral <- read.csv("global_bleaching_environmental.csv", na.strings = "nd")

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
    Coral_Ordered1 <- coral %>% group_by(Country_Name, Date_Year) %>% summarise(aveTemp = mean(Temperature_Mean, na.rm = TRUE))
    ggplot(Coral_Ordered1, aes(Country_Name, aveTemp, fill = Date_Year)) + geom_bar(stat = 'identity', position = "jitter")
  })
}



