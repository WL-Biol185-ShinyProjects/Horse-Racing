library(shiny)
library(tidyverse)
coral <- read.csv("global_bleaching_environmental.csv")

library(shinydashboard)

droppy1 <- fluidPage(
  
  
    titlePanel("Sea Surface Temperature by Ocean"),
  
    sidebarLayout(
      sidebarPanel(
        selectInput("Ocean_Name", "Ocean:",
                  choices = unique(coral$Ocean_Name)),
        hr(),
        helpText("Data from Biological & Chemical Oceanography Data Management Office (2022) Global Bleaching and Environmental Data.")
      ),
    
      mainPanel(
        plotOutput("Temperature_Mean")
        )
      )
    )


sidebar <- dashboardSidebar( 
  sidebarMenu("Sea Surface Temperature by Ocean", tabName = "Sea Surface Temperature by Ocean", icon = icon("Sea Surface Temperature by Ocean")),
    menuItem("SeaSurfaceTemperaturebyOcean", tabName = "SeaSurfaceTemperaturebyOcean"
           )
  )


body <- dashboardBody(
  tabItems(
    tabItem(tabName = "SeaSurfaceTemperaturebyOcean", droppy1
      ),
    
    tabItem(tabName = "SeaSurfaceTemperatureByOcean", droppy1
      )
    )
  )

dashboardPage(
  dashboardHeader(title = "Coral"),
  sidebar, 
  body
  )
  
    
# https://rstudio.github.io/shinydashboard/structure.html





