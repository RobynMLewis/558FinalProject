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

#Information
#The Office (US) was a documentary style sitcom which ran for nine seasons from 2005-2013. This dashboard will
#allow you to explore the ups and downs of Dunder Mifflin through the IMDB ratings of each episode. 

#Data Exploration
#Can you figure out a map of Scranton, PA?
#set the gg environment so that x is selected by the drop down box
#Start with boxplot of ratings from each season, overlaid with scatter
g <- ggplot(officeData, aes(x=Season, y=Rating))

g1 <- g +
  geom_boxplot()+
  geom_jitter(aes(color=DirectedBy, text=paste0("Episode: ", Title)))+
  labs(title = "Rating of Episodes by Season")+
  theme(legend.position = "none")
ggplotly(g1)


#Numerical summary of episode ratings- UI can select season, director, writer (factors?)
officeSubset <- officeData %>% filter(Season == "2")
kable(sapply(select(officeSubset, Rating), summary), digits=1, caption = paste0("Summary of Episode Ratings for Season ", "2"))

#Density of ratings
g2 <- ggplot(officeData, aes(x=Rating))+
  geom_histogram(color="dark blue", fill="light blue")+
  labs(title = "Distribution of Episode Ratings")+
  theme_minimal()
ggplotly(g2)


#split writers up, use something like select(data, writer="x" or writer2="x" or writer3="x")
#Drop down box to select "Summarize by:", choices are season, director, maybe writer
#Conditional box to futher summarize by something else?
#Use plotly to allow user to click on plot
#User needs to be able to save plot


#Clustering-
#Dendogram of data
#Drop down boxes to select method, number of nodes

#Modeling
#subset into test/train
set.seed(1725)
train <- sample(1:nrow(officeData), size=nrow(officeData)*0.8)
test <- setdiff(1:nrow(officeData), train)

officeTrain <- officeData[train,]
officeTest <- officeData[test,]

#random forest-
#mtry and ntree set by UI
rf.office <- randomForest(formula=Rating ~.-Title, data=officeTrain, mtry=4, ntree=10)
yhat.rf <- predict(rf.office, newdata=officeTest)
office.test <- officeTest[,"Rating"]
mse <- mean((yhat.rf-office.test)^2)

#Two supervised learning methods
linearFit <- lm(Rating~.-Title, data=officeTrain)
predict(linearFit, newdata = officeTest)
#checkboxes for UI to select variables used
  #conditional panel for each to select value of variable

#Data Viewing
#User can scroll through, subset, and save data