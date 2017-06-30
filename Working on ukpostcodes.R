## Import data
allcoordinates <- read.csv("/alldata/ukpostcodes.csv")

## Selecting rows
Arrancoordinates <- allcoordinates[c(941622:941469),c("postcode","latitude","longitude")]