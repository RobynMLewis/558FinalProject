#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
install.packages("shinydashboard", "tidyverse", "knitr", "ggplot2", "plotly", "dplyr", "DT", "randomForest", "ape", "ggdendro")

library(shiny)
library(shinydashboard)

#setup some initial information
writers <- c("Jennifer Celotta", "Daniel Chun", "Greg Daniels", "Brent Forrester", "Charlie Grandy", "Mindy Kaling",
             "Paul Lieberstein", "B.J. Novak", "Michael Schur", "Justin Spitzer")
directors <- c("Jeffrey Blitz", "Greg Daniels", "Randall Einhorn", "Paul Feig", "Ken Kwapis", "Paul Lieberstein", 
               "Charles McDougall", "David Rogers", "Matt Sohn", "Ken Whittingham")
choices <- c("Season", "Director", "Writer")

# Define UI for application
shinyUI(fluidPage(
    withMathJax(),
    dashboardPage(
        dashboardHeader(title="The Office IMDB Ratings"),
        #Set up side bar menu
        dashboardSidebar(
            sidebarMenu(
                menuItem("Welcome to Scranton", tabName = "dashboard", icon = icon("dashboard")),
                menuItem("Let's Get a Run Down", tabName = "dataExp", icon = icon("th")),
                menuItem("Analysis", tabName = "analysis", icon=icon("th")),
                menuItem("Chair Models", tabName = "models", icon = icon("th")),
                menuItem("This is the Data.", tabName = "data", icon = icon("th"))
            )
        ),
        #Body of app
        dashboardBody(
            tabItems(
                #Info
                tabItem(tabName = "dashboard",
                    h2("The Office IMBD Ratings"),
                    p(em("The Office"), ("was a popular documentary style sitcom which ran for nine seasons
                      from 2005-2013. This dashboard will allow you to explore the ups and downs of Dunder 
                      Mifflin through the"), a(href='https://www.imdb.com/title/tt0386676/', 'IMBD'), ("ratings of 
                      each episode based on season, director, and writer"),
                    p(("As you click through the tabs on the left you'll be able to view episode ratings and 
                    predict a rating for an episode with attributes you choose. Choices have been limited to 
                    the ten writers and directors with the most credits. Data was sourced from "), 
                      a(href='https://www.kaggle.com/kapastor/the-office-imdb-ratings-per-episode', 'Kaggle.'))
                        ),
                tabItem(tabName = "dataExp",
                 h4("The new Vice President needs a rundown! This shouldn't take all day, and when you're done you'll
                    need to fax it to everyone on your distribution list."),
                 fluidRow(
                     #Controls for data exploration on the left- Type of Analysis, filters for each
                     box(
                        selectInput("analysis", "What's a Rundown?", c("Boxplot Analysis", "Numerical Summary", "Distribution")),
                        #Show this panel for boxplot- select filter    
                        conditionalPanel(
                            condition = "input.analysis=='Boxplot Analysis'",
                                radioButtons(filter, "Box Plot of What?", choices=choices),
                                    #Show this panel to select Season
                                    conditionalPanel(
                                        condition = "input.filter == 'Season'",
                                        numericInput(season, "Which Season?", min=1, max=9, step=1),
                                        submitButton("Is This a Rundown?")
                                    ),
                                    #Show this panel to select Director
                                    conditionalPanel(
                                        condition = "input.filter == 'Director'",
                                        selectInput(directors, "Which Director?", choices=directors),
                                        submitButton("Is This a Rundown?")
                                    ),
                                    #Show this panel to select Writer
                                    conditionalPanel(
                                        condition = "input.filter == 'Writer'",
                                        selectInput(writers, "Which Writer?", choices=writers),
                                        submitButton("Is This a Rundown?")
                                    )
                        ),
                        #Show this panel for Numerical Summary- select filters
                        conditionalPanel(
                            condition = "input.analysis == 'Numerical Summary'",
                                radioButtons(filter, "Summary of What?", choices=choices),
                                    conditionalPanel(
                                        condition = "input.filter == 'Season'",
                                        numericInput(season, "Which Season?", min=1, max=9, step=1),
                                        submitButton("Is This a Rundown?")
                                    ),
                                    conditionalPanel(
                                        condition = "input.filter == 'Director'",
                                        selectInput(directors, "Which Director?", choices=directors),
                                        submitButton("Is This a Rundown?")
                                    ),
                                    conditionalPanel(
                                        condition = "input.filter == 'Writer'",
                                        selectInput(writers, "Which Writer?", choices=writers),
                                        submitButton("Is This a Rundown?")
                                    )
                        ),
                        #Show this panel for Distribution- select filters
                        conditionalPanel(
                            condition = "input.analysis == 'Distribution'",
                                radioButtons(filter, "Distribution of What?", choices=choices),
                                    conditionalPanel(
                                        condition = "input.filter == 'Season'",
                                        numericInput(season, "Which Season?", min=1, max=9, step=1),
                                        submitButton("Is This a Rundown?")
                                    ),
                                    conditionalPanel(
                                        condition = "input.filter == 'Director'",
                                        selectInput(directors, "Which Director?", choices=directors),
                                        submitButton("Is This a Rundown?")
                                    ),
                                    conditionalPanel(
                                        condition = "input.filter == 'Writer'",
                                        selectInput(writers, "Which Writer?", choices=writers),
                                        submitButton("Is This a Rundown?")
                                    )
                        )
                                    
                     ),
                     #Output on right
                     box(
                         plotOutput("rundown"),
                         br(),
                         downloadButton("downloadPlot", "Fax to the Distribution List")
                     )
                 )
                        ),
                tabItem(tabName = "analysis",
                        
                        ),
                tabItem(tabName = "models",
                        #text: Unfortunately the chair model, Deborah Shoshlefski, crashed her car into an airplane
                        #hangar. So we'll have to look at some statistical models instead.
                        #selectInput(model, "Pick a model", choices=c("Random Forest", "Linear Regression"))
                            #conditional panel(
                                #condition = "input.model == 'Random Forest'"
                                    #text:  Michael didn't get invited on Ryan's wilderness retreat and wants to 
                                    #prove himself. He's going to go deep into a random forest with nothing but 
                                    #a pocket knife and some duct tape. Let's do some analysis to help him out!
                                    #numericInput(nodes, "How many items (nodes) should Michael use?", min=1, max=4, step=1)
                                    #sliderInput(trees, "How many trees?", min=1, max=25)
                                    #submitButton("Into the Wilderness!") 
                            #)
                            #conditional panel(
                                #condition = "input.model == 'Linear Regression'"
                                #text: something clever
                                #checkboxGroupInput(vars, "Which Variables to Include?", choices=c("Season", "Vote Count", "Director", "Writer"))
                            #)
                        ),
                tabItem(tabName = "data",
                        #text: This is the data. It is a statement of fact.
                        
                        #downloadButton("downloadData", "I Declare Download!")
                        )
            )
            
        )
    )

))
