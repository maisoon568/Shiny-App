
library(shiny)
library(shinyWidgets)
library(ggplot2)

shinyServer(function(input, output) {
  
  model<- reactive({
    lm(as.formula(paste(input$yaxis," ~ ",paste(input$xaxis,collapse="+"))),data=iris[iris$Species==input$species,])
  })
  
  output$plot1 <- renderPlot({
    
    plot=ggplot(iris[iris$Species==input$species,],aes_string(x=input$xaxis,y=input$yaxis))+geom_point(aes(color=Species))+geom_smooth(method=lm)
    
    output$text=renderText(paste("The equation of the simple linear model is: Y=",
                                 round(model()$coefficients[1],3)," + ",round(model()$coefficients[2],3),"X"
    ))
    
    print(plot)
  }, height=375,res=105)
  
  output$plot2<-renderPlot({
    ggplot(iris[iris$Species==input$species,],aes(Sepal.Length))+geom_boxplot(aes(fill=Species))
  }, height = 350, width =700, res = 105
  )
  
  output$plot3<-renderPlot({
    ggplot(iris[iris$Species==input$species,],aes(Sepal.Width))+geom_boxplot(aes(fill=Species))
  }, height = 350, width =700, res = 105
  )
  
  output$plot4<-renderPlot({
    ggplot(iris[iris$Species==input$species,],aes(Petal.Length))+geom_boxplot(aes(fill=Species))
  }, height = 350, width =700, res = 105
  )
  
  output$plot5<-renderPlot({
    ggplot(iris[iris$Species==input$species,],aes(Petal.Width))+geom_boxplot(aes(fill=Species))
  }, height = 350, width =700, res = 105
  )
  
  output$iris=renderDataTable({data.frame(iris[iris$Species==input$species,c(input$yaxis,input$xaxis)],
                                          Fitted.Values=round(fitted(model()),4),Errors=round(resid(model()),4))})
  
  output$doc=renderText(paste("This application helps us explore the Iris data in R by managing the predictor and the response variables and the types of species selected. It also calculates the coefficients and gives the equation of the regression line and the fitted values and the errors for each observation. It also plots the regression line. It provides also boxplots of the sepal length, sepal width, petal length, petal width with respect to the types of species selected."))
})

