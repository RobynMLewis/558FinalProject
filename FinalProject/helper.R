#Import OfficeIMBD dataset
fullOffice <- read.csv("../Data/TheOfficeIMDBPerEpisode.csv")

#Select variables for analysis
officeData <- fullOffice[, -c(2,3,6)]

#Information

#Data Exploration
#Numerical summary of episode ratings- UI can select season, director
#Drop down box to select "Summarize by:", choices are season, director, maybe writer
#Conditional box to futher summarize by something else?
#Use plotly to allow user to click on plot
#User needs to be able to save plot


#Clustering-
#Dendogram of data
#Drop down boxes to select method, number of nodes

#Modeling
#Two supervised learning methods

#checkboxes for UI to select variables used
  #conditional panel for each to select value of variable
#dropdown box for number of trees (if using)
#submit button to perform modeling, output predicted rating

#Data Viewing
#User can scroll through, subset, and save data