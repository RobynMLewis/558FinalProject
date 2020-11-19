#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
runGitHub("558FinalProject", "RobynMLewis")

#Import data and setup
#Import OfficeIMBD dataset
fullOffice <- read.csv("./Data/TheOfficeIMDBPerEpisode.csv")

#Select variables for analysis- removing description and air date as each are unique values, keeping Title
#for plotting purposes
officeData <- fullOffice[, -c(3,6)]
officeData$Season <- as.factor(officeData$Season)
#There have been many writers and directors, to simplify analysis we'll only offer options for the top ten
unique(officeData$DirectedBy)
table(officeData$DirectedBy)
table(officeData$WrittenBy)
officeData$DirectedBy <- as.factor(officeData$DirectedBy)
officeData$WrittenBy <- as.factor(officeData$WrittenBy)

officeCopy <- officeData[]

allDirectors <- unique(officeCopy$DirectedBy)
topDirectors <- c("Jeffrey Blitz", "Greg Daniels", "Randall Einhorn", "Paul Feig", "Ken Kwapis", 
                  "Paul Lieberstein", "Charles McDougall", "David Rogers", "Matt Sohn", "Ken Whittingham")

for(i in 1:nrow(officeCopy)){
    if(officeCopy$DirectedBy[i] == "Jeffrey Blitz"){
        officeCopy$DirectedBy[i] <- "Jeffrey Blitz"}
    else if(officeCopy$DirectedBy[i] == "Greg Daniels"){
        officeCopy$DirectedBy[i] <- "Greg Daniels"}
    else if(officeCopy$DirectedBy[i] == "Randall Einhorn"){
        officeCopy$DirectedBy[i] <- "Randall Einhorn"}
    else if(officeCopy$DirectedBy[i] == "Paul Feig"){
        officeCopy$DirectedBy[i] <- "Paul Feig"}
    else if(officeCopy$DirectedBy[i] == "Ken Kwapis"){
        officeCopy$DirectedBy[i] <- "Ken Kwapis"}
    else if(officeCopy$DirectedBy[i] == "Paul Lieberstein"){
        officeCopy$DirectedBy[i] <- "Paul Lieberstein"}
    else if(officeCopy$DirectedBy[i] == "Charles McDougall"){
        officeCopy$DirectedBy[i] <- "Charles McDougall"}
    else if(officeCopy$DirectedBy[i] == "David Rogers"){
        officeCopy$DirectedBy[i] <- "David Rogers"}
    else if(officeCopy$DirectedBy[i] == "Matt Sohn"){
        officeCopy$DirectedBy[i] <- "Matt Sohn"}
    else if(officeCopy$DirectedBy[i] == "Ken Whittingham"){
        officeCopy$DirectedBy[i] <- "Ken Whittingham"}
    else{officeCopy$DirectedBy[i] <- "Other"}
}

topWriters <- c("Jennifer Celotta", "Daniel Chun", "Greg Daniels", "Brent Forrester", "Charlie Grandy", "Mindy Kaling",
                "Paul Lieberstein", "B.J. Novak", "Michael Schur", "Justin Spitzer")

for(i in 1:nrow(officeCopy)){
    if(officeCopy$WrittenBy[i] == "Jennifer Celotta"){
        officeCopy$WrittenBy[i] <- "Jennifer Celotta"}
    else if(officeCopy$WrittenBy[i] == "Daniel Chun"){
        officeCopy$WrittenBy[i] <- "Daniel Chun"}
    else if(officeCopy$WrittenBy[i] == "Greg Daniels"){
        officeCopy$WrittenBy[i] <- "Greg Daniels"}
    else if(officeCopy$WrittenBy[i] == "Brent Forrester"){
        officeCopy$WrittenBy[i] <- "Brent Forrester"}
    else if(officeCopy$WrittenBy[i] == "Charlie Grandy"){
        officeCopy$WrittenBy[i] <- "Charlie Grandy"}
    else if(officeCopy$WrittenBy[i] == "Mindy Kaling"){
        officeCopy$WrittenBy[i] <- "Mindy Kaling"}
    else if(officeCopy$WrittenBy[i] == "Paul Lieberstein"){
        officeCopy$WrittenBy[i] <- "Paul Lieberstein"}
    else if(officeCopy$WrittenBy[i] == "B.J. Novak"){
        officeCopy$WrittenBy[i] <- "B.J. Novak"}
    else if(officeCopy$WrittenBy[i] == "Michael Schur"){
        officeCopy$WrittenBy[i] <- "Michael Schur"}
    else if(officeCopy$WrittenBy[i] == "Justin Spitzer"){
        officeCopy$WrittenBy[i] <- "Justin Spitzer"}
    else{officeCopy$WrittenBy[i] <- "Other"}
}

officeCopy$DirectedBy <- as.factor(officeCopy$DirectedBy)
officeCopy$WrittenBy <- as.factor(officeCopy$WrittenBy)

#Split data into test/train for use later
set.seed(1725)
train <- sample(1:nrow(officeData), size=nrow(officeData)*0.8)
test <- setdiff(1:nrow(officeData), train)

officeTrain <- officeCopy[train,]
officeTest <- officeCopy[test,]


# Define server logic
shinyServer(function(input, output, session){
    
    #Create plots for rundown options
    output$rundown <- renderPlot({
        #variables from UI input
        type <- input$analysis
        
        subsetFilter <- input$filter
            if(subsetFilter == "Season"){
                x <- "Season"
            }
            else if(subsetFilter == "Writer"){
                x <- "Written By"
            }
            else if(subsetFilter == "Director"){
                x <- "Directed By"
            }
        #Create boxplots
        if(type == "Boxplot"){
            #Boxplot by Season
            if(subsetFilter == "Season"){
            g1 <- ggplot(officeData, aes(x=Season, y=Rating))+
                geom_boxplot()+
                geom_jitter(aes(color=DirectedBy, text=paste0("Episode: ", Title)))+
                labs(title = "Rating of Episodes by Season")+
                theme(legend.position = "none")
            ggplotly(g1)
            }
            #Boxplot by Writer
            else if(subsetFilter == "Writer"){
            g5 <- ggplot(filter(officeCopy, WrittenBy != "Other"), aes(x=WrittenBy, y=Rating))+
                geom_boxplot()+
                geom_jitter(aes(color=Season, text=paste0("Episode: ", Title)))+
                labs(title = "Rating of Episodes by Writer", x="Writer")+                    
                theme(legend.position = "none", axis.text.x=element_text(angle=45))
            ggplotly(g5)
            }
            #Boxplot by Director
            else if(subsetFilter == "Director"){
            g4 <- ggplot(filter(officeCopy, DirectedBy != "Other"), aes(x=DirectedBy, y=Rating))+
                geom_boxplot()+
                geom_jitter(aes(color=Season, text=paste0("Episode: ", Title)))+
                labs(title = "Rating of Episodes by Director", x="Director")+
                theme(legend.position = "none", axis.text.x=element_text(angle=45))
            ggplotly(g4)  
            }
        #Numerical Summaries
        else if(type == "Numerical Summary"){
            #By Season
            if(subsetFilter == "Season"){
            z <- input$season
            officeSubset <- officeData %>% filter(Season == z)
            kable(sapply(select(officeSubset, Rating), summary), digits=1, caption = paste0("Summary of Episode Ratings, ", x, " ", z))
        }
            #By Director
            else if(subsetFilter == "Director"){
            z <- input$directors
            officeSubset <- officeData %>% filter(DirectedBy == z)
            kable(sapply(select(officeSubset, Rating), summary), digits=1, caption = paste0("Summary of Episode Ratings, ", x, " ", z))
            }
            #By Writer
            else if(SubsetFilter == "Writer"){
            z <- input$writers
            officeSubset <- officeData %>% filter(WrittenBy == z)
            kable(sapply(select(officeSubset, Rating), summary), digits=1, caption = paste0("Summary of Episode Ratings, ", x, " ", z))
            }
        }
        #Distributions
        else if(type == "Distribution"){
            #By Writer
            if(subsetFilter == "Writer"){
            z <- input$writers1
            g2 <- ggplot(filter(officeCopy, WrittenBy == z), aes(x=Rating))+
                geom_histogram(aes(fill=Season), binwidth = .125)+
                labs(title = paste0("Distribution of Episode Ratings: ", x, " ", z))+
                theme_minimal()
            ggplotly(g2)
            }
            #By Director
            else if(subsetFilter == "Director"){
            z <- input$directors1
            g2 <- ggplot(filter(officeCopy, DirectedBy == z), aes(x=Rating))+
                geom_histogram(aes(fill=Season), binwidth = .125)+
                labs(title = paste0("Distribution of Episode Ratings: ", x, " ", z))+
                theme_minimal()
            ggplotly(g2)
            }
            #By Season
            else if(subsetFilter == "Season"){
            z <- input$season1
                if(z == "ALL"){
                g2 <- ggplot(officeData, aes(x=Rating))+
                    geom_histogram(color="dark blue", fill="light blue", binwidth = .125)+
                    labs(title = paste0("Distribution of Episode Ratings"))+
                    theme_minimal()
                ggplotly(g2)
                }
                else{
                g2 <- ggplot(filter(officeData, Season == z), aes(x=Rating))+
                    geom_histogram(color="dark blue", fill="light blue", binwidth = .125)+
                    labs(title = paste0("Distribution of Episode Ratings: ", x, " ", z))+
                    theme_minimal()
                ggplotly(g2)
                }
            }
        }
        }
}) #end of rundown output
    #download button for plots
    output$downloadPlot <- downloadHandler(
        filename = "rundown.png",
        content = output$rundown, 
        contentType = "image/png"
    )
    #cluster analysis
    output$cluster <- renderPlot({
        x <- input$clustering
        y <- tolower(x)
        
        hc=hclust(dist(officeCopy), method = y)
        plot(hc, main=paste0(x, " Linkage"), labels = officeCopy$Title, xlab = "", cex=.5)
    })# end of cluster
    #create models
    output$model <- renderPrint({
        model <- input$model
        if(model == "Random Forest"){
            rf.office <- randomForest(formula=Rating ~., data=officeTrain, mtry=4, ntree=10)
            yhat.rf <- predict(rf.office, newdata=officeTest)
            office.test <- officeTest[,"Rating"]
            mse <- mean((yhat.rf-office.test)^2)
        }
        else if (model == "Linear Regression"){
            linearFit <- lm(Rating~., data=officeTrain)
            predict(linearFit, newdata = officeTest)
        }
        
    })# end of models
    #view/subset data
    output$data <- DT::renderDataTable({
        x <- input$subset
        
        if(x == "Season"){
            y <- input$season2
            subsetData <- officeData %>% filter(Season == y)
            datatable(subsetData)
        }
        else if(x == "Writer"){
            y <- input$writer2
            subsetData <- officeData %>% filter(WrittenBy == y)
        }
        else if(x == "Director"){
            y <- input$director2
            subsetData <- officeData %>% filter(DirectedBy == y)
        }
    output$downloadData <- downloadHandler(
        filename = "OfficeData.csv",
        content = write.csv(subsetData)
    )
        
    })
}) #end of server function
