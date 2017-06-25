# this uses the sf package to create a new object called sg
# sg is a dataframe, there is one column called geometry with all the useful map info

library(sf)
library(ggplot2) #development version!
library(tidyverse)

#Import SIMD data from http://www.gov.scot/Topics/Statistics/SIMD
#The "new data zone boundaries with SIMD16 ranks (zipped shapefile)"
#'2011 Data Zone boundaries'
sg <- read_sf("./SG_SIMD_2016")

#sg %>%
#  ggplot() +
#  geom_sf()

#Plot Data zone areas entire UK.
#sg %>%
#  ggplot() +
#  geom_sf(aes(fill = DataZone))

#cut out a section
#Plot Data zone areas for cut out section
sh <- sg[1:10,]
sh %>%
  ggplot() +
  geom_sf(aes(fill = DataZone))

#Import SIMD data from http://www.gov.scot/Topics/Statistics/SIMD
#The 'Postcode to SIMD rank'
allsimdgroups <-read.csv("~/Desktop/00505244.csv")
#Summarise this data
summary(allsimdgroups)
#Find the classes from this data
sapply(allsimdgroups,class)

#Tried to filter this by postcode
#Won't work for some reason
##arransimdgroups <- filter(allsimdgroups,substr("Postcode",1,4)=="KA27")

#Found the right postcodes from a filter and chose the columms
#Looked in finder and selected the Arran postocodes
arransimdgroups2 <- allsimdgroups[c(162526:162757),]

#Select Arran data zones columm
arrandatazones <- arransimdgroups2[,"DZ"]

#Find unique DZ values from arransimdgroups2
unique(arransimdgroups2$DZ)

#Create Arran DZ vector of sg rows
#From observation of unique DZ in arransimdgroups2
#Filter sg by dz from unique DZ, note row no.

Arrandz <- c(4672,4666,4669,4671,4667,4668,4670)

#Select arran rows in sg by using arrandz vector
arran <- sg[Arrandz,]

#Then plot it
arran %>%
  ggplot() +
  geom_sf(aes(fill = DataZone))

#Save as arran map
arranmap <- (arran %>%
  ggplot() +
  geom_sf(aes(fill = DataZone)))

#Blank Arran map
arran %>%
  ggplot() +
  geom_sf()

arran %>%
  ggplot() +
  geom_sf(aes(fill = Percentile))

#Filter sg by arrandatazones
#Filter data object rows by factor
##Not sure how yet


##Nothing else useful
## Fuck this http://r4ds.had.co.nz/relational-data.html#filtering-joins
##semi_join(x, y)
##allsimdgroups <-read
##arrangroups <- sg %>%
##  filter(ZONE == "Bagmati")