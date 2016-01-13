shinyUI(
  pageWithSidebar(
    headerPanel("QQ Norm Plot Explorer"),
    
    sidebarPanel(width = 4,
      selectInput("Distribution", 
                  "Select Distribution Type",
                  choices=c("Normal","Skewed",
                            "Bi-modal")),
      sliderInput("sampleSize", "Select Sample Size",
                  min=4,max=500,value=30,step=2),
      conditionalPanel(condition="input.Distribution=='Normal'",
                       sliderInput("mean","Please Select the Mean",
                                   min=-100,max=100,value=0,step=1),
                       sliderInput("sd","Please Select Standard Deviation",
                                   min=0,max=200,value=1,step=1)),
      conditionalPanel(condition="input.Distribution == 'Skewed'",
                       sliderInput("mean","Please Select the Mean",
                                   min=-100,max=100,value=0,step=1),
                       sliderInput("sd","Please Select Standard Deviation",
                                   min=0,max=200,value=1,step=1),
                       sliderInput("Skew","Skewness",
                                   min=0.01,max=2,value=1,step=0.01)),
      conditionalPanel(condition="input.Distribution=='Bi-modal'",
                       sliderInput("meanMode1","Mean of Lower Mode",
                                   min=1,max=50,value=40,step=1),
                       sliderInput("sdMode1","Std Deviation of Lower Mode",
                                   min=0.5,max=500,value=30,step=0.5),
                       sliderInput("meanMode2","Mean of Upper Mode",
                                   min=50,max=500,value=140,step=1),
                       sliderInput("sdMode2","Std Deviation of Upper Mode",
                                   min=0.5,max=500,value=30,step=0.5)),
      verbatimTextOutput("shapiro"),
      actionButton("reRandom","Click for another random set of data")
    ),
    
    mainPanel(
      plotOutput("myPlot")
      )
  )
)