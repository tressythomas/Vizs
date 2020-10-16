#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' in R Studio.
 

library(shiny)
library(ggplot2)
library(ggthemes)

# Define UI for application that draws a scatterplot
ui <- fluidPage(

    # Application title
    titlePanel("Oh, the iris again! Check correlation"),

    # Dropdown from which the variables can be selected 
    selectInput("variable1", "Select Variable1:",c("Sepal.Length","Sepal.Width","Petal.Length","Petal.Width","Species")),
    selectInput("variable2", "Select Variable1:",c("Sepal.Length","Sepal.Width","Petal.Length","Petal.Width","Species")),

        # Show a plot  
        mainPanel(
           plotOutput("scatterPlot")
        )
)
# Define server logic required to draw a scatterplot
server <- function(input, output) {

    output$scatterPlot <- renderPlot({
        # generate vars based on input$variable* from ui.R
        x    <- iris[,c(input$variable1)]
        y    <- iris[,c(input$variable2)]
        
        # draw the scatterplot  
        ggplot(iris, aes(x=x,y=y,color=iris$Species)) +
            labs(x=input$variable1,y=input$variable2,title = "Correlation plot")+
            theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                   panel.background = element_blank(), axis.line = element_line(colour = "black"))+
            geom_point(shape=1) +    # Use hollow circles
            geom_smooth()            # Add a loess smoothed fit curve with confidence region
        #> `geom_smooth()` using method = 'loess'
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
