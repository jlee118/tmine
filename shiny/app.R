#This is the shiny visualization app
#Run with runApp("shiny")

library(shiny)
ui <- fluidPage(
  titlePanel("tmine"),
  sidebarLayout(position = "left",
     sidebarPanel(
       textInput(inputId = "search_terms", "Search Papers","Search Terms"),
       numericInput(inputId = "identifier","Search ID from Results","ids", min = 0, max = 20),
       sliderInput(inputId = "words",
                   label= "Number of words",
                   min=1,
                   max=25,
                   value=1)
     ),

     mainPanel(
       fluidRow(column(width = 12,DT::dataTableOutput("titles"))),
       plotOutput("graph")
     )))

server <- function(input,output) {
  data <- reactive({data<- get_pubmed_abstracts(input$search_terms)})
  data2 <- reactive({data2 <- append_tfidf(data())})
  output$titles <- DT::renderDataTable({data()[,c(13,3)]}, options = list(scrollY = '150px', paging = FALSE))
  output$graph <- renderPlot({plot_word_score(data2()$tf_idf[input$identifier][[1]], topn = input$words, data2()$title[input$identifier])})

}
shinyApp(ui = ui, server = server)

#[END]
