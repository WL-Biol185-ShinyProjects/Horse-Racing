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
}



