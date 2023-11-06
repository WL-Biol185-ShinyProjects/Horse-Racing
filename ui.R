library(shiny)
library(tidyverse)
coral <- read.csv("global_bleaching_environmental.csv", na.strings = "nd")

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

droppy3 <- fluidPage(
  
  titlePanel("Sea Surface Temperature by Ecoregion"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("Ecoregion_Name", "Ecoregion:",
                  choices = unique(coral$Ecoregion_Name)),
      hr(),
      helpText("Data from Biological & Chemical Oceanography Data Management Office (2022) Global Bleaching and Environmental Data.")
    ),
    
    mainPanel(
      plotOutput("Temperature_Mean1")
    )
  )
)


sidebar <- dashboardSidebar(
  sidebarMenu("Contents",
              menuItem("Home", tabName = "Home", icon = icon("house")),
              menuItem("SeaSurfaceTemperaturebyOcean", tabName = "SeaSurfaceTemperaturebyOcean", icon = icon("temperature-three-quarters")),    
              menuItem("PercentBleachingbyOcean", tabName = "PercentBleachingbyOcean", icon = icon("droplet")),
              menuItem("SeaSurfaceTemperaturebyEcoregion", tabName = "SeaSurfaceTemperaturebyEcoregion", icon = icon("droplet"))
  )
)


body <- dashboardBody(
  tabItems(
    tabItem(tabName = "Home"),
    tabItem(tabName = "SeaSurfaceTemperaturebyOcean", droppy1
    ),
    tabItem(tabName = "PercentBleachingbyOcean", droppy2),
    tabItem(tabName = "SeaSurfaceTemperaturebyEcoregion", droppy3)
  )
)     




dashboardPage(skin = "purple",
  dashboardHeader(title = "Coral"),
  sidebar, 
  body
  )
  
    
# https://rstudio.github.io/shinydashboard/structure.html





