
# Get the restaurant data
data <- read.csv("Downloads/XTernData.csv")

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

estimatedTime <- function(restID, curLat, curLong){
  # get row for specific restaurantID
  restaurant <- data[which(data$Restaurant == "ID_1696"), ]
  
  # get distance away
  dist <- distInMiles(restaurant$Latitude, restaurant$Longitude, curLat, curLong)
  
  # find approximate travel time based on 55 mph and convert to minutes
  time <- dist / 55
  time <- time * 60
  
  # get rid of "minutes" in order to do calculations
  restaurant$Cook_Time <- str_remove_all(restaurant$Cook_Time, " minutes")
  # add cooking time to time
  time <- time + as.numeric(restaurant$Cook_Time)
  
  # return time
  return(time)
}

# get estimated time based on current location and restaurant
estimatedTime(restID = "ID_4866", curLat = 39.9044, curLong = -85.1063)


