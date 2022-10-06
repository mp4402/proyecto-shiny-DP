
library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("UI dinamico, UpdateInput"),
  
  tabsetPanel(
    tabPanel('Rango de ratings movies',
             sliderInput('slinputmulti','Seleccione Rango:',
                         value = c(0,5), 
                         min = 0, 
                         max = 5, 
                         step = 0.5)
    ),
    mainPanel(
      h1("Outputs"),
      h3('Slider Input Multiple'),
      tableOutput('out_slider_input_multi')
      
    )
  )
  
))
