#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
install.packages("shinydashboard", "tidyverse", "knitr", "ggplot2", "plotly", "dplyr")

library(shiny)
library(shinydashboard)

#setup some initial information
writers <- c("Jennifer Celotta", "Daniel Chun", "Greg Daniels", "Brent Forrester", "Charlie Grandy", "Mindy Kaling",
             "Paul Lieberstein", "B.J. Novak", "Michael Schur", "Justin Spitzer", "ALL")
directors <- c("Jeffrey Blitz", "Greg Daniels", "Randall Einhorn", "Paul Feig", "Ken Kwapis", "Paul Lieberstein", 
               "Charles McDougall", "David Rogers", "Matt Sohn", "Ken Whittingham", "ALL")
choices <- c("Season", "Director", "Writer")

# Define UI for application that draws a histogram
shinyUI(fluidPage(
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
                #text that introduces the data, map of Scranton if you can
                        ),
                tabItem(tabName = "dataExp",
                #text: The new Vice President needs a rundown! This shouldn't take all day, and when you're done you'll
                #need to fax it to everyone on your distribution list.
                #selectInput(analysis, "What's a Rundown?", c("Boxplot Analysis", "Numerical Summary", "Distribution"))
                    #conditional panel
                        #if analysis=="Boxplot Analysis"
                            #radioButtons(filter, "Box Plot of What?", choices=choices)
                                #conditional panel
                                    #if filter == "Season"
                                        #numericInput(season, "Which Season?", min=1, max=9, step=1)
                                            #conditional panel
                                                #submitButton("Is This a Rundown?")
                                    #if filter == "Director"
                                        #selectInput(directors, "Which Director?", choices=directors)
                                            #conditional panel
                                                #submitButton("Is This a Rundown?")
                                    #if filter == "Writer"
                                        #selectInput(writers, "Which Writer?", choices=writers)
                                            #conditional panel
                                                #submitButton("Is This a Rundown?)
                
                                    #submitButton("Fax to the Distribution List")
                        #if analysis == "Numerical Summary"
                            #radioButtons(filter, "Summary of What?", choices=choices)
                                #conditional panel
                                    #if filter == "Season"
                                        #numericInput(season, "Which Season?", min=1, max=9, step=1)
                                            #conditional panel
                                                #submitButton("Is This a Rundown?")
                                    #if filter == "Director"
                                        #selectInput(directors, "Which Director?", choices=directors)
                                            #conditional panel
                                                #submitButton("Is This a Rundown?")
                                    #if filter == "Writer"
                                        #selectInput(writers, "Which Writer?", choices=writers)
                                            #conditional panel
                                                #submitButton("Is This a Rundown?")
                
                                    #submitButton("Fax to the Distribution List")
                        #if analysis == "Distribution"
                            #radioButtons(filter, "Distribution of What?", choices=choices)
                                #conditional panel
                                    #if filter == "Season"
                                        #numericInput(season, "Which Season?", min=1, max=9, step=1)
                                            #conditional panel
                                                #submitButton("Is This a Rundown?")
                                    #if filter == "Director"
                                        #selectInput(directors, "Which Director?", choices=directors)
                                            #conditional panel
                                                #submitButton("Is This a Rundown?")
                                    #if filter == "Writer"
                                        #selectInput(writers, "Which Writer?", choices=writers)
                                            #conditional panel
                                                #submitButton("Is This a Rundown?")
                
                                    #submitButton("Fax to the Distribution List")
                        ),
                tabItem(tabName = "analysis",
                        ),
                tabItem(tabName = "models",
                        ),
                tabItem(tabName = "data",
                        )
            )
            
        )
    )

))
