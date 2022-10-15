library(shiny)
library(readr)
library(dplyr)
library(DT)
library(readxl)
tabla_genome_tags <- read_csv("genome-tags.csv")
tabla_rating <- read_csv('ratings.csv')

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Analisis de películas"),
  
  tabsetPanel(
    tabPanel('Rango de ratings',
             sliderInput('slinputmulti','Seleccione Rango:',
                         value = c(0,5), 
                         min = 0, 
                         max = 5, 
                         step = 0.5),
             mainPanel(
               h3("Peliculas"),
               tableOutput('out_slider_input_multi')
               
             )
    ),
    tabPanel('Tags',
             selectInput('select_tags', 'Seleccione categorias de peliculas',
                         choices = tabla_genome_tags$tag, selected = '007', multiple = TRUE),
             mainPanel(
               h3("Peliculas y su relevancia segun las tags"),
               tableOutput('out_select_input_multi')
               
             )
    ),
    tabPanel('Usuario',
             sidebarLayout(
               sidebarPanel(
                 #tabla
                 selectInput('select_user', 'Seleccione el usuario para analizar',
                            choices = unique(tabla_rating$userId), selected = '1', multiple = FALSE),
                 textInput("url_param","Marcador: ",value = ""),
                 h3("Genero y su calificacion promedio del usuario"),
                 tableOutput('out_select_user_1')
               ),
               mainPanel(
                 plotOutput('out_select_user_2')
               )
             )
      
    )
    
    
  )
  
))
