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

droppy2 <- fluidPage(
  
  
  titlePanel("Percent Bleaching by Ocean"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("Ocean_Name1", "Ocean:",
                  choices = unique(coral$Ocean_Name)),
      hr(),
      helpText("Data from Biological & Chemical Oceanography Data Management Office (2022) Global Bleaching and Environmental Data.")
    ),
    
    mainPanel(
      plotOutput("Percent_Bleaching")
    )
  )
)


sidebar <- dashboardSidebar(
  sidebarMenu("Contents",
              menuItem("SeaSurfaceTemperaturebyOcean", tabName = "SeaSurfaceTemperaturebyOcean"),    
              menuItem("PercentBleachingbyOcean", tabName = "PercentBleachingbyOcean")
  )
)


body <- dashboardBody(
  tabItems(
    tabItem(tabName = "SeaSurfaceTemperaturebyOcean", droppy1
    ),
    tabItem(tabName = "PercentBleachingbyOcean", droppy2)
  )
)     




dashboardPage(
  dashboardHeader(title = "Coral"),
  sidebar, 
  body
  )
  
    
# https://rstudio.github.io/shinydashboard/structure.html





