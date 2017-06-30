library(sf)
library(ggplot2) #development version!
## devtools::install_github("tidyverse/ggplot2")
library(tidyverse)
library(readr)
## Not sure about this bit
library("tidyverse", lib.loc="/Library/Frameworks/R.framework/Versions/3.4/Resources/library")

## Import data
ka <- read.csv("alldata/ka.csv")

## Print it if you like
ka

## Summarise it
summary(ka)

## Find out classes
sapply(ka,class)

## Use this bit to check which columns had unique values
## E.g Positional_quality_indicator column
length(unique(ka$Positional_quality_indicator))

## Plot Postcodes as co-ordinates
ggplot(data = ka) +
  geom_point(mapping = aes(x = Eastings, y = Northings))

## Selecting columns
postcodecoord <- data.frame(ka$Postcode,ka$Eastings,ka$Northings)
## OR
postcodecoord <- ka[,c("Postcode","Eastings","Northings")]

## Selecting rows
Arran <- ka[c(6700:6896),c("Postcode","Eastings","Northings")]

## Plot Postcodes as Co-ordinates
ggplot(data = Arran) +
  geom_point(mapping = aes(x = Eastings, y = Northings))

## Plot Postcodes as co-ordinates
ggplot(data = Arran) +
  geom_point(mapping = aes(x = Eastings, y = Northings))

## Neater version
ggplot(data = Arran) +
  geom_point(mapping = aes(x = Eastings, y = Northings)) +
  ggtitle("Arran Postcodes") +
  labs(title = "Arran Postcodes", x = "Eastings", y = "Northings") +
  theme(plot.title = element_text(hjust = 0.5))

## Finding the Arran coordinates
library(dplyr)
allcoordinates <- read.csv("alldata/ukpostcodes.csv")
arrancoordinates <- filter(allcoordinates,substr(postcode,1,4)=="KA27")

## Plotting the Arran coordinates
ggplot(data = arrancoordinates) +
  geom_point(mapping = aes(x = longitude, y = latitude)) +
  ggtitle("Arran Postcodes") +
  labs(title = "Arran Postcodes", x = "Longitude", y = "Latitude") +
  theme(plot.title = element_text(hjust = 0.5))
