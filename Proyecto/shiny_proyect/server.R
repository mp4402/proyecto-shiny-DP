library(shiny)
library(readr)
library(dplyr)
library(DT)
library(readxl)

shinyServer(function(input, output) {
  
  tabla_rating <- read_csv('ratings.csv')
  tabla_movies <- readxl::read_excel('movies.xlsm')
  tabla_genome_scores <- read_csv("genome-scores.csv")
  tabla_genome_tags <- read_csv("genome-tags.csv")
  
  
  output$out_slider_input_multi<- renderTable({
    #browser()
    tabla_rating %>%
          select(movieId, rating) %>%
          group_by(movieId) %>%
          summarize(r = mean(rating)) %>%
          filter(r >=  input$slinputmulti[1] & r <= input$slinputmulti[2])
  })
})