library(shiny)
library(tidyverse)
library(plotly)
library(shinydashboard)
library(leaflet)
library(dplyr)

coral <- read.csv("global_bleaching_environmental.csv", na.strings = "nd")

library(shinydashboard)


droppy1 <- fluidPage(
  titlePanel("How Have Oceans Changed Over Time?"),
  fluidRow(
    column(width = 4,
           box(title = "Ocean", status = "warning", solidHeader = TRUE, width = 12,
               selectInput("Ocean_Name", "Ocean:",
                           choices = unique(coral$Ocean_Name)),
               hr(),
               helpText("Data from Biological & Chemical Oceanography Data Management Office (2022) Global Bleaching and Environmental Data.")
           )
    ),
    column(width= 8,
           box(title = "Sea Surface Temperature (Celsius) by Ocean", status = "primary", solidHeader = TRUE, width = 12, plotOutput("Temperature_Mean", height = 500),
               hr(),
               helpText("This plot displays the sea surface temperature variation over time for the selected ocean.")
           )
    )
  ),
  
  fluidRow(
    column(width = 4),
    column(width = 8,
           box(title = "Percent Bleaching by Ocean", status = "primary", solidHeader = TRUE, width = 12, plotOutput("Percent_Bleaching", height = 500),
               hr(),
               helpText("This plot shows the percentage of bleaching over time for the selected ocean.")
           )
    )
  )
)


droppy3 <- fluidPage(
  titlePanel("How Have Ecoregions Changed Over Time?"),
  fluidRow(
    column(width = 4,
           box(title = "Ecoregion", status = "warning", solidHeader = TRUE, width = 12,
               selectInput("Ecoregion_Name", "Ecoregion:",
                           choices = unique(coral$Ecoregion_Name)),
               hr(),
               helpText("Data from Biological & Chemical Oceanography Data Management Office (2022) Global Bleaching and Environmental Data.")
           )
    ),
    column(width= 8,
           box(title = "Sea Surface Temperature (Celsius) by Ecoregion", status = "primary", solidHeader = TRUE, width = 12, plotOutput("Temperature_Mean1", height = 500),
               hr(),
               helpText("This plot displays the sea surface temperature variation over time for the selected ecoregion.")
           )
    )
  ),
  
  fluidRow(
    column(width = 4),
    column(width = 8,
           box(title = "Percent Bleaching by Ecoregion", status = "primary", solidHeader = TRUE, background = NULL, width = 12, plotOutput("Percent_Bleaching1", height = 500),
               hr(),
               helpText("This plot shows the percentage of bleaching over time for the selected ecoregion.")
           )
    )
  )
)


droppy5 <- fluidPage(
  titlePanel("How Have Countries' Coral Reefs Changed Over Time?"),
  box(
    title = "Temperature Mean (Celsius) by Country", status = "primary", solidHeader = TRUE, collapsible = TRUE, width = 8, 
    plotOutput("Temperature_Mean2", height = 750),
    hr(),
    helpText("This plot displays the mean temperature by country for the selected year.")
  ),
  box(
    title = "Year", status = "warning", solidHeader = TRUE, width = 4,
    sliderInput("Date_Year", "Year:", sep = "",
                min = 1980, max = 2020, value = 2000, step =NULL
    )
    
  )
)


droppy6 <- fluidPage(
  titlePanel("Density?"),
  box(
    title = "Zoomable Density Plot of Percent Bleaching", status = "primary", solidHeader = TRUE, collapsible = TRUE, width = 12,
    plotlyOutput("zoomableDensityPlot"),
    hr(),
    helpText("This plot represents the density distribution of percent bleaching over different years with zooming capabilities.")
  )
)

mappy1 <- fluidPage(
  titlePanel("How Have Oceans Changed Over Time?"),
  box(
    title = "Locations for Data Collected",
    status = "primary", solidHeader = TRUE, collapsible = TRUE, width = 12,
    leafletOutput("map", height = 500),
    hr(),
    helpText("This map allows you to see...")
  )
)



# textbox <- fluidPage(
#   p("Here we will put an introduction for our website.")
# )

textbox <- fluidPage(
  titlePanel("Welcome to the Coral Reefs Dashboard!"),
  fluidRow(
    column(
      width = 12,
      box(
        status = "info",
        solidHeader = TRUE,
        width = 12,
        tags$img(src = "https://upload.wikimedia.org/wikipedia/commons/a/a4/Coral-banner.jpg", align = "center", width = "100%")
      )
    )
  ),
  fluidRow(
    column(
      width = 12,
      box(
        title = "Introduction",
        status = "primary", 
        solidHeader = TRUE,
        width = 12,
        p("This dashboard provides insights into ocean temperatures, coral bleaching, and more...")
      )
    )
  ),
  fluidRow(
    column(
      width = 12,
      box(
        title = "Dashboard Features",
        status = "info",
        solidHeader = TRUE,
        width = 12,
        "Here you can find information on different aspects related to coral reefs and ocean data."
      )
    )
  )
)

references <- fluidPage(
  titlePanel("References"),
  fluidRow(
    column(
      width = 12,
      tags$figure(
        class = "centerFigure",
        tags$img(
          src = "https://rstudioworkbench.wlu.edu/s/eba9e8dedfcdd6550f943/files/Horse-Racing/underwater.JPEG",
          width = 600,
          alt = "Picture of Pari, Estelle, and Abby"
        )
      )
    )
  ),
  
  fluidRow(
    column(
      width = 12,
      box(
        title = "References",
        status = "primary", 
        solidHeader = TRUE,
        width = 12,
        p("Works Cited... I would like to put an option to download the data file here")
      )
    )
  )
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "Home", textbox),
    tabItem(tabName = "SeaSurfaceTemperaturebyOcean", droppy1),
    tabItem(tabName = "SeaSurfaceTemperaturebyEcoregion", droppy3),
    tabItem(tabName = "TemperatureMeanbyCountry", droppy5),
    tabItem(tabName = "densityPlot", droppy6),
    tabItem(tabName = "map", mappy1),
    tabItem(tabName = "references", references)
    
  )
)

dashboardPage(skin = "purple",
              dashboardHeader(title = "Coral Reefs Dashboard",
                              titleWidth = 250),
              dashboardSidebar(
                sidebarMenu(style = "white-space: normal;",
                            "Contents",
                            menuItem("Home", tabName = "Home", icon = icon("house")),
                            menuItem("Ocean Temperatures & Coral Bleaching", tabName = "SeaSurfaceTemperaturebyOcean", icon = icon("water")),    
                            #menuItem("PercentBleachingbyOcean", tabName = "PercentBleachingbyOcean", icon = icon("droplet")),
                            menuItem("Ecoregion Sea Temperatures & Coral Bleaching", tabName = "SeaSurfaceTemperaturebyEcoregion", icon = icon("earth-americas")),
                            #menuItem("PercentBleachingbyEcoregion", tabName = "PercentBleachingbyEcoregion", icon = icon("droplet")),
                            menuItem("Countries' Sea Surface Temperature Means", tabName = "TemperatureMeanbyCountry", icon = icon("temperature-three-quarters")),
                            menuItem("Density Plot", tabName = "densityPlot", icon = icon("droplet")),
                            menuItem("Map of Data Collected", tabName = "map", icon = icon("map")),
                            menuItem("References", tabName = "references", icon = icon("clock-rotate-left"))
                            
                )
              ),
              body
)



# https://rstudio.github.io/shinydashboard/structure.html

#Coral_Ordered1 <- coral %>% group_by(Country_Name, Date_Year) %>% summarise(aveTemp = mean(Temperature_Mean, na.rm = TRUE))
#ggplot(Coral_Ordered1, aes(Country_Name, aveTemp, fill = Date_Year)) + geom_bar(stat = 'identity', position = "jitter")
