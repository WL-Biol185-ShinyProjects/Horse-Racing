library(shiny)
library(tidyverse)

coral <- read.csv("global_bleaching_environmental.csv")

function(input, output) {
  
  output$Temperature_Mean <- renderPlot({

    coral %>%
      filter(Ocean_Name == input$Ocean_Name) %>%
      ggplot(aes(Date, Temperature_Mean)) + geom_point(color = "blue")

    
  })
}


