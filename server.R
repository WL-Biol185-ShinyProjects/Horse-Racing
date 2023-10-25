library(shiny)
library(tidyverse)

coral <- read.csv("global_bleaching_environmental.csv")

function(input, output) {
  
  output$Temperature_Mean <- renderPlot({

    global_bleaching_environmental %>%
      filter(Ocean_Name == input$Ocean_Name) %>%
      ggplot(aes(Date, Temperature_Mean)) + geom_point(color = "blue")
    
    #plot(coral$Temperature_Mean, coral$Date_Year,
            #main = input$Ocean_Name, 
            #ylab = "Year",
            #xlab = "Sea Surface Temperature")

    
  })
}

