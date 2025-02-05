#install.packages("shinydashboard")
#install.packages("arrow")
#install.packages('rsconnect')
#install.packages("shinythemes")
#install.packages('leaflet')
#library(rsconnect)

library(shiny)
library(tidyverse)
library(glue)
library(shinythemes)
library(DT)
library(shinydashboard)
library(arrow)
library(leaflet)


#rsconnect::setAccountInfo(name='gubbz', token='52AD7AC7D8F48E11903208D7840EB69B', secret='rQVa/Gx7PLy+qtJDvCOk5jmLxjuLkXcjL5qofhiU')


mens_USAPL <- read_parquet('../../data/raw_mens_USAPL.parquet')
womens_USAPL <- read_parquet('../../data/raw_womens_USAPL.parquet')
all_data <- read_parquet('../../data/open_powerlifting_full.parquet')

mens_weight_classes <- c(52, 56, 60, 67.5, 75, 82.5, 90, 100, 110, 125, 140, '140+')
womens_weight_classes <- c(44, 48, 52, 56, 60, 65, 70, 75, 82.5, 90, 100, '100+')

mens_weight_classes_df <- data.frame(
  weight_class_floor = c('20', '52.1', '56.1', '60.1', '67.6', '75.1', '82.6', '90.1', '100.1', '110.1', '125.1', '140+'),
  weight_class_ceiling = c('52', '56', '60', '67.5', '75', '82.5', '90', '100', '110', '125', '140', '200')
)
