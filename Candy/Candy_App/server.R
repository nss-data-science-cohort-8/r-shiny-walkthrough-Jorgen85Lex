#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#


function(input, output, session) {
  
  filtered_candy <- reactive({
    plot_data <- candy
    
      if(input$Candy!= "All") {
        plot_data <- plot_data |> 
          filter(Candy_Type == input$Candy)
      }
      return(plot_data)
  })
  
  
  output$distPlot <- renderPlot({
    
    plot_data <- filtered_candy()
    
    plot_title <- if (input$Candy != "All") {
      paste("Distribution of", input$Candy, "Candy Bars")
    } else {
      "Distribution of Candy Bars"
    }
  #filter data based on type of candy
    if (input$Candy != "All") {
      plot_data <- plot_data |> 
        filter(Candy_Type == input$Candy)
    }
    
    plot_data <- plot_data |> 
      mutate(Street_Name = sub("^\\d+\\s+", "", Address))
    
    
    #filter data based on street
    if (input$Address != "All") {
      plot_data <- plot_data |> 
        filter(Street_Name == input$Address)
    }
    
    plot_grouped <- plot_data |> 
      group_by(Street_Name, Candy_Type) |> 
      summarize(Total_Candy_Number = sum(Candy_Number, na.rm = TRUE)) %>%
      ungroup()
    
    plot_grouped |> 
      ggplot(aes(x = Street_Name, y = Total_Candy_Number, fill = Candy_Type)) +
      geom_bar(stat = "identity", position = 'dodge') +
      labs(
        title = glue("Distribution on {ifelse(input$Address == 'All', 'All Streets', input$Address)}{ifelse(input$Candy != 'All', paste(' for', input$Candy), '')}"),
        x = "Street Name",
        y = "Number of Candy Bars",
        fill = "Candy Type") +
      theme(
      axis.text.x = element_text(angle = 45, hjust = 1)
    )
    })
}   
