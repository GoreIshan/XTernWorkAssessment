
# Get the restaurant data
data <- read.csv("Downloads/XTernData.csv")

getRatingPerCost <- function(dataFrame = data, filterLowVotes = FALSE, minVotes = 0){
  
  # copy it to cleanedData to safely manipulate it
  cleanedData <- dataFrame
  
  # get rid of the $ in Average_Cost
  cleanedData$Average_Cost <- substr(cleanedData$Average_Cost, 2, length(cleanedData$Average_Cost) - 1)
  # get rid of the rows with non-numeric ratings
  cleanedData <- cleanedData %>% filter(!is.na(as.numeric(cleanedData$Rating)))
  
  # add RatingPerCost column
  cleanedData$RatingPerCost <- as.numeric(cleanedData$Rating) / as.numeric(cleanedData$Average_Cost)
  
  # sort cleanedData based on best RatingPerCost
  cleanedData <- cleanedData[with(cleanedData, order(-cleanedData$RatingPerCost)), ]
  
  # add the $ back to Average_Cost
  cleanedData$Average_Cost <- paste("$", cleanedData$Average_Cost, sep = "")
  
  if (filterLowVotes){
    cleanedData <- cleanedData %>% filter(as.numeric(cleanedData$Votes) > minVotes)
  }
  
  return(cleanedData)
}

# call function to sort based on Rating/Cost
ratingPerCost <- getRatingPerCost(dataFrame = data, filterLowVotes = FALSE, minVotes = 0)

# Look at restaurant names with associated RatingPerCost
data.frame(ratingPerCost$Restaurant, ratingPerCost$RatingPerCost)

# If you want to see all of the restaurant information
ratingPerCost


