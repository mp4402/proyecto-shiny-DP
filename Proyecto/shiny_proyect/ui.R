library(shiny)
library(readr)
library(dplyr)
library(DT)
library(readxl)
tabla_genome_tags <- read_csv("genome-tags.csv")

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
                 
               ),
               sidebarPanel()
             )
      
    )
    
    
  )
  
))
