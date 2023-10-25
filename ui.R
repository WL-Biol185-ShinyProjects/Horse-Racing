library(shiny)
library(tidyverse)

coral <- read.csv("global_bleaching_environmental.csv",
                  header = TRUE,
                  na.strings = "nd"
)

coral$Temperature_Mean <- as.numeric(global_bleaching_environmental$Temperature_Mean)

fluidPage(
  
  titlePanel("Sea Surface Temperature by Ocean"),
)
  sidebarLayout(
    sidebarPanel(
      selectInput("City_Town_Name", "Town Name:",
                  choices = unique(coral$City_Town_Name)),
      hr(),
      helpText("Data from Biological & Chemical Oceanography Data Mangement Office (2022) Global Bleaching and Environmental Data.")
    ),
    
    mainPanel(
      plotOutput("Temperature_Mean")
    )
  )


