library(shiny)
library(tidyverse)

coral <- read.csv("global_bleaching_environmental.csv",
                  header = TRUE,
                  na.strings = "nd"
)

coral$Temperature_Mean <- as.numeric(coral$Temperature_Mean)

fluidPage(
  
  titlePanel("Sea Surface Temperature by Ecoregion"),
)
  sidebarLayout(
    sidebarPanel(
      selectInput("Realm_Name", "Realm:",
                  choices = unique(coral$Realm_Name)),
      hr(),
      helpText("Data from Biological & Chemical Oceanography Data Mangement Office (2022) Global Bleaching and Environmental Data.")
    ),
    
    mainPanel(
      plotOutput("Temperature_Mean")
    )
  )


