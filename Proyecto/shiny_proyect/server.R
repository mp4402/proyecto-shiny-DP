library(shiny)
library(readr)
library(dplyr)
library(DT)
library(readxl)
tabla_rating <- read_csv('ratings.csv')
tabla_movies <- readxl::read_excel('movies.xlsm')
tabla_genome_scores <- read_csv("genome-scores.csv")
tabla_genome_tags <- read_csv("genome-tags.csv")
shinyServer(function(input, output) {
  
  
  output$out_slider_input_multi<- renderTable({
    #browser()
    tabla_rating %>%
          select(movieId, rating) %>%
          group_by(movieId) %>%
          summarize(rating = mean(rating)) %>%
          filter(rating >=  input$slinputmulti[1] & rating <= input$slinputmulti[2])%>%
          left_join(tabla_movies, by = c("movieId" = "movieId")) %>%
          arrange(desc(rating))
  })
  
  output$out_select_input_multi<- renderTable({
    #browser()
    #tabla_genome_tags junto tabla_genome_scores para unir por tag y movieId
    tabla_genome_tags %>%
      filter(tabla_genome_tags$tag %in% input$select_tags) %>%
      left_join(tabla_genome_scores, by = c("tagId" = "tagId")) %>%
      left_join(tabla_movies, by = c("movieId" = "movieId")) %>%
      select(title,relevance, tag) %>%
      filter(relevance >= 0.30) %>%
      arrange(desc(relevance))
    
  })
})