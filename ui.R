library(shiny)
library(tidyverse)
library(plotly)
library(shinydashboard)
library(leaflet)
library(dplyr)
library(shinythemes)

coral <- read.csv("global_bleaching_environmental.csv", na.strings = "nd")

Coral_Ordered6 <- coral %>% mutate(across(.cols = starts_with('Temperature_Mean'),.fns = function(x) x - 273.15)) %>% group_by(Country_Name, Date_Year) %>% summarise(aveTemp = mean(Temperature_Mean, na.rm = TRUE), aveBleach = mean(Percent_Bleaching, na.rm = TRUE)) 


library(shinydashboard)


droppy1 <- fluidPage(
  theme = shinytheme("flatly"),
  titlePanel("How Have Oceans Changed Over Time?"),
  fluidRow(
    column(width = 12,
           box(title = "Ocean", status = "warning", solidHeader = TRUE, width = 12,
               selectInput("Ocean_Name", "Ocean:",
                           choices = unique(coral$Ocean_Name)),
               hr(),
               helpText("Data from Biological & Chemical Oceanography Data Management Office (2022) Global Bleaching and Environmental Data.")
           )
    )
  ),
  fluidRow(
    column(width= 6,
           box(title = "Sea Surface Temperature (Celsius) by Ocean", status = "primary", solidHeader = TRUE, width = 12, plotOutput("Temperature_Mean", height = 500),
               hr(),
               helpText("This plot displays the sea surface temperature variation over time for the selected ocean.")
           )
    ),
    column(width = 6,
           box(title = "Percent Bleaching by Ocean", status = "primary", solidHeader = TRUE, width = 12, plotOutput("Percent_Bleaching", height = 500),
               hr(),
               helpText("This plot shows the percentage of bleaching over time for the selected ocean.")
           )
    )
  ),
  
  fluidRow(
    column(width= 12,
           box(title = "Major Insights", status = "danger", solidHeader = TRUE, width = 12,
               p("Oceans...")
           )
    )
  )
)


droppy3 <- fluidPage(
  titlePanel("How Have Ecoregions Changed Over Time?"),
  fluidRow(
    column(width = 12,
           box(title = "Ecoregion", status = "warning", solidHeader = TRUE, width = 12,
               selectInput("Ecoregion_Name", "Select an Ecoregion:",
                           choices = unique(coral$Ecoregion_Name)),
               hr(),
               helpText("Data from Biological & Chemical Oceanography Data Management Office (2022) Global Bleaching and Environmental Data.")
           )
    ),
  ),
  
  fluidRow(
    column(width= 6,
           box(title = "Sea Surface Temperature (Celsius) by Ecoregion", status = "primary", solidHeader = TRUE, width = 12, plotOutput("Temperature_Mean1", height = 500),
               hr(),
               helpText("This plot displays the sea surface temperature variation over time for the selected ecoregion.")
           )
    ),
    column(width = 6,
           box(title = "Percent Bleaching by Ecoregion", status = "primary", solidHeader = TRUE, background = NULL, width = 12, plotOutput("Percent_Bleaching1", height = 500),
               hr(),
               helpText("This plot shows the percentage of bleaching over time for the selected ecoregion.")
           )
    )
  ),
  
  fluidRow(
    column(width = 12,
           box(title = "Major Insights", status = "danger", solidHeader = TRUE, width = 12,
               p("Anywhere we see a positively correlated relationship between the regression line on the sea surface temperature plot and the regression line on the percent bleaching plot where both slopes are negative indicates the potential location of a “bright spot”.  Bright spots are anomalies from the global perspective, an ecosystem that doesn’t match global trends. For example, looking at Cuba and Cayman Islands, there is an inverse relationship between SST and percent bleaching - there is an overall decline in temperature and increase in bleaching. We know as educated global citizens that the Earth’s temperature has continued to increase, but for whatever reason, this ecoregion is an exception to that trend.  However, we see that percent bleaching is increasing, indicating confounding or unaccounted-for variables (in this analysis) could also drive the increase, not necessarily just SST."),
               #p(""),
               p("Costa Rica and the Panama Pacific Coast is an example of a bright spot, where both temperature and percent bleaching decrease (while global trends increase).")
           )
  )
)
)

droppy5 <- fluidPage(
  titlePanel("How Has SST Changed Over Time in Each Country Sampled?"),
  fluidRow(
    column(width =4,
           box(
             title = "Year", status = "warning", solidHeader = TRUE, width = 12,
             sliderInput("Date_Year", "Year:", sep = "",
                         min = 1980, max = 2020, value = 2000, step =NULL
             )
           )
    ),
    column(width = 8,
           box(
             title = "Temperature Mean (Celsius) by Country", status = "primary", solidHeader = TRUE, collapsible = TRUE, width = 12, 
             plotOutput("Temperature_Mean2", height = 500),
             hr(),
             helpText("This plot displays the mean temperature by country for the selected year.")
           )
           
    )
  ),

  fluidRow(  
    column(width = 12,
           box(title = "Major Insights", status = "danger", solidHeader = TRUE, width = 12,
               p("This plot allows the user to select from the 40 years of data collected to see the average sea surface temperature (celsius) during that year for all countries sampled.")
    )
  )
)
)

  
droppy6 <- fluidPage(
  titlePanel("Is there an Underlying Probability Distribution of Percent Bleaching Data?"),
  fluidRow(
  box(
    title = "Zoomable Density Plot of Percent Bleaching", status = "primary", solidHeader = TRUE, collapsible = TRUE, width = 12,
    plotlyOutput("zoomableDensityPlot"),
    hr(),
    helpText("This plot represents the density distribution of percent bleaching over different years with zooming capabilities.")
    )
  ),
  fluidRow(
    box(
      title = "Major Insights", status = "danger", solidHeader = TRUE, collapsible = TRUE, width = 12,
      p("This density plot demonstrates the distribution of percent bleaching over the past 40 years. The highest density of percent bleaching is representative of high bleaching years. There are alarming identifiable trends seen in this plot, with spikes of high density across all ranges of percent bleaching, and when the specific years in these spikes are analyzed, the highest spikes are concentrated across the past 25 years, suggesting an increase in severity of bleaching events in more recent years."),
      p("The findings from this plot also open the door to further analysis such as running regressions to test causality of bleaching with environmental data such as pollution levels, El Nino events, etc., which could further reveal potential causality and relationships between climate change severity and the impacts felt by coral reefs.")
    )
  )
)

# droppy7 <- fluidPage(
#   titlePanel("Regression?"),
#   fluidRow(
#     column(width= 8,
#            box(title = "Temp vs. Bleaching", status = "primary", solidHeader = TRUE, width = 12, plotOutput("Regression", height = 500),
#                hr(),
#                helpText("This plot displays the sea surface temperature variation over time for the selected ocean.")
#            )
#           ),
#     column(width = 4,
#       box(
#         title = "Major Insights", status = "danger", solidHeader = TRUE, collapsible = TRUE, width = 12,
#         p("REGRESSSIOOOOOON")
#       )
#     )
# )
# )

droppy7 <- fluidPage(
  titlePanel("Is There a Relationship Between SST and Percent Bleaching?"),
  fluidRow(
    column(width = 12,
           box(
             title = "Temp vs. Bleaching",
             status = "primary",
             solidHeader = TRUE,
             width = 12,
             selectInput("selected_year", "Select Year", choices = unique(Coral_Ordered6$Date_Year)),
             plotOutput("Regression", height = 500),
             hr(),
             helpText("This plot displays the sea surface temperature variation over time for the selected ocean.")
           )
    )
  ),
  fluidRow(
    column(width = 12,
           box(
             title = "Dare We Call It A Refugium?",
             status = "danger",
             solidHeader = TRUE,
             collapsible = TRUE,
             width = 12,
             p("We hypothesized that when plotting sea surface temperature by ocean and percent bleaching by ocean, both plots would yield a positive r squared value and positively sloped line. Similarly, we predicted a positive r squared value and positive sloped line for SST grouped by ecoregion and percent bleaching by ecoregion. However, for the majority of those plots, our hypothesis did not hold true, so we decided to run a regression to see if there was a relationship between SST and percent bleaching directly. Our findings, as displayed on this graph, are very interesting. As you can see, some years have a significant relationship, showing causality and holding our hypothesis that as temperatures increase, bleaching will increase, true. However, others have a negatively sloped line, implying there was not a causality.  This demonstrates an ecosystem that is a bright spot, (dare we call it a refugium?), or a place where the coral reefs are thriving despite global trends suggesting otherwise.")
           )
    )
  )
)


mappy1 <- fluidPage(
  titlePanel("Where Was The Data Collected From?"),
  box(
    title = "Locations for Data Collected",
    status = "primary", solidHeader = TRUE, collapsible = TRUE, width = 12,
    leafletOutput("map", height = 900),
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
    
  ),
  box(title = "What am I looking at?", status = "danger", solidHeader = TRUE, width = 12,
      p("The raw data gathered from each individual site! Click a cluster to zoom in and learn the corresponding information, including distance to shore, exposure, turbidity, and substrate types!")
  )
)




textbox <- fluidPage(
  titlePanel(h1("Welcome to the Coral Reefs Dashboard!", align = "center")),
  fluidRow(
    column(
      width = 10,
      offset = 1,
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
             valueBox(10 * 4200, "Data Points", color = "green", icon = icon("square-poll-vertical")),
             valueBox(10 * 1270.2, "Sites", color = "yellow", icon = icon("location-dot")),
             valueBox(10 * 4, "Years of Research", color = "red", icon = icon("microscope"))
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
        p("This dashboard provides insights into coral reef assessments using data collected from reefs around the world. The data is from an NSF-funded project in 2021 called “Identifying coral reef ‘bright spots’ from the global 2015-2017 thermal stress event” primarily investigated by researchers from Florida Institute of Technology. Most species of coral have suffered up to 98% mortality over the past 4 decades and are projected to continue to decline as the effects of global climate change such as temperature, ocean acidification, and severe weather events continue to increase in intensity and frequency. This website allows users to interact with various components of the effects of global climate change felt by coral reefs across the world. The data includes temperature, percentage of bleaching over time, and much more using over 42,000 pieces of data collected from thousands of sites around the world over the past 40 years. This allows for comparative analyses and determination of geographical bleaching thresholds and sea surface temperature based on location of the data collected.")
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
      width = 6,
      box(
        title = "Meet The App Creators",
        status = "info",
        solidHeader = TRUE,
        width = 12,
      tags$figure(
        class = "centerFigure",
        img(
          src = "underwater.JPEG",
          width = "100%",
          alt = "Picture of Pari, Estelle, and Abby"
        )
        )
      )
    ),
    column(
      width = 6,
      box(
        title = "About Us",
        status = "danger",
        solidHeader = TRUE,
        width = 12,
        p(style = "font-weight: bold;", "Pari, Estelle, and Abby!"),
        p("Pari is a senior Biology major and MESA minor hailing from Medfield, Massachussetts. She enjoys swimming in the ocean every summer. She wants to help save the corals so the oceans can remain healthy and beautiful!"),
        p("Estelle is a junior Biology and Environmental Studies double major from Dallas, Texas. Estelle lived in Malaysia for nine years, which is why she loves coral reefs so much!"),
        p("Abby is a senior Geology and Environmental Studies double major and Data Science minor from The Woodlands, Texas. Two summers ago, she did research with Dr. Lisa Greer on the coral reefs in Belize, the inspiration for this project!")
      )
      )
    ),
  
  fluidRow(
    column(
      width = 12,
      box(
        title = "Dataset",
        status = "primary", 
        solidHeader = TRUE,
        width = 12,
        DT::dataTableOutput("mytable")
      )
    ),
    column(
      width = 12,
      box(
        title = "References",
        status = "success",
        solidHeader = TRUE,
        width = 12,
        p("The data we utilized were compiled from the following sources: 1) Reef Check (https://www.reefcheck.org/global-reef-tracker/), (2) Donner et al. (2017), (3) McClanahan et al. (2019), (4) AGRRA (https://www.agrra.org), (5) FRRP (https://ocean.floridamarine.org/FRRP/Home/Reports), (6) Safaie et al. (2018), and (7) Kumagai et al. (2018). Site coordinates were standardized to decimal degrees using Google Earth. Coordinates were compared to ensure a sampling event was not duplicated across multiple data sources. Points were removed if they occurred on land or were more than 1 kilometer from a coral reef. Environmental and site data were added to each site, including reef site exposure, distance to land, mean turbidity, cyclone frequency, and CoRTAD Version 6 environmental data.")
      )
    )
    
  ),
  
  fluidRow(
    column(
      width = 12,
      box(
        title = "Download Complete Dataset",
        status = "info",
        solidHeader = TRUE,
        width = 12,
        downloadButton("downloadData", "Download")
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
                            menuItem("Regression", tabName = "Regression", icon = icon("magnifying-glass-chart")),
                            menuItem("References", tabName = "references", icon = icon("clock-rotate-left"))
                            
                )
              ),
              body
)



# https://rstudio.github.io/shinydashboard/structure.html

#Coral_Ordered1 <- coral %>% group_by(Country_Name, Date_Year) %>% summarise(aveTemp = mean(Temperature_Mean, na.rm = TRUE))
#ggplot(Coral_Ordered1, aes(Country_Name, aveTemp, fill = Date_Year)) + geom_bar(stat = 'identity', position = "jitter")
