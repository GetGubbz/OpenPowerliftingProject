#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define UI for application that draws a histogram
fluidPage(
  tags$head(
    tags$style(HTML("
      .navbar {
        background-color: #B22222;
      }
      .navbar-nav > li > a {
        color: white;
      }
      .navbar-nav > li > a:hover {
        color: #1C1C1C;
      }
    "))
  ),


navbarPage(
  
    # Application title
    title = "Open Powerlifting Data Analysis",

    # Sidebar with a slider input for number of bins
    tabPanel('Home',
             fluidPage(
               tags$style(
               HTML("body {
                        background-color: #1C1C1C;
                        color: #FFFFFF;
                      }
                      .btn-primary {
                        background-color: #ff6347;
                      }
                    ")),
               titlePanel("Open Powerlifting Data Analysis"),
        ),

        # Show a plot of the generated distribution
        mainPanel(
            textOutput('welcome')
        )
    ),
  tabPanel('World Map',
           fluidPage(
             titlePanel('Map of World Powerlifting Statistics (Raw and Equipped)'),
             
             leaflet::leafletOutput('world_map', width = '100%' , height = '100%'),
             
    )
  ),
  tabPanel('Mens Data',
           fluidPage(
             tags$style(
             HTML("
              .custom-input {
                color: #1C1C1C;
              }"
                  )
             ),
             
             titlePanel('Mens USAPL Data'),
             
             sidebarPanel(
               selectInput('mens_weight_class',
                           'Select Weight Class',
                           choices = mens_weight_classes),
               sliderInput('mens_weight_range',
                           'Select Your Weight (kg):',
                           min=20,
                           max=200,
                           value=20)
                           ),
             
             mainPanel(
               textOutput('mens_slider'),
               plotOutput('weight_model_mens')
             )
    )
  ),
  tabPanel('Womens Data',
           fluidPage(
             titlePanel('Womens USAPL Data'),
             
             sidebarPanel(
               selectInput('womens_weight_class',
                           'Select Weight Class',
                           choices = womens_weight_classes),
               sliderInput('womens_weight_range',
                           'Select Your Weight (kg):',
                           min=20,
                           max=200,
                           value=20)
                        ),
             
             mainPanel(
               textOutput('womens_slider'),
               plotOutput('weight_model_womens')
                  )
      )
    )
  )
)
  

