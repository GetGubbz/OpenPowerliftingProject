

library(shiny)

# Define UI for application that draws a histogram
fluidPage(
  tags$head(
    tags$style(HTML("
      body {
        background-color: #ffffff; /* Background color */
      }
      .navbar {
        background-color: #d32f2f; /* Navbar background color */
      }
      .navbar .navbar-nav > li > a {
        color: white !important; /* Navbar text color */
      }
      .navbar .navbar-brand {
        color: #ffffff !important; /* White color for navbar title */
      }
      h1 {
        color: #ffffff; /* Change color of h1 text */
      }
      p {
        color: #ffffff; /* Change color of paragraphs */
      }
    "))
  ),


navbarPage(
  
    # Application title
    title = "Open Powerlifting Data Analysis",

    # Sidebar with a slider input for number of bins
    tabPanel('Home',
             fluidPage(
               titlePanel("Open Powerlifting Data Analysis"),
        ),

        # Show a plot of the generated distribution
        mainPanel(
            textOutput('welcome')
        )
    ),
  tabPanel('World Map',
           fluidPage(
             titlePanel('Maps of Max DOTS Scores per Country'),
             
             plotlyOutput('world_map'),
             plotlyOutput('world_map_womens')
             
    )
  ),
  tabPanel('Mens Data',
           fluidPage(
             
             titlePanel('Mens Raw Powerlifting Data'),
             
             sidebarPanel(
               selectInput('mens_weight_class',
                           'Select Weight Class (kg)',
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
               wellPanel(
                 h3('DOTS Calculator'),
               textOutput('mens_dots_message'),
               textOutput('mens_dots')
             ),
             wellPanel(
               h3('Probability Plot of Winning Selected Age Division'),
               textOutput('mens_slider'),
               plotOutput('weight_model_mens')
             )
             )
    )
  ),
  tabPanel('Womens Data',
           fluidPage(
             titlePanel('Womens Raw Powerlifting Data'),
             
             sidebarPanel(
               selectInput('womens_weight_class',
                           'Select Weight Class (kg)',
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
               wellPanel(
                 h3('DOTS Calculator'),
               textOutput('womens_dots_message'),
               textOutput('womens_dots')
               ),
               wellPanel(
                 h3('Probability Plot of Winning Selected Age Division'),
               textOutput('womens_slider'),
               plotOutput('weight_model_womens')
                  )
           )
      )
    )
  )
)
  

