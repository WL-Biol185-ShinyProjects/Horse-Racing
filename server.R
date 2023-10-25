library(shiny)
library(tidyverse)

coral <- read.csv("global_bleaching_environmental.csv",
                  header = TRUE,
                  na.strings = "nd"
)

coral$Temperature_Mean <- as.numeric(global_bleaching_environmental$Temperature_Mean)

function(input, output) {
  
  output$Temperature_Mean <- renderPlot({
    
    global_bleaching_environmental %>%
      filter(City_Town_Name == input$City_Town_Name) %>%
      ggplot(aes(Date, Temperature_Mean)) + geom_point(color = "blue")
    
    #plot(coral$Temperature_Mean, coral$Date,
            #main = input$City_Town_Name, 
            #ylab = "Year",
            #xlab = "Sea Surface Temperature")
    
  })
}