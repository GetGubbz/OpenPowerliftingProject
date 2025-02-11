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
      powerlifting. All data is provided by the Open Powerlifting Team over at 
      https://www.openpowerlifting.org/ where you can access all of the data for free"
    })
    
#----- World Map Page ----------------------------------------------------------
    
    output$world_map <- renderPlotly({
      
      df_country_codes <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/2014_world_gdp_with_codes.csv")
      
      df_country_codes <- df_country_codes |> 
        rename(Country = COUNTRY)
      
      all_mens_data <- all_mens_data |> 
        mutate(MeetCountry = ifelse(MeetCountry == 'USA', 'United States', MeetCountry))
      
      merged_df <- inner_join(df_country_codes, all_mens_data)
      
      df <- merged_df |> 
        group_by(CODE) |> 
        summarize(Sum_winner_loser = sum(`Winner/Loser`), max_total = max(TotalKg))
      
      
      fig <- plot_ly(df, type='choropleth', locations=df$CODE, z=df$max_total, text=df$CODE, colorscale="Blues")
      
      fig <- fig %>% layout(title = "Mens Global Max Totals")
      
      
      fig
      
    })
    
    output$world_map_womens <- renderPlotly({
      
      df_country_codes <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/2014_world_gdp_with_codes.csv")
      
      df_country_codes <- df_country_codes |> 
        rename(Country = COUNTRY)
      
      all_womens_data <- all_womens_data |> 
        mutate(MeetCountry = ifelse(MeetCountry == 'USA', 'United States', MeetCountry))
      
      merged_df <- inner_join(df_country_codes, all_womens_data)
      
      df <- merged_df |> 
        group_by(CODE) |> 
        summarize(Sum_winner_loser = sum(`Winner/Loser`), max_total = max(TotalKg))
      
      
      fig <- plot_ly(df, type='choropleth', locations=df$CODE, z=df$max_total, text=df$CODE, colorscale="Pinks")
      
      fig <- fig %>% layout(title = "Womens Global Max Totals")
      
      fig
      
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
    
    output$mens_dots_message <- renderText({
      paste("Your DOTS Score: ")
    })
    
    output$mens_dots <- renderText({
      
      dots_mens_coef <- 500/(307.75076  + 
                           24.0900756 *input$mens_weight_range + 
                           0.1918759221*input$mens_weight_range^2 + 
                           0.0007391293 *input$mens_weight_range^3 + 
                           0.000001093*input$mens_weight_range^4)

      mens_dots <- (as.numeric(input$Squat) + as.numeric(input$Bench) + as.numeric(input$Deadlift))/(dots_mens_coef)
    })
      
    output$weight_model_mens <- renderPlot({
      
      new_data <- all_mens_data |> 
        filter(WeightClassKg == input$mens_weight_class &
                 Division == input$mens_age_class)
      
      mens_weight_model <- glm(`Winner/Loser` ~ BodyweightKg, family=binomial, data =new_data)
      
      
      
      p <- predict(mens_weight_model,
                   newdata= new_data,
                   type = "link",
                   se.fit = TRUE) |> 
        data.frame() |> 
        mutate(ll = fit - 1.96 * se.fit,
               ul = fit + 1.96 * se.fit) |> 
        select(-residual.scale, -se.fit) |> 
        mutate_all(plogis) |> 
        bind_cols(new_data)
      
      p |> 
        ggplot(aes(x = BodyweightKg, y = fit)) +
        geom_ribbon(aes(ymin = ll, ymax = ul),
                    alpha = 1/2) +
        geom_line() +
        scale_y_continuous("probability of winning", 
                           expand = c(0, 0), limits = 0:1) +
        theme(panel.grid = element_blank())+
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
    
    output$weight_model_womens <- renderPlot({
      
      
      womens_new_data <- all_womens_data |> 
        filter(WeightClassKg == input$womens_weight_class &
                 Division == input$womens_age_class)
      
      womens_weight_model <- glm(`Winner/Loser` ~ BodyweightKg, family=binomial, data =womens_new_data)
      
      p <- predict(womens_weight_model,
                   newdata= womens_new_data,
                   type = "link",
                   se.fit = TRUE) |> 
        data.frame() |> 
        mutate(ll = fit - 1.96 * se.fit,
               ul = fit + 1.96 * se.fit) |> 
        select(-residual.scale, -se.fit) |> 
        mutate_all(plogis) |> 
        bind_cols(womens_new_data)
      
      p |> 
        ggplot(aes(x = BodyweightKg, y = fit)) +
        geom_ribbon(aes(ymin = ll, ymax = ul),
                    alpha = 1/2) +
        geom_line() +
        scale_y_continuous("probability of winning", 
                           expand = c(0, 0), limits = 0:1) +
        theme(panel.grid = element_blank())+
        labs(title = paste('Probability of winning in the ', input$womens_weight_class, ' class'), x='Weight (kg)', y='Probability of Winning')
      
      
    })
    output$womens_dots_message <- renderText({
      paste("Your DOTS Score: ")
    })
    
    output$womens_dots <- renderText({
      
      dots_womens_coef <- 500/(-57.96288  + 
                               13.6175032 *input$womens_weight_range + 
                               -0.1126655495*input$womens_weight_range^2 + 
                               0.0005158568  *input$womens_weight_range^3 + 
                               -0.0000010706 *input$womens_weight_range^4)
      
      womens_dots <- (as.numeric(input$womens_Squat) + as.numeric(input$womens_Bench) + as.numeric(input$womens_Deadlift))/(dots_womens_coef)
    })
}
