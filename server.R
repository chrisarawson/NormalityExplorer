library(shiny)
library(fGarch)

shinyServer(
  function(input,output,session){
    
    values <- reactiveValues(i = 1212)
    
    observe({
      input$reRandom
      isolate({
        values$i <- values$i + 1
      })
    })
    
    output$myPlot<-renderPlot({
      
      set.seed(values$i)
      
      distType<-input$Distribution
      size<-input$sampleSize
      
      if(distType=="Normal"){
        randomVec<-rnorm(size,mean=as.numeric(input$mean),
                         sd=as.numeric(input$sd))
      }
      if(distType=="Skewed") {
        randomVec<-rsnorm(size,mean=as.numeric(input$mean),sd=as.numeric(input$sd),
                          xi=as.numeric(input$Skew))
      }
      
      if(distType=="Bi-modal") {
        mode1<-rnorm(size/2,as.numeric(input$meanMode1),as.numeric(input$sdMode1))
        mode2<-rnorm(size/2,as.numeric(input$meanMode2),as.numeric(input$sdMode2))
        randomVec<-append(mode1,mode2)
      }

      randomVecOrd<-sort(randomVec)
      par(mfrow=c(2,2))
      qqnorm(randomVec,col="steelblue")
      qqline(randomVec,col="red")
      hist(randomVec,col="steelblue",main="Frequency histogram",freq=FALSE)
      
      if(distType=="Normal"||distType=="Skewed") {
      lines(seq(min(randomVec)-10,max(randomVec)+10,length=1000),
            dsnorm(seq(min(randomVec)-10,max(randomVec)+10,length=1000),
                   mean=input$mean,sd=input$sd,xi=input$Skew),
            col="red",lwd=2)
      }
      
      plot(randomVecOrd,seq(1,size),main="Cumulative Frequency Distribution",col="steelblue")
    },height=600,width=800)
     
    output$shapiro<-renderText(function() {
      
      set.seed(values$i)
      
      distType<-input$Distribution
      size<-input$sampleSize
      
      if(distType=="Normal"){
        randomVec<-rnorm(size,mean=as.numeric(input$mean),
                         sd=as.numeric(input$sd))
      }
      if(distType=="Skewed") {
        randomVec<-rsnorm(size,mean=as.numeric(input$mean),sd=as.numeric(input$sd),
                          xi=as.numeric(input$Skew))
      }
      
      if(distType=="Bi-modal") {
        mode1<-rnorm(size/2,as.numeric(input$meanMode1),as.numeric(input$sdMode1))
        mode2<-rnorm(size/2,as.numeric(input$meanMode2),as.numeric(input$sdMode2))
        randomVec<-append(mode1,mode2)
      }
      sh.test<-shapiro.test(randomVec)
      paste("Shapiro test for normality: p = ", round(sh.test$p,4))
      })
       
  }
  )