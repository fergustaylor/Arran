# this uses the sf package to create a new object called sg
# sg is a dataframe, there is one column called geometry with all the useful map info

library(sf)
library(ggplot2) #development version!
library(tidyverse)

#Import SIMD data from http://www.gov.scot/Topics/Statistics/SIMD
#The "new data zone boundaries with SIMD16 ranks (zipped shapefile)"
#'2011 Data Zone boundaries'

DZBoundaries2016 <- read_sf("./alldata/SG_SIMD_2016")

#https://data.gov.uk/dataset/scottish-index-of-multiple-deprivation-simd-2012
#https://data.gov.uk/dataset/scottish-index-of-multiple-deprivation-simd-2012/resource/d6fa8924-83da-4e80-a560-4ef0477f230b
DZBoundaries2012 <- read_sf("./alldata/SG_SIMD_2012")
DZBoundaries2009 <- read_sf("./alldata/SG_SIMD_2009")
DZBoundaries2006 <- read_sf("./alldata/SG_SIMD_2006")
DZBoundaries2004 <- read_sf("./alldata/SG_SIMD_2004")


#Look at data from 2016
SIMD2016 <-read.csv("./alldata/00505244.csv")
SIMD20162 <-read_sf("./alldata/SG_SIMD_2016")

#Look at data from 2012
SIMD2012 <- readxl::read_excel("./alldata/SIMD2012/00410770.xls")
SIMD20122 <- readxl::read_excel("./alldata/SIMD2012/00416552.xls")

#Look at data from 2009
SIMD2009 <- readxl::read_excel("./alldata/SIMD2009/0096578.xls")
SIMD20092 <- readxl::read_excel("./alldata/SIMD2009/0097806.xls")

#Look at data from 2006
# 2009 data - SIMD2006 <- readxl::read_excel("./alldata/SIMD2006/0096578.xls")
SIMD20062 <- readxl::read_excel("./alldata/SIMD2006/0097880.xls")

#Look at data from 2004
SIMD2004 <- readxl::read_excel("./alldata/SIMD2004/0027003.xls")

#Selecting ArranDZ2016
Arrandz <- c(4672,4666,4669,4671,4667,4668,4670)

#Health domain rank
#2016
arran2016 <- SIMD20162[Arrandz,]

#Find postcode look-up, KA27 postcodes. Find unique DZ. Find row positions.

#Selecting ArranDZ2012
Arrandz2012 <- c(4409,4372,4353,4352,4351,4350,4349)

#2012
arran2012 <- DZBoundaries2012[Arrandz2012,]
#2009
arran2009 <- DZBoundaries2009[Arrandz2012,]
#2006
arran2006 <- DZBoundaries2006[Arrandz2012,]
#2004
arran2004 <- DZBoundaries2004[Arrandz2012,]

#Plot 2012
arran2012 %>%
  ggplot() +
  geom_sf(aes(fill = DataZone))

arran2012 %>%
  ggplot() +
  geom_sf(aes(fill = Percentile))

#Plot 2009
arran2009 %>%
  ggplot() +
  geom_sf(aes(fill = DataZone))

arran2009 %>%
  ggplot() +
  geom_sf(aes(fill = Percentile))

#Plot 2006
arran2006 %>%
  ggplot() +
  geom_sf(aes(fill = DataZone))

arran2006 %>%
  ggplot() +
  geom_sf(aes(fill = Percentile))

#Plot 2004
arran2004 %>%
  ggplot() +
  geom_sf(aes(fill = DataZone))

arran2004 %>%
  ggplot() +
  geom_sf(aes(fill = Percentile))

##Plot graphs together