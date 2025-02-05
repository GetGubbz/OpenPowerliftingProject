#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

# Define server logic required to draw a histogram
function(input, output, session) {

    output$welcome <- renderText({
      "Welcome to an Open Powerlifting inspired app! Here you can view self 
      submitted data from individuals competing in all kinds of federations of 
      powerlifting. There are also bodyweight calculators available to see the 
      probability of winning a meet based on bodyweight. These models used USAPL
      data in particular so as to standardize variables like bar type and rule type. 
      This may not apply to equipped lifting."
    })
    
#----- World Map Page ----------------------------------------------------------
    
    output$world_map <- leaflet::renderLeaflet({ 
      leaflet() |> 
        addTiles() |> 
        setView(lng = 0, lat = 0, zoom = 2) 
    })

#----- Mens Page ---------------------------------------------------------------
    
    observe({
      if (input$mens_weight_class %in% mens_weight_classes) {
        if (input$mens_weight_class == 52) {
          updateSliderInput(session, 'mens_weight_range', min=20, max = 52, step=0.1)
        } else if (input$mens_weight_class == 56) {
          updateSliderInput(session, 'mens_weight_range', min=52.1, max = 56, step=0.1)
        } else if (input$mens_weight_class == 60) {
          updateSliderInput(session, 'mens_weight_range', min=56.1, max = 60, step=0.1)
        } else if (input$mens_weight_class == 67.5) {
          updateSliderInput(session, 'mens_weight_range', min=60.1, max = 67.5, step=0.1)
        } else if (input$mens_weight_class == 75) {
          updateSliderInput(session, 'mens_weight_range', min=70.1, max = 75, step=0.1)
        } else if (input$mens_weight_class == 82.5) {
          updateSliderInput(session, 'mens_weight_range', min=75.1, max = 82.5, step=0.1)
        } else if (input$mens_weight_class == 90) {
          updateSliderInput(session, 'mens_weight_range', min=82.6, max = 90, step=0.1)
        } else if (input$mens_weight_class == 100) {
          updateSliderInput(session, 'mens_weight_range', min=90.1, max = 100, step=0.1)
        } else if (input$mens_weight_class == 110) {
          updateSliderInput(session, 'mens_weight_range', min=100.1, max = 110, step=0.1)
        } else if (input$mens_weight_class == 125) {
          updateSliderInput(session, 'mens_weight_range', min=110.1, max = 125, step=0.1)
        } else if (input$mens_weight_class == 140) {
          updateSliderInput(session, 'mens_weight_range', min=125.1, max = 140, step=0.1)
        } else if (input$mens_weight_class == '140+') {
          updateSliderInput(session, 'mens_weight_range', min=140.1, max = 200, step=0.1)
        }
      }
      })
    
    
    output$mens_slider <- renderText({
      paste("Select Your Weight (kg)", input$mens_weight_class)
    })
    
      
    output$weight_model_mens <- renderPlot({
      
      mens_weight_model <- lm(`Winner/Loser` ~ log(BodyweightKg), data =mens_USAPL)
      
      mens_USAPL$fitted_values <- predict(mens_weight_model)
      
      ggplot(mens_USAPL, aes(x=`BodyweightKg`, y=`Winner/Loser`)) + 
        geom_line(aes(y=fitted_values), color='blue') + 
        labs(title = paste('Probability of winning in the ', input$mens_weight_class, ' class'), x='Weight (kg)', y='Probability of Winning')
        
    })
    
#----- Womens Page -------------------------------------------------------------    
    
    observe({
      if (input$womens_weight_class %in% womens_weight_classes) {
        if (input$womens_weight_class == 44) {
          updateSliderInput(session, 'womens_weight_range', min=20, max = 44, step=0.1)
        } else if (input$womens_weight_class == 48) {
          updateSliderInput(session, 'womens_weight_range', min=44.1, max = 48, step=0.1)
        } else if (input$womens_weight_class == 52) {
          updateSliderInput(session, 'womens_weight_range', min=48.1, max = 52, step=0.1)
        } else if (input$womens_weight_class == 56) {
          updateSliderInput(session, 'womens_weight_range', min=52.1, max = 56, step=0.1)
        } else if (input$womens_weight_class == 60) {
          updateSliderInput(session, 'womens_weight_range', min=56.1, max = 60, step=0.1)
        } else if (input$womens_weight_class == 65) {
          updateSliderInput(session, 'womens_weight_range', min=60.1, max = 65, step=0.1)
        } else if (input$womens_weight_class == 70) {
          updateSliderInput(session, 'womens_weight_range', min=65.1, max = 70, step=0.1)
        } else if (input$womens_weight_class == 75) {
          updateSliderInput(session, 'womens_weight_range', min=70.1, max = 75, step=0.1)
        } else if (input$womens_weight_class == 82.5) {
          updateSliderInput(session, 'womens_weight_range', min=75.1, max = 82.5, step=0.1)
        } else if (input$womens_weight_class == 90) {
          updateSliderInput(session, 'womens_weight_range', min=82.6, max = 90, step=0.1)
        } else if (input$womens_weight_class == 100) {
          updateSliderInput(session, 'womens_weight_range', min=90.1, max = 100, step=0.1)
        } else if (input$womens_weight_class == '100+') {
          updateSliderInput(session, 'womens_weight_range', min=100.1, max = 200, step=0.1)
        }
      }
    })
    
    output$womens_slider <- renderText({
      paste("Select Your Weight (kg)", input$womens_weight_class)
    })
}
