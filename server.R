library(shiny)
library(tidyverse)

coral <- read.csv("global_bleaching_environmental.csv", na.strings = "nd")

Coral_Ordered1 <- coral %>% group_by(Country_Name, Date_Year) %>% summarise(aveTemp = mean(Temperature_Mean, na.rm = TRUE))
Coral_Ordered2 <- coral %>% group_by(Ecoregion_Name, Date_Year) %>% summarise(aveBleach = mean(Percent_Bleaching, na.rm = TRUE))
Coral_Ordered3 <- coral %>% group_by(Ocean_Name, Date_Year) %>% summarise(aveTemp = mean(Temperature_Mean, na.rm = TRUE))
Coral_Ordered4 <- coral %>% group_by(Ocean_Name, Date_Year) %>% summarise(aveBleach = mean(Percent_Bleaching, na.rm = TRUE))
Coral_Ordered5 <- coral %>% group_by(Ecoregion_Name, Date_Year) %>% summarise(aveTemp = mean(Temperature_Mean, na.rm = TRUE))

function(input, output) {
  
  output$Temperature_Mean <- renderPlot({

    Coral_Ordered3 %>%
      filter(Ocean_Name == input$Ocean_Name) %>%
      ggplot(aes(Date_Year, aveTemp)) + geom_point(color = "blue") 

  })
  
  output$Percent_Bleaching <- renderPlot({
    
    Coral_Ordered4 %>%
      filter(Ocean_Name == input$Ocean_Name1) %>%
      ggplot(aes(Date_Year, aveBleach)) + geom_point(color = "blue") 
  })
  
  output$Temperature_Mean1 <- renderPlot({
    
    Coral_Ordered5 %>%
      filter(Ecoregion_Name == input$Ecoregion_Name) %>%
      ggplot(aes(Date_Year, aveTemp)) + geom_point(color = "blue")
  })
  
  output$Percent_Bleaching1 <- renderPlot({
    
    Coral_Ordered2 %>%
      filter(Ecoregion_Name == input$Ecoregion_Name1) %>%
      ggplot(aes(Date_Year, aveBleach)) + geom_point(color = "blue") 
  })

  output$Temperature_Mean2 <- renderPlot({
    
    Coral_Ordered1 %>%
      filter(Date_Year == input$Date_Year) %>%
      ggplot(aes(Country_Name, aveTemp)) + geom_bar(stat = 'identity', position = "jitter") + scale_x_discrete(guide = guide_axis(angle = 90)) + NULL
  })
}



