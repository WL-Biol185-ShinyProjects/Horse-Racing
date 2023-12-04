library(shiny)
library(tidyverse)
library(plotly)
library(shinydashboard)
library(leaflet)
library(dplyr)

coral <- read.csv("global_bleaching_environmental.csv", na.strings = "nd")

library(shinydashboard)

##add in the boxes on the first 2 pages that the predicted relationship of positive r squared values for temp AND bleaching
##did not hold true, which could be due to confounding variables OR it could mean that a linear relationship may not 
##adequately describe the association between these variables. It's possible that the relationship is 
##nonlinear, or other factors might be more influential in explaining variations in bleaching aside from temperature alone.
##so we created a separate regression plot isolating temp and bleaching to see if we could find a relationship (GETTING TO THAT L8R)

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


droppy7 <- fluidPage(
  titlePanel("Regression?"),
  fluidRow(
    column(width= 8,
           box(title = "Temp vs. Bleaching", status = "primary", solidHeader = TRUE, width = 12, plotOutput("Regression", height = 500),
               hr(),
               helpText("This plot displays the sea surface temperature variation over time for the selected ocean.")
           )
)
)
)

mappy1 <- fluidPage(
  titlePanel("How Have Oceans Changed Over Time?"),
  box(
    title = "Locations for Data Collected",
    status = "primary", solidHeader = TRUE, collapsible = TRUE, width = 12,
    leafletOutput("map", height = 500),
    hr(),
    textOutput("site_info_Site_Name"),
    textOutput("site_info_Ocean_Name"),
    textOutput("site_info_Ecoregion_Name"),
    textOutput("site_info_Distance_to_Shore"),
    textOutput("site_info_Exposure"),
    textOutput("site_info_Turbidity"),
    textOutput("site_info_Cyclone_Frequency"),
    textOutput("site_info_Date_Day"),
    textOutput("site_info_Date_Month"),
    textOutput("site_info_Date_Year"),
    textOutput("site_info_Depth_m"),
    textOutput("site_info_Substrate_Name"),
    textOutput("site_info_Percent_Bleaching"),
    textOutput("site_info_Temperature_Kelvin"),
    textOutput("site_info_Windspeed"),
    textOutput("site_info_Site_Comments"),
    textOutput("site_info_Sample_Comments"),
    textOutput("site_info_Bleaching_Comments")
    
  )
)




textbox <- fluidPage(
  titlePanel("Welcome to the Coral Reefs Dashboard!"),
  fluidRow(
    column(
      width = 12,
      box(
        status = "info",
        solidHeader = TRUE,
        width = 6,
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
        p("This dashboard provides insights into coral reef assessments using data collected from reefs around the world. The data is from an NSF-funded project in 2021 called “Identifying coral reef ‘bright spots’ from the global 2015-2017 thermal stress event” primarily investigated by researchers from Florida Institute of Technology. Most species of coral have suffered up to 98% mortality over the past 4 decades and are projected to continue to decline as the effects of global climate change such as temperature, ocean acidification, and severe weather events continue to increase in intensity and frequency. This website allows users to interact with various components of the effects of global climate change felt by coral reefs across the world. The data includes temperature, percentage of bleaching over time, and much more using over 42,000 pieces of data collected from hundreds of sites around the world over the past 40 years. This allows for comparative analyses and determination of geographical bleaching thresholds and sea surface temperature based on location of the data collected.")
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
      box(
        status = "info",
        solidHeader = TRUE,
        width = 6,
      tags$figure(
        class = "centerFigure",
        img(
          src = "underwater.JPEG",
          width = "100%",
          alt = "Picture of Pari, Estelle, and Abby"
        )
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
    tabItem(tabName = "map", mappy1),
    tabItem(tabName = "SeaSurfaceTemperaturebyOcean", droppy1),
    tabItem(tabName = "SeaSurfaceTemperaturebyEcoregion", droppy3),
    tabItem(tabName = "TemperatureMeanbyCountry", droppy5),
    tabItem(tabName = "densityPlot", droppy6),
    tabItem(tabName = "Regression", droppy7),
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
                            menuItem("Map of Data Collected", tabName = "map", icon = icon("map")),
                            menuItem("Ocean Temperatures & Coral Bleaching", tabName = "SeaSurfaceTemperaturebyOcean", icon = icon("water")),    
                            #menuItem("PercentBleachingbyOcean", tabName = "PercentBleachingbyOcean", icon = icon("droplet")),
                            menuItem("Ecoregion Sea Temperatures & Coral Bleaching", tabName = "SeaSurfaceTemperaturebyEcoregion", icon = icon("earth-americas")),
                            #menuItem("PercentBleachingbyEcoregion", tabName = "PercentBleachingbyEcoregion", icon = icon("droplet")),
                            menuItem("Countries' Sea Surface Temperature Means", tabName = "TemperatureMeanbyCountry", icon = icon("temperature-three-quarters")),
                            menuItem("Density Plot", tabName = "densityPlot", icon = icon("droplet")),
                            menuItem("Regression", tabName = "Regression", icon = icon("water")),
                            menuItem("References", tabName = "references", icon = icon("clock-rotate-left"))
                            
                )
              ),
              body
)



# https://rstudio.github.io/shinydashboard/structure.html

#Coral_Ordered1 <- coral %>% group_by(Country_Name, Date_Year) %>% summarise(aveTemp = mean(Temperature_Mean, na.rm = TRUE))
#ggplot(Coral_Ordered1, aes(Country_Name, aveTemp, fill = Date_Year)) + geom_bar(stat = 'identity', position = "jitter")
