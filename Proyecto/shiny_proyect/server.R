library(shiny)
library(readr)
library(dplyr)
library(DT)
library(readxl)
library(ggplot2)

tabla_rating <- read_csv('ratings.csv')
tabla_movies <- readxl::read_excel('movies.xlsm')
tabla_genome_scores <- read_csv("genome-scores.csv")
tabla_genome_tags <- read_csv("genome-tags.csv")
shinyServer(function(input, output, session) {
  
  
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
  
  output$out_select_user_1 <- renderTable({
    tabla_rating %>%
      filter(userId == input$select_user[1]) %>%
      left_join(tabla_movies, by = c("movieId" = "movieId")) %>%
      group_by(genres) %>%
      summarise(rating = mean(rating)) %>%
      select(genres, rating)
  })
  
  observe({
    query <- parseQueryString(session$clientData$url_search)
    userId <- query[["userId"]]
    if(!is.null(userId)){
      updateSelectInput(session, "select_user", selected=userId)
    }


  })

  
  observe({
    
    userId<-input$select_user
    
    if(session$clientData$url_port==''){
      x <- NULL
    } else {
      x <- paste0(":",
                  session$clientData$url_port)
    }
    
    marcador<-paste0("http://",
                     session$clientData$url_hostname,
                     x,
                     session$clientData$url_pathname,
                     "?","userId=",
                     userId)
    updateTextInput(session,"url_param",value = marcador)
    
  })
  
  output$out_select_user_2 <- renderPlot({
    tabla_rating %>%
      filter(userId == input$select_user[1]) %>%
      group_by(rating) %>%
      summarise(cantidad = n())%>%
      ggplot(aes(x = rating, y = cantidad)) + 
      geom_col(fill = 'royalblue4') +
      scale_x_continuous(labels = scales::label_number()) +
      labs(title = element_text("")) +
      ylab("Quantity")
    
  })
  
  
})