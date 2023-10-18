library(shiny)
library(tidyverse)
coral <- read.csv("global_bleaching_environmental.csv")

function(input, output) {
  
  output$Temperature_Mean <- renderPlot({
    
    plot(coral$Temperature_Mean, coral$Date_Year,
            main = input$Ocean_Name, 
            ylab = "Year",
            xlab = "Sea Surface Temperature")
    
  })
}