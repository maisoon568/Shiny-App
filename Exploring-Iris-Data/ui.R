

library(shiny)
library(shinyWidgets)

shinyUI(pageWithSidebar(  
  titlePanel("Exploration of the Iris Data"), 
  sidebarPanel(  
    
    numericInput("x","Enter a value for the response variable:",value=5,min=0),
    
    checkboxGroupInput(
      "species",
      "Select the type of Species:",
      choices = levels(iris$Species),
      selected = levels(iris$Species)
      
    ),
    prettyRadioButtons(
      "yaxis","Select the y-axis:",
      choices=c("Sepal Length"="Sepal.Length","Sepal Width"="Sepal.Width","Petal Length"="Petal.Length","Petal Width"="Petal.Width"),
      selected="Petal.Length",
      animation=TRUE
    ),
    prettyRadioButtons(
      "xaxis","Select the x-axis:",
      choices=c("Sepal Length"="Sepal.Length","Sepal Width"="Sepal.Width","Petal Length"="Petal.Length","Petal Width"="Petal.Width"),
      selected="Sepal.Length",
      animation=TRUE
    )
  ), 
  
  mainPanel( 
    tabsetPanel( type="tabs",
                 tabPanel("Plots",textOutput("text"),textOutput("fity"),plotOutput("plot1"),plotOutput("plot2"),plotOutput("plot3"),plotOutput("plot4"),plotOutput("plot5"),textOutput("plots")),
                 tabPanel("Data Table",dataTableOutput("iris"),textOutput("data")),
                 tabPanel("Documentation",br(),textOutput("doc"))
    )
  )
))

