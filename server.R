library(shiny)
library(tidyverse)

coral <- read.csv("global_bleaching_environmental.csv")

function(input, output) {
  
  #output$Temperature_Mean <- renderPlot({
  corals %>% filter(input$Ocean_Name)}
coral %>%
  filter(Ocean_Name == input$Ocean_Name) %>%
  ggplot(coral, aes(Temperature_Mean, Date_Year)) + geom_point()



    
<<<<<<< HEAD
    # plot(coral$Temperature_Mean, coral$Date_Year,
    # main = input$Ocean_Name,
    # ylab = "Year",
    # xlab = "Sea Surface Temperature"
=======
    global_bleaching_environmental %>%
      filter(Ocean_Name == input$Ocean_Name) %>%
      ggplot(aes(Date, Temperature_Mean)) + geom_point(color = "blue")
    
    #plot(coral$Temperature_Mean, coral$Date_Year,
            #main = input$Ocean_Name, 
            #ylab = "Year",
            #xlab = "Sea Surface Temperature")
>>>>>>> 292afb6251fadf156e9d1e4b666caf7b6c44635a
    
  #})
# })

