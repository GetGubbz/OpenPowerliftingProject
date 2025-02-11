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
        background-c olor: #B22222;
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
             titlePanel('Maps of World Powerlifting Totals (Raw and Equipped)'),
             
             plotlyOutput('world_map'),
             plotlyOutput('world_map_womens')
             
             #leaflet::leafletOutput('world_map', width = '100%' , height = '100%'),
             
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
             
             titlePanel('Mens Raw Powerlifting Data'),
             
             sidebarPanel(
               selectInput('mens_weight_class',
                           'Select Weight Class',
                           choices = mens_weight_classes),
               selectInput('mens_age_class',
                           'Select Age Class',
                           choices = mens_USAPL |> 
                             distinct(Division) |> 
                             pull(Division)
                           ),
               sliderInput('mens_weight_range',
                           'Select Your Weight (kg):',
                           min=20,
                           max=200,
                           value=20),
               textInput('Squat',
                         'Input Best Squat Attempt (kg): ',
                         value=0),
               textInput('Bench',
                         'Input Best Bench Attempt (kg): ',
                         value=0),
               textInput('Deadlift',
                         'Input Best Deadlift Attempt (kg): ',
                         value=0)
                           ),
              
             
             mainPanel(
               textOutput('mens_dots_message'),
               textOutput('mens_dots'),
               textOutput('mens_slider'),
               plotOutput('weight_model_mens')
             )
    )
  ),
  tabPanel('Womens Data',
           fluidPage(
             titlePanel('Womens Raw Powerlifting Data'),
             
             sidebarPanel(
               selectInput('womens_weight_class',
                           'Select Weight Class',
                           choices = womens_weight_classes),
               selectInput('womens_age_class',
                           'Select Age Class',
                           choices = womens_USAPL |> 
                             distinct(Division) |> 
                             pull(Division)
               ),
               sliderInput('womens_weight_range',
                           'Select Your Weight (kg):',
                           min=20,
                           max=200,
                           value=20),
               textInput('womens_Squat',
                         'Input Best Squat Attempt (kg): ',
                         value=0),
               textInput('womens_Bench',
                         'Input Best Bench Attempt (kg): ',
                         value=0),
               textInput('womens_Deadlift',
                         'Input Best Deadlift Attempt (kg): ',
                         value=0)
             ),
             
             mainPanel(
               textOutput('womens_dots_message'),
               textOutput('womens_dots'),
               textOutput('womens_slider'),
               plotOutput('weight_model_womens')
                  )
           )
      )
    )
  )
  

