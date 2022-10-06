library(shiny)
library(readr)
library(dplyr)
library(DT)

shinyServer(function(input, output) {
  
  tabla_rating <- read_csv('ratings.csv')
  
  output$out_slider_input_multi<- renderTable({
    #browser()
    a <- as.integer(input$slinputmulti)
    tabla_rating %>%
          select(movieId, rating) %>%
          group_by(movieId) %>%
          summarize(r = mean(rating)) %>%
          filter(r >=  input$slinputmulti[1] & r <= input$slinputmulti[2])
  })
})