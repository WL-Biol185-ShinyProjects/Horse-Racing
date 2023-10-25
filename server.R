library(shiny)
library(tidyverse)

coral <- read.csv("global_bleaching_environmental.csv",
                  header = TRUE,
                  na.strings = "nd"
)

coral$Temperature_Mean <- as.numeric(coral$Temperature_Mean)

function(input, output) {
  
  output$Temperature_Mean <- renderPlot({
    
    coral %>%
      filter(Realm_Name == input$Realm_Name) %>%
      ggplot(aes(Date, Temperature_Mean)) + geom_point(color = "blue")
    
    #plot(coral$Temperature_Mean, coral$Date,
            #main = input$Realm_Name,
            #ylab = "Year",
            #xlab = "Sea Surface Temperature")
    
  })
}