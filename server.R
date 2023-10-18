library(shiny)
library(tidyverse)
coral <- read.csv("global_bleaching_environmental.csv")

function(input, output) {
  
  output$tempPlot <- renderPlot({
    
    barplot(global_bleaching_environmental[,input$Date_Year],
            main = input$Date_Year, 
            ylab = "Sea Surface Temperature",
            xlab = "Year")
    
  })
}