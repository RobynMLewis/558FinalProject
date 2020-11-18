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
officeCopy <- officeData[,-c(2)]

allDirectors <- unique(officeCopy$DirectedBy)
topDirectors <- c("Jeffrey Blitz", "Greg Daniels", "Randall Einhorn", "Paul Feig", "Ken Kwapis", "Paul Lieberstein", "Charles McDougall", "David Rogers", "Matt Sohn", "Ken Whittingham")


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


set.seed(1725)
train <- sample(1:nrow(officeData), size=nrow(officeData)*0.8)
test <- setdiff(1:nrow(officeData), train)

officeTrain <- officeCopy[train,]
officeTest <- officeCopy[test,]


#random forest-
#mtry and ntree set by UI
rf.office <- randomForest(formula=Rating ~., data=officeTrain, mtry=4, ntree=10)
yhat.rf <- predict(rf.office, newdata=officeTest)
office.test <- officeTest[,"Rating"]
mse <- mean((yhat.rf-office.test)^2)

#Two supervised learning methods
linearFit <- lm(Rating~., data=officeTrain)
predict(linearFit, newdata = officeTest)
#checkboxes for UI to select variables used
  #conditional panel for each to select value of variable

#Data Viewing
#User can scroll through, subset, and save data