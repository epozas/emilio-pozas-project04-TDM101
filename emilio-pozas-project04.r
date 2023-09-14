myDF <- read.csv("/anvil/projects/tdm/data/craigslist/vehicles.csv", stringsAsFactors = TRUE)

sort(table(myDF$state))
length(table(myDF$state))
str(myDF)
sum(myDF$price >= 2000)
mean(myDF$price) #mean = avg

myDF$mileage_category <- cut(myDF$odometer , breaks = c(0, 50000, 100000, 150000, Inf), labels = c("Low" , "Moderate", "High", "Very High")) 
tail(myDF$mileage_category)
myDF$has_VIN <- rep("Has VIN", times=426880)
myDF$has_VIN[myDF$VIN == ""] <- "No VIN"
tail(myDF$VIN)
head(myDF$has_VIN)
mynchar <- nchar(as.character(myDF$description))
myDF$description_length <- cut(mynchar , breaks = c(0,50,100,200,500, Inf) , labels = c("Very Short", "Short", "Medium" , "Long" , "Very Long" ))
tail(myDF$description_length, n = 30)

myTexasDF <- myDF[myDF$state == "tx",]
head(myTexasDD)
popularStateDF <- myDF[myDF$state == "ca" , ]
head(popularStateDF)
myFavoriteDF <- myDF[myDF$state =="ny",] 
head(myFavoriteDF)

options(jupyter.rich_display = T)
myTexasDF <- subset(myDF, state == "tx" & !is.na(lat) & !is.na(long))
library(leaflet)
library(sf)
dim(myTexasDF)
points <- st_as_sf(myTexasDF, coords =c("long", "lat"), crs=4326)
addCircleMarkers(addTiles(leaflet(myTexasDF)), radius = 1)
popularStateDF <- subset(myDF, state == "ca" & !is.na(lat) & !is.na(long))
myFavoriteDF <- subset(myDF, state == "ny" & !is.na(lat) & !is.na(long))
points <- st_as_sf(popularStateDF, coords =c("long", "lat"), crs=4326)
addCircleMarkers(addTiles(leaflet(popularStateDF)), radius = 1)
points <- st_as_sf(myFavoriteDF, coords =c("long", "lat"), crs=4326)
addCircleMarkers(addTiles(leaflet(myFavoriteDF)), radius = 1)