library(shiny)
library(tidyverse)
coral <- read.csv("global_bleaching_environmental.csv")

fluidPage(
  titlePanel(title= "Sea Surface Temperature by Ocean")
)
sidebarPanel(
  sliderInput("Ocean Name", "Ocean:",
              min = 0, max = 310, step=20
              , value=c(0,310)),
  mainPanel(
    plotOutput("Temperature_Mean")
  )
)


# fluidPage(
#   
#   titlePanel("Sea Surface Temperature by Ocean"),
#   
#   sidebarLayout(
#     sidebarPanel(
#       selectInput("Ocean_Name", "Ocean:",
#                   choices = unique(coral$Ocean_Name)),
#       hr(),
#       helpText("Data from Biological & Chemical Oceanography Data Mangement Office (2022) Global Bleaching and Environmental Data.")
# #     ),
# #     
# #     mainPanel(
# #       plotOutput("Temperature_Mean")
#     )
#   )
# )  
# 
