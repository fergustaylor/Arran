# this uses the sf package to create a new object called sg
# sg is a dataframe, there is one column called geometry with all the useful map info

library(sf)
library(ggplot2) #development version!
library(tidyverse)

#Import SIMD data from http://www.gov.scot/Topics/Statistics/SIMD
#The "new data zone boundaries with SIMD16 ranks (zipped shapefile)"
#'2011 Data Zone boundaries'
2016 <- read_sf("./SG_SIMD_2016")

2012 <- read_sf("./SG_SIMD_2016")

#Look at data from 2012
readxl::read_excel("./alldata/SIMD2012/00410770.xls")
readxl::read_excel("./alldata/SIMD2012/00416552.xls")

2009 <- read_sf("./SG_SIMD_2016")

readxl::read_excel("./alldata/SIMD2009/0096578.xls")
readxl::read_excel("./alldata/SIMD2009/0097806.xls")

2006 <- read_sf("./SG_SIMD_2016")

readxl::read_excel("./alldata/SIMD2006/0096578.xls")
readxl::read_excel("./alldata/SIMD2006/0097880.xls")

2004 <- read_sf("./SG_SIMD_2016")

readxl::read_excel("./alldata/SIMD2004/0027003.xls")
