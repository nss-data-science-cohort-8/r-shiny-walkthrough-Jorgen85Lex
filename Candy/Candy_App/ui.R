#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#


# Define UI for application that draws a histogram
fluidPage(

    # Application title
    titlePanel("Candy Types on Street"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput("Candy",
                        label = ("Select a Candy Bar"),
                        choices = c("All", sort(unique(candy$Candy_Type))),
                        selected = "All"),
            selectInput("Address",
                        label = "Select a Street Name",
                        choices = c("All", sort(unique(sub("^\\d+\\s+", "", candy$Address)))),  # Remove house number and list unique street names
                        selected = "All")
        ),

    

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("distPlot")
        )
    )
)

