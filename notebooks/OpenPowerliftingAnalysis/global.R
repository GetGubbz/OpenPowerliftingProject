#install.packages("shinydashboard")
#install.packages("arrow")
#install.packages('rsconnect')
#install.packages("shinythemes")
#install.packages('leaflet')

library(rsconnect)

library(shiny)
library(tidyverse)
library(glue)
library(DT)
library(shinydashboard)
library(arrow)
library(leaflet)
library(plotly)

all_mens_data <- read_parquet('../../data/mens_open_powerlifting_full.parquet')
all_womens_data <- read_parquet('../../data/womens_open_powerlifting_full.parquet')
all_data <- read_parquet('../../data/open_powerlifting_full.parquet')

mens_weight_classes <- c(52, 56, 60, 67.5, 75, 82.5, 90, 100, 110, 125, 140, '140+')
womens_weight_classes <- c(44, 48, 52, 56, 60, 65, 70, 75, 82.5, 90, 100, '100+')

mens_weight_classes_df <- data.frame(
  weight_class_floor = c('20', '52.1', '56.1', '60.1', '67.6', '75.1', '82.6', '90.1', '100.1', '110.1', '125.1', '140+'),
  weight_class_ceiling = c('52', '56', '60', '67.5', '75', '82.5', '90', '100', '110', '125', '140', '200')
)

'wilks_mens <- 500/(-216.0475144 + 16.2606339x + -0.002388645xe2 + -0.00113732xe3 + 7.01863e-6xe4 + −1.291e-8xe5)'
'wilks_womens <- 500/(594.31747775582 + −27.23842536447x + 0.82112226871xe2 + 	−0.00930733913xe3 + 4.731582e-5xe4 + 	−9.054e-8xe5)'
'wilks_mens <- 500/(47.46178854 + 
                     8.472061379*input$mens_weight_range + 
                     0.07369410346*input$mens_weight_range^2 + 
                     -0.001395833811*input$mens_weight_range^3 + 
                     7.07665973070743e-6*input$mens_weight_range^4 + 
                     -1.20804336482315e-8*input$mens_weight_range^5)'