library(shiny)
library(tidyverse)
library(plotly)
library(shinydashboard)
library(leaflet)

coral <- read.csv("global_bleaching_environmental.csv", na.strings = "nd")

library(shinydashboard)


droppy1 <- fluidPage(
  fluidRow(
    column(width = 4,
      box(title = "Ocean", status = "warning", solidHeader = TRUE, width = 4,
      selectInput("Ocean_Name", "Ocean:",
                  choices = unique(coral$Ocean_Name)),
      hr(),
      helpText("Data from Biological & Chemical Oceanography Data Management Office (2022) Global Bleaching and Environmental Data.")
      )
    ),
    column( width= 8,
            box(title = "Sea Surface Temperature by Ocean", status = "primary", solidHeader = TRUE, width = 8, plotOutput("Temperature_Mean", height = 500)
  ),
  helpText("This plot displays the sea surface temperature variation over time for the selected ocean.")
  )
  ),
  
  fluidRow(
    column(width = 4),
    column(width = 8,
           box(title = "Percent Bleaching by Ocean", status = "primary", solidHeader = TRUE, width = 8, plotOutput("Percent_Bleaching", height = 500)
  ),
  helpText("This plot shows the percentage of bleaching over time for the selected ocean.")
)
  )
)



droppy3 <- fluidPage(
  
  box(title = "Ecoregion", status = "warning", solidHeader = TRUE, width = 4,
      selectInput("Ecoregion_Name", "Ecoregion:",
                  choices = unique(coral$Ecoregion_Name)),
      hr(),
      helpText("Data from Biological & Chemical Oceanography Data Management Office (2022) Global Bleaching and Environmental Data.")
    ),
    
  box(title = "Sea Surface Temperature (kelvin) by Ecoregion", status = "primary", solidHeader = TRUE, width = 8, plotOutput("Temperature_Mean1", height = 500)
  ),
  helpText("This plot displays the sea surface temperature variation over time for the selected ecoregion.")
    )

droppy4 <- fluidPage(
  box(title = "Ecoregion", status = "warning", solidHeader = TRUE, background = NULL, width = 4,
      selectInput("Ecoregion_Name1", "Ecoregion:",
                  choices = unique(coral$Ecoregion_Name)),
      hr(),
      helpText("Data from Biological & Chemical Oceanography Data Management Office (2022) Global Bleaching and Environmental Data.")
  ),
  
  
  box(title = "Percent Bleaching by Ecoregion", status = "primary", solidHeader = TRUE, background = NULL, width = 8, plotOutput("Percent_Bleaching1", height = 500)
  ),
  helpText("This plot shows the percentage of bleaching over time for the selected ecoregion.")
)



droppy5 <- fluidPage(
  box(
    title = "Temperature Mean by Country", status = "primary", solidHeader = TRUE, collapsible = TRUE, width = 8, 
    plotOutput("Temperature_Mean2", height = 750)
  ),
  helpText("This plot displays the mean temperature by country for the selected year."),
  box(
    title = "Year", status = "warning", solidHeader = TRUE, width = 4,
    sliderInput("Date_Year", "Year:",
                min = 1980, max = 2020, value = 2000, step =NULL
    )
    
  )
)



droppy6 <- fluidPage(
  box(
  title = "Zoomable Density Plot of Percent Bleaching", status = "primary", solidHeader = TRUE, collapsible = TRUE, width = 12,
    plotlyOutput("zoomableDensityPlot"),
  ),
  helpText("This plot represents the density distribution of percent bleaching over different years with zooming capabilities.")
  
)

# mappy1 <- fluidPage(
#   box(
#     title = "Locations for Data Collected",
#     status = "primary", solidHeader = TRUE, collapsible = TRUE, width = 12,
#     leafletOutput("map", height = 500)
#   ),
#   fluidRow(
#     column(width = 6,
#            h4("Selected Site Information"),
#            textOutput("ocean_name_output"),
#            textOutput("percent_bleaching_output"),
#            textOutput("percent_cover_output"),
#            textOutput("turbidity_output")
#     )
#   )
# )



# textbox <- fluidPage(
#   p("Here we will put an introduction for our website.")
# )

textbox <- fluidPage(
  titlePanel("Welcome to the Coral Reefs Dashboard"),
  #sidebarLayout(
  #sidebarPanel(width = 3, ""),
  mainPanel(
    fluidRow(
      column(
        width = 12,
        tags$img(src = "https://upload.wikimedia.org/wikipedia/commons/a/a4/Coral-banner.jpg", width = "75%")
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
)


body <- dashboardBody(
  tabItems(
    tabItem(tabName = "Home", textbox),
    tabItem(tabName = "SeaSurfaceTemperaturebyOcean", droppy1),
    tabItem(tabName = "SeaSurfaceTemperaturebyEcoregion", droppy3),
    tabItem(tabName = "PercentBleachingbyEcoregion", droppy4),
    tabItem(tabName = "TemperatureMeanbyCountry", droppy5),
    tabItem(tabName = "densityPlot", droppy6)
    # tabItem(tabName = "map", mappy1)
    
  )
)

dashboardPage(skin = "purple",
              dashboardHeader(title = "Coral"),
              dashboardSidebar(
                sidebarMenu("Contents",
                            menuItem("Home", tabName = "Home", icon = icon("house")),
                            menuItem("SeaSurfaceTemperaturebyOcean", tabName = "SeaSurfaceTemperaturebyOcean", icon = icon("temperature-three-quarters")),    
                            #menuItem("PercentBleachingbyOcean", tabName = "PercentBleachingbyOcean", icon = icon("droplet")),
                            menuItem("SeaSurfaceTemperaturebyEcoregion", tabName = "SeaSurfaceTemperaturebyEcoregion", icon = icon("droplet")),
                            menuItem("PercentBleachingbyEcoregion", tabName = "PercentBleachingbyEcoregion", icon = icon("droplet")),
                            menuItem("TemperatureMeanbyCountry", tabName = "TemperatureMeanbyCountry", icon = icon("droplet")),
                            menuItem("DensityPlot", tabName = "densityPlot", icon = icon("droplet"))
                            # menuItem("Map", tabName = "map", icon = icon("droplet"))
                            
                )
              ),
              body
)



# https://rstudio.github.io/shinydashboard/structure.html

#Coral_Ordered1 <- coral %>% group_by(Country_Name, Date_Year) %>% summarise(aveTemp = mean(Temperature_Mean, na.rm = TRUE))
#ggplot(Coral_Ordered1, aes(Country_Name, aveTemp, fill = Date_Year)) + geom_bar(stat = 'identity', position = "jitter")




