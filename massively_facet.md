R Notebook
================

``` r
library(sf)
```

    ## Linking to GEOS 3.4.2, GDAL 2.1.2, proj.4 4.9.1

``` r
library(ggplot2) #development version!
## devtools::install_github("tidyverse/ggplot2")
library(tidyverse)
```

    ## Loading tidyverse: tibble
    ## Loading tidyverse: tidyr
    ## Loading tidyverse: readr
    ## Loading tidyverse: purrr
    ## Loading tidyverse: dplyr

    ## Conflicts with tidy packages ----------------------------------------------

    ## filter(): dplyr, stats
    ## lag():    dplyr, stats

``` r
library(readr)
## Not sure about this bit
#library("tidyverse",lib.loc="/Library/Frameworks/R.framework/Versions/3.4/Resources/library")
library(cowplot)
```

    ## 
    ## Attaching package: 'cowplot'

    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     ggsave

``` r
library(sp)
library(gridExtra)
```

    ## 
    ## Attaching package: 'gridExtra'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     combine

``` r
library(dplyr)
library(ggrepel)
library(plyr)
```

    ## -------------------------------------------------------------------------

    ## You have loaded plyr after dplyr - this is likely to cause problems.
    ## If you need functions from both plyr and dplyr, please load plyr first, then dplyr:
    ## library(plyr); library(dplyr)

    ## -------------------------------------------------------------------------

    ## 
    ## Attaching package: 'plyr'

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     arrange, count, desc, failwith, id, mutate, rename, summarise,
    ##     summarize

    ## The following object is masked from 'package:purrr':
    ## 
    ##     compact

``` r
## Finding the Arran coordinates
arrancoordinates <- read.csv("alldata/ukpostcodes.csv") %>%
filter(substr(postcode,1,4)=="KA27")

pcs <- read_sf("alldata/Scotland_pcs_2011")
arransubsect <- filter(pcs,substr(label,1,4)=="KA27")
```

``` r
#Import SIMD data from http://www.gov.scot/Topics/Statistics/SIMD
#https://data.gov.uk/dataset/scottish-index-of-multiple-deprivation-simd-2012
#https://data.gov.uk/dataset/scottish-index-of-multiple-deprivation-simd-2012/resource/d6fa8924-83da-4e80-a560-4ef0477f230b
DZBoundaries2016 <- read_sf("./alldata/SG_SIMD_2016")
DZBoundaries2012 <- read_sf("./alldata/SG_SIMD_2012")
DZBoundaries2009 <- read_sf("./alldata/SG_SIMD_2009")
DZBoundaries2006 <- read_sf("./alldata/SG_SIMD_2006")
DZBoundaries2004 <- read_sf("./alldata/SG_SIMD_2004")
```

``` r
#Selecting Arran data from Scotland (2016)
#Find postcode look-up from below file for KA27 postcodes. Find unique DZ. Find row positions.
#SIMD2016 <-read.csv("./alldata/00505244.csv")
#Selecting ArranDZ2016
Arrandz2016 <- c(4672,4666,4669,4671,4667,4668,4670)
arran2016 <- DZBoundaries2016[Arrandz2016,]
#Reorder arran 2016
reorderedvector<- c("S01011174", "S01011171", "S01011177", "S01011176", "S01011175", "S01011173", "S01011172" )
arran2016 <- arran2016 %>%
  slice(match(reorderedvector, DataZone))

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
```

``` r
arran20162 <- arran2016 %>%
  select(DataZone, geometry, Percentile)  %>%
  mutate(year="2016")

arran20122 <- arran2012 %>%
  select(DataZone, geometry, Percentile) %>%
  mutate(year="2012")

arran20092 <- arran2009 %>%
  select(DataZone, geometry, Percentile) %>%
  mutate(year="2009")

arran20062 <- arran2006 %>%
  select(DataZone, geometry, Percentile) %>%
  mutate(year="2006")

arran20042 <- arran2004 %>%
  select(DataZone, geometry, Percentile) %>%
  mutate(year="2004")

#Now I add it together
arransimd <- rbind(arran20162,arran20122,arran20092,arran20062,arran20042)
```

``` r
simple.sf <- st_as_sf(arrancoordinates, coords=c('longitude','latitude'))
st_crs(simple.sf) <- 4326

exampleshapes <- sf:::as_Spatial(arran2016$geometry)
examplepoints <- sf:::as_Spatial(simple.sf$geom)

examplepoints <- spTransform(examplepoints, CRS("+proj=longlat +datum=WGS84"))
exampleshapes <- spTransform(exampleshapes, CRS("+proj=longlat +datum=WGS84"))

namingdzpostcode <- over(exampleshapes, examplepoints, returnList = TRUE)
```

mutate arrancoordinates
=======================

``` r
function100 <- function(argument) 
{
  argument <- arrancoordinates[namingdzpostcode[[argument]],] %>% mutate(DataZone=argument)
}

function100(1)

newarrancoordinates <- lapply(1:7,function100)
newarrancoordinates <- rbind(newarrancoordinates[[1]], newarrancoordinates[[2]], newarrancoordinates[[3]], newarrancoordinates[[4]], newarrancoordinates[[5]], newarrancoordinates[[6]], newarrancoordinates[[7]])

newarrancoordinates$listID <- revalue(as.character(newarrancoordinates$DataZone),
               c('1'="S01004409/S01011174", '2'="S01004372/S01011171", '3'="S01004353/S01011177", '4'="S01004352/S01011176", '5'="S01004351/S01011175", '6'="S01004350/S01011173", '7'="S01004349/S01011172"))
```

///

``` r
arransimd$listID <- revalue(arransimd$DataZone,
               c("S01004409"="S01004409/S01011174", "S01004372"="S01004372/S01011171", "S01004353"="S01004353/S01011177", "S01004352"="S01004352/S01011176", "S01004351"="S01004351/S01011175", "S01004350"="S01004350/S01011173", "S01004349"="S01004349/S01011172", "S01011174"="S01004409/S01011174", "S01011171"="S01004372/S01011171", "S01011177"="S01004353/S01011177", "S01011176"="S01004352/S01011176", "S01011175"="S01004351/S01011175", "S01011173"="S01004350/S01011173", "S01011172"="S01004349/S01011172"))

arransimd %>%
mutate(
    lon = map_dbl(geometry, ~st_centroid(.x)[[1]]),
    lat = map_dbl(geometry, ~st_centroid(.x)[[2]])
    ) %>%
ggplot() +
  geom_sf(aes(fill = Percentile)) +
  facet_grid(listID ~ year) +
  theme_grey() +
  geom_text(aes(label = Percentile, x = lon, y = lat), size = 2, colour = "white") +
  theme(axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank()) +
  theme(legend.position="bottom")
```

![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-8-1.png)

``` r
arransimd %>%
mutate(
    lon = map_dbl(geometry, ~st_centroid(.x)[[1]]),
    lat = map_dbl(geometry, ~st_centroid(.x)[[2]])
    ) %>%
ggplot() +
  geom_sf(aes(fill = Percentile)) +
  facet_grid(year ~ listID) +
  theme_grey() +
  geom_text(aes(label = Percentile, x = lon, y = lat), size = 2, colour = "white") +
  theme(axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank()) +
  theme(legend.position="bottom")  
```

![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-9-1.png)

``` r
filter(arransimd, year == 2016) %>%
  ggplot() +
  theme_grey() +
  theme(axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) +
  theme(legend.position="none") +
  facet_wrap('listID', nrow = 1) +
  geom_sf(aes(fill = DataZone))
```

![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-10-1.png)

``` r
function5 <- function(argument, argument2) 
{
  argument %>%
  ggplot() +
  geom_sf() +
  theme_grey() +
  geom_point(data=function6(argument2), mapping = aes(x = longitude, y = latitude), size=1) +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank()) +
  coord_sf(crs= 4326, datum = sf::st_crs(4326))
}

filter(arransimd, year == 2016) %>%
  ggplot() +
  theme_grey() +
  theme(axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) +
  theme(legend.position="none") +
  facet_wrap('listID', nrow = 1) +
  geom_sf() 
```

![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-11-1.png)

``` r
ggplot() +
  geom_point(data=newarrancoordinates, 
             mapping = aes(x = longitude, y = latitude), 
             size=1) +
  theme_grey() +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) +
  coord_sf(crs= 4326, datum = sf::st_crs(4326)) +
  facet_wrap('listID', nrow = 1)
```

![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-12-1.png)

``` r
ggplot() +
  geom_sf(data=arransimd) +
  geom_point(data=newarrancoordinates, 
             mapping = aes(x = longitude, y = latitude), 
             size=1) +
  theme_grey() +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank()) +
  coord_sf(crs= 4326, datum = sf::st_crs(4326)) +
  facet_wrap('listID', nrow = 1)
```

![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-13-1.png)

Function 8
==========

``` r
simple.sf <- st_as_sf(arrancoordinates, coords=c('longitude','latitude'))
st_crs(simple.sf) <- 4326

exampleshapes <- sf:::as_Spatial(arran20162$geometry)
examplepoints <- sf:::as_Spatial(simple.sf$geom)

examplepoints <- spTransform(examplepoints, CRS("+proj=longlat +datum=WGS84"))
exampleshapes <- spTransform(exampleshapes, CRS("+proj=longlat +datum=WGS84"))

namingdzpostcode <- over(exampleshapes, examplepoints, returnList = TRUE)
```

``` r
function0.5 <- function(argument) 
{
  filter(arransimd, DataZone==argument)
}
```

``` r
#pre2016listID <- list(3,2,1,4,7,6,5)
#post2016listID <- list(1,2,3,4,5,6,7)

#pre2016listID2 <- list(1,2,3,4,5,6,7)
#post2016listID2 <- list(1,2,3,4,5,6,7)

listID <- list(1,2,3,4,5,6,7)

#all datazones
#datazonelist <- lapply(datazones, function0.5)

#Pre-2016 lists
pre2016list2 <- list("S01004409", "S01004372", "S01004353", "S01004352", "S01004351", "S01004350", "S01004349")
pre2016list <- lapply(pre2016list2, function0.5)

#post2016list2 <- list("S01011177", "S01011171", "S01011174", "S01011176", "S01011172", "S01011173", "S01011175")
#post2016list <- lapply(post2016list2, function0.5)

post2016list3 <- list("S01011174", "S01011171", "S01011177", "S01011176", "S01011175", "S01011173", "S01011172" )
post2016list2 <- lapply(post2016list3, function0.5)
```

``` r
#rearrange arrancoord
function6 <- function(argument) 
{
  arrancoordinates[namingdzpostcode[[argument]],]
}
```

``` r
function5 <- function(argument, argument2) 
{
  argument %>%
  ggplot() +
  geom_sf() +
  theme_grey() +
  geom_point(data=function6(argument2), mapping = aes(x = longitude, y = latitude), size=1) +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank()) +
  coord_sf(crs= 4326, datum = sf::st_crs(4326))
}
```

``` r
function7.5.1 <- function(argument, argument2) 
{
  a <- function1.5.5(argument)
  b <- function2.5.1(argument) 
  c <- function5(argument, argument2)
  grid.arrange(a, b, c, nrow = 1)
}
```

``` r
function1.5.5 <- function(argument) 
{
  argument %>%
mutate(
    lon = map_dbl(geometry, ~st_centroid(.x)[[1]]),
    lat = map_dbl(geometry, ~st_centroid(.x)[[2]])
    ) %>%
  ggplot() +
  geom_sf(aes(fill = Percentile)) +
  facet_wrap('year') +
  theme_grey() +
  geom_text(aes(label = Percentile, x = lon, y = lat), size = 2, colour = "white") +
  theme(axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank()) +
  theme(legend.position="bottom")  
}
```

``` r
function2.5.1 <- function(argument) 
{
  arransubsect %>%
  ggplot() +
  geom_sf() +
  theme_grey() +
  theme(axis.text.x=element_text(angle=45, hjust = 1)) +
  theme(legend.position="bottom") +
  geom_sf(data= argument, aes(fill = DataZone))
}
```

``` r
function5 <- function(argument, argument2) 
{
  argument %>%
  ggplot() +
  geom_sf() +
  theme_grey() +
  geom_point(data=function6(argument2), mapping = aes(x = longitude, y = latitude), size=1) +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank()) +
  coord_sf(crs= 4326, datum = sf::st_crs(4326))
}
```

``` r
function8.pre <- function(argument)
{
  function7.5.1(pre2016list[[argument]],listID[[argument]])
}
lapply(1:7, function8.pre)
```

![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-23-1.png)![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-23-2.png)![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-23-3.png)![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-23-4.png)![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-23-5.png)![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-23-6.png)![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-23-7.png)

    ## [[1]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]
    ## 
    ## [[2]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]
    ## 
    ## [[3]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]
    ## 
    ## [[4]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]
    ## 
    ## [[5]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]
    ## 
    ## [[6]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]
    ## 
    ## [[7]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]

``` r
function8.post <- function(argument)
{
  function7.5.1(post2016list2[[argument]],listID[[argument]])
}
lapply(1:7, function8.post)
```

![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-23-8.png)![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-23-9.png)![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-23-10.png)![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-23-11.png)![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-23-12.png)![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-23-13.png)![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-23-14.png)

    ## [[1]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]
    ## 
    ## [[2]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]
    ## 
    ## [[3]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]
    ## 
    ## [[4]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]
    ## 
    ## [[5]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]
    ## 
    ## [[6]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]
    ## 
    ## [[7]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]

``` r
function10 <- function(argument)
{
a <- arransimd %>%
mutate(
    lon = map_dbl(geometry, ~st_centroid(.x)[[1]]),
    lat = map_dbl(geometry, ~st_centroid(.x)[[2]])
    ) %>%
filter(listID == argument)  %>%
  ggplot() +
  geom_sf(aes(fill = Percentile)) +
  facet_wrap('year') +
  theme_grey() +
  geom_text(aes(label = Percentile, x = lon, y = lat), size = 2, colour = "white") +
  theme(axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank()) +
  theme(legend.position="bottom")  

b <- arransimd %>%
  filter(listID == argument)  %>%
  ggplot() +
  geom_sf(data = arransubsect) +
  theme_grey() +
  theme(axis.text.x=element_text(angle=45, hjust = 1)) +
  theme(legend.position="bottom") +
  geom_sf(aes(fill = DataZone))

c <- arransimd %>%
  filter(listID == argument)  %>%
  ggplot() +
  geom_sf() +
  theme_grey() +
  geom_point(data = filter(newarrancoordinates, listID == argument), 
             mapping = aes(x = longitude, y = latitude), size=1) +
  geom_text_repel(data = filter(newarrancoordinates, listID == argument), 
            aes(label = filter(newarrancoordinates, 
                               listID == argument)$postcode, 
                x = longitude, y = latitude), size=2) +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank()) +
  coord_sf(crs= 4326, datum = sf::st_crs(4326))

grid.arrange(a, b, c, nrow = 1)
}
```

create as list down side instead?
=================================

create template to selectively display postcodes
================================================

``` r
lapply(unique(arransimd$listID), function10)
```

![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-25-1.png)![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-25-2.png)![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-25-3.png)![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-25-4.png)![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-25-5.png)![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-25-6.png)![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-25-7.png)

    ## [[1]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]
    ## 
    ## [[2]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]
    ## 
    ## [[3]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]
    ## 
    ## [[4]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]
    ## 
    ## [[5]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]
    ## 
    ## [[6]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]
    ## 
    ## [[7]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]

``` r
function10.5 <- function(argument)
{
a <- arransimd %>%
mutate(
    lon = map_dbl(geometry, ~st_centroid(.x)[[1]]),
    lat = map_dbl(geometry, ~st_centroid(.x)[[2]])
    ) %>%
filter(listID == argument)  %>%
  ggplot() +
  geom_sf(aes(fill = Percentile)) +
  facet_wrap('year') +
  theme_grey() +
  geom_text(aes(label = Percentile, x = lon, y = lat), size = 2, colour = "white") +
  theme(axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank(),
        axis.title.x = element_blank(),
        axis.title.y = element_blank()) +
  theme(legend.position="none") +
  ggtitle(argument)  

b <- arransimd %>%
  filter(listID == argument)  %>%
  ggplot() +
  geom_sf(data = arransubsect) +
  theme_grey() +
  theme(axis.text.x=element_text(angle=45, hjust = 1)) +
  theme(legend.position="none") +
  geom_sf(aes(fill = DataZone))

c <- arransimd %>%
  filter(listID == argument)  %>%
  ggplot() +
  geom_sf() +
  theme_grey() +
  geom_point(data = filter(newarrancoordinates, listID == argument), 
             mapping = aes(x = longitude, y = latitude), size=1) +
  geom_text_repel(data = filter(newarrancoordinates, listID == argument), 
            aes(label = filter(newarrancoordinates, 
                               listID == argument)$postcode, 
                x = longitude, y = latitude), size=2) +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank()) +
  coord_sf(crs= 4326, datum = sf::st_crs(4326))

grid.arrange(a, b, c, nrow = 1)
}
lapply(unique(arransimd$listID), function10.5)
```

![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-26-1.png)![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-26-2.png)![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-26-3.png)![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-26-4.png)![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-26-5.png)![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-26-6.png)![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-26-7.png)

    ## [[1]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]
    ## 
    ## [[2]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]
    ## 
    ## [[3]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]
    ## 
    ## [[4]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]
    ## 
    ## [[5]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]
    ## 
    ## [[6]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]
    ## 
    ## [[7]]
    ## TableGrob (1 x 3) "arrange": 3 grobs
    ##   z     cells    name           grob
    ## 1 1 (1-1,1-1) arrange gtable[layout]
    ## 2 2 (1-1,2-2) arrange gtable[layout]
    ## 3 3 (1-1,3-3) arrange gtable[layout]

``` r
function11 <- function(argument)
{
arransimd %>%
  filter(listID == argument)  %>%
  ggplot() +
  geom_sf() +
  theme_grey() +
  geom_point(data = filter(newarrancoordinates, listID == argument), 
             mapping = aes(x = longitude, y = latitude), size=1) +
  geom_text_repel(data = filter(newarrancoordinates, listID == argument), 
            aes(label = filter(newarrancoordinates, 
                               listID == argument)$postcode, 
                x = longitude, y = latitude), size=2) +
  theme(axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank(),
        axis.text.y=element_blank(),
        axis.ticks.y=element_blank()) +
  coord_sf(crs= 4326, datum = sf::st_crs(4326))
}

function11('S01004409/S01011174')
```

![](massively_facet_files/figure-markdown_github-ascii_identifiers/unnamed-chunk-27-1.png)

a &lt;- arransimd %&gt;% mutate( lon = map\_dbl(geometry, ~st\_centroid(.x)\[\[1\]\]), lat = map\_dbl(geometry, ~st\_centroid(.x)\[\[2\]\]) ) %&gt;% ggplot() + geom\_sf(aes(fill = Percentile)) + facet\_wrap(listID ~ year) + theme\_grey() + geom\_text(aes(label = Percentile, x = lon, y = lat), size = 2, colour = "white") + theme(axis.text.x=element\_blank(), axis.ticks.x=element\_blank(), axis.text.y=element\_blank(), axis.ticks.y=element\_blank(), axis.title.x = element\_blank(), axis.title.y = element\_blank()) + theme(legend.position="bottom")

b &lt;- arransimd %&gt;% ggplot() + geom\_sf(data = arransubsect) + theme\_grey() + theme(axis.text.x=element\_text(angle=45, hjust = 1)) + theme(legend.position="bottom") + geom\_sf(aes(fill = DataZone))

c &lt;- arransimd %&gt;% ggplot() + geom\_sf() + theme\_grey() + geom\_point(data = filter(newarrancoordinates, listID == argument), mapping = aes(x = longitude, y = latitude), size=1) + geom\_text\_repel(data = filter(newarrancoordinates, listID == argument), aes(label = filter(newarrancoordinates, listID == argument)$postcode, x = longitude, y = latitude), size=2) + theme(axis.title.x = element\_blank(), axis.title.y = element\_blank(), axis.text.x=element\_blank(), axis.ticks.x=element\_blank(), axis.text.y=element\_blank(), axis.ticks.y=element\_blank()) + coord\_sf(crs= 4326, datum = sf::st\_crs(4326))

grid.arrange(a, b, c, nrow = 1)
