

# function to calculate distance in miles if given 2 coordinate points
distInMiles <- function(latitude1, longitude1, latitude2, longitude2){
  lat1 <- latitude1 * pi / 180
  lat2 <- latitude2 * pi / 180
  dLat <- lat2 - lat1
  long1 <- longitude1 * pi / 180
  long2 <- longitude2 * pi / 180
  dLong <- long2 - long1
  a <- (sin(dLat/2))^2 + cos(lat1) * cos(lat2) * (sin(dLong/2))^2
  c <- 2 * atan2(sqrt(a), sqrt(1-a))
  d = 3961 * c
  
  return(d)
}

# function to recommend list of restaurants from XTernData.csv based on selected preferences
recommendRestaurants <- function(maxTime = 200, cuisine = "all", minRating = 0, 
                                 minCost = 200, maxDist = 1000, longitude = 0, latitude = 0){
  # Get the restaurant data
  data <- read.csv("Downloads/XTernData.csv")
  # copy data to tweakedData
  tweakedData <- data
  
  # get rid of minutes from Cook_Time to make calculations easy
  tweakedData$Cook_Time <- str_remove_all(tweakedData$Cook_Time, " minutes")
  # Filter according to cook time and add the minutes back
  tweakedData <- tweakedData %>% filter((maxTime >= tweakedData$Cook_Time))
  tweakedData$Cook_Time <- paste(tweakedData$Cook_Time, "minutes", ' ')
  
  # filter according to rating
  tweakedData <- tweakedData %>% filter(minRating <= tweakedData$Rating)
 
  # only filter cuisine if it was given
  if (cuisine != "all"){
    # filter according to cuisine
    tweakedData <- tweakedData %>% filter(grepl(cuisine, tweakedData$Cuisines, fixed = TRUE))
  }
  
  # get rid of $ in front of average cost
  tweakedData$Average_Cost <- substr(tweakedData$Average_Cost, 2, length(tweakedData$Average_Cost) - 1)
  # filter by cost
  tweakedData <- tweakedData %>% filter(minCost >= tweakedData$Average_Cost)
  # add the $ back
  tweakedData$Average_Cost <- paste("$", tweakedData$Average_Cost, sep = "")
  
  if (maxDist != 1000 | longitude != 0 | latitude != 0){
    # get distance away in miles
    dist <- distInMiles(latitude1 = tweakedData$Latitude, longitude1 = tweakedData$Longitude, 
                        latitude2 = latitude, longitude2 = longitude)
    # filter by distance
    tweakedData <- tweakedData %>% filter(maxDist >= dist)    
  }
  
  # return tweakedData
  return(tweakedData)
}

# recommend me restaurants based on my preferences
recommendMe <- recommendRestaurants(maxTime = 40, cuisine = "North Indian", minRating = 4,  minCost = 20, 
                                    maxDist = 1000, longitude = 0, latitude = 0)
# if no preference on a certain category, simply delete the specification from call to function

# just look at restaurant IDs
recommendMe$Restaurant

# actually, I would like to see all of the details of the recommended restaurants
recommendMe
