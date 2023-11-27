library(shiny)
library(tidyverse)
coral <- read.csv("global_bleaching_environmental.csv", na.strings = "nd")

library(shinydashboard)


droppy1 <- fluidPage(
  box(title = "Input", status = "warning", solidHeader = TRUE, width = 4,
      selectInput("Ocean_Name", "Ocean:",
                  choices = unique(coral$Ocean_Name)),
      hr(),
      helpText("Data from Biological & Chemical Oceanography Data Management Office (2022) Global Bleaching and Environmental Data.")
  ),
  
  box(title = "Sea Surface Temperature by Ocean", status = "primary", solidHeader = TRUE, width = 8, plotOutput("Temperature_Mean", height = 500)
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

droppy4 <- fluidPage(
  box(title = "Percent Bleaching by Ecoregion", status = "warning", solidHeader = TRUE, background = NULL, width = 4,
      selectInput("Ecoregion_Name1", "Ecoregion:",
                  choices = unique(coral$Ecoregion_Name)),
      hr(),
      helpText("Data from Biological & Chemical Oceanography Data Management Office (2022) Global Bleaching and Environmental Data.")
  ),
  
  
  box(title = "Percent Bleaching", status = "primary", solidHeader = TRUE, background = NULL, width = 8, plotOutput("Percent_Bleaching1", height = 500)
  )
)



droppy5 <- fluidPage(
  box(
    title = "Temperature Mean by Country", status = "primary", solidHeader = TRUE, collapsible = TRUE, width = 8, 
    plotOutput("Temperature_Mean2", height = 750)
  ),
  box(
    title = "Inputs", status = "warning", solidHeader = TRUE, width = 4,
    sliderInput("Date_Year", "Year:",
                min = 1980, max = 2020, value = 2000, step =NULL
    )
    
  )
)

textbox <- fluidPage(
  
  p("here we will put an introduction for our website")
)


sidebar <- dashboardSidebar(
  sidebarMenu("Contents",
              menuItem("Home", tabName = "Home", icon = icon("house")),
              menuItem("SeaSurfaceTemperaturebyOcean", tabName = "SeaSurfaceTemperaturebyOcean", icon = icon("temperature-three-quarters")),    
              menuItem("PercentBleachingbyOcean", tabName = "PercentBleachingbyOcean", icon = icon("droplet")),
              menuItem("SeaSurfaceTemperaturebyEcoregion", tabName = "SeaSurfaceTemperaturebyEcoregion", icon = icon("droplet")),
              menuItem("PercentBleachingbyEcoregion", tabName = "PercentBleachingbyEcoregion", icon = icon("droplet")),
              menuItem("TemperatureMeanbyCountry", tabName = "TemperatureMeanbyCountry", icon = icon("droplet"))
  )
)


body <- dashboardBody(
  tabItems(
    tabItem(tabName = "Home", textbox),
    tabItem(tabName = "SeaSurfaceTemperaturebyOcean", droppy1
    ),
    tabItem(tabName = "PercentBleachingbyOcean", droppy2),
    tabItem(tabName = "SeaSurfaceTemperaturebyEcoregion", droppy3),
    tabItem(tabName = "PercentBleachingbyEcoregion", droppy4),
    tabItem(tabName = "TemperatureMeanbyCountry", droppy5)
  )
)     




dashboardPage(skin = "purple",
              dashboardHeader(title = "Coral"),
              sidebar, 
              body
)


# https://rstudio.github.io/shinydashboard/structure.html

#Coral_Ordered1 <- coral %>% group_by(Country_Name, Date_Year) %>% summarise(aveTemp = mean(Temperature_Mean, na.rm = TRUE))
#ggplot(Coral_Ordered1, aes(Country_Name, aveTemp, fill = Date_Year)) + geom_bar(stat = 'identity', position = "jitter")




