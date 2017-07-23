## Introduction
This is an early project based on SIMD data that I'm using to try and learn R.
I intend to explore the package ['ggplot2'](http://ggplot2.tidyverse.org/reference/ggsf.html) to practice a set of skills I'm attempting to learn through a combination of [DataCamp courses](https://www.datacamp.com/courses/free-introduction-to-r), [RStudio 'Cheat Sheets'](https://www.rstudio.com/resources/cheatsheets/) and [twitter](https://twitter.com/hashtag/Rstats?src=hash).

<style>
	iframe {
		width: 500px;
		height: 500px;
	}
</style>
<iframe src="map.html">
</iframe>

[See the map.](map.html)

### Early progress

Initially I used map cordinates given by [Ordinance Survey](https://www.ordnancesurvey.co.uk/opendatadownload/products.html) to find the centre of any KA27 postcode on a map.
(KA27 being the prefix or 'postcode area' that denotes all Aran Island postcodes).

I then read the coordinates into sf with st_as_sf(), and plotted over a shape file map of Arran; over the SIMD data zones, as well as the section of coordinates contained in one data zone/

![Coordinate plots](Rplot11.5.png)

With the postcodes sorted, I then wanted to relate some other information about these areas.
I used [SIMD](www.gov.scot/Topics/Statistics/SIMD) 'DataZone boundraries' and plotted their ERSI Shapefiles using 'geom_sf.' 
First the data zones onto the island.
Then I coloured/labelled the individual data zones.
Having worked that out, I wanted to show some health data about the zones. I overlayed 'percentile' data about the areas for 2016.

![DZ Outlines2](Rplot13.png)

Then after faffing about with individual shape files for every year, (The data zone labels changed after 2012), I did the same for all the SIMD data periods and used facet_wrap to plot them all together.

![Percentile Facet_wrap](Rplot10.png)

Combining the coordinate and SIMD data, I've summarised one of the zones (S01004372) below.

![Summary plots](Rplot12.5.png)

<<<<<<< HEAD
##{.tabset}

### By Product

(tab content)

The next steps will be to overlay this data over a map using leaflet.

[See the map.](map.html)

```{r echo=FALSE}
arrancoordinates <- read.csv("alldata/ukpostcodes.csv") %>%
 filter(substr(postcode,1,4)=="KA27")

DZBoundaries2016 <- read_sf("./alldata/SG_SIMD_2016")

arran2016 <- DZBoundaries2016[c(4672,4666,4669,4671,4667,4668,4670),]
#Reorder arran 2016
reorderedvector<- c("S01011174", "S01011171", "S01011177", "S01011176", "S01011175", "S01011173", "S01011172" )
arran2016 <- arran2016 %>%
  slice(match(reorderedvector, DataZone))

simple.sf <- st_as_sf(arrancoordinates, coords=c('longitude','latitude'))
st_crs(simple.sf) <- 4326

exampleshapes <- sf:::as_Spatial(arran2016$geometry)
examplepoints <- sf:::as_Spatial(simple.sf$geom)

examplepoints <- spTransform(examplepoints, CRS("+proj=longlat +datum=WGS84"))
exampleshapes <- spTransform(exampleshapes, CRS("+proj=longlat +datum=WGS84"))

namingdzpostcode <- over(exampleshapes, examplepoints, returnList = TRUE)

listID <- list(1,2,3,4,5,6,7)

function100 <- function(argument) 
{
  argument <- arrancoordinates[namingdzpostcode[[argument]],] %>% mutate(DataZone=argument)
}

newarrancoordinates <- lapply(1:7,function100)

newarrancoordinates <- rbind(newarrancoordinates[[1]], newarrancoordinates[[2]], newarrancoordinates[[3]], newarrancoordinates[[4]], newarrancoordinates[[5]], newarrancoordinates[[6]], newarrancoordinates[[7]])

newarrancoordinates$listID <- revalue(as.character(newarrancoordinates$DataZone),
               c('1'="S01004409/S01011174", '2'="S01004372/S01011171", '3'="S01004353/S01011177", '4'="S01004352/S01011176", '5'="S01004351/S01011175", '6'="S01004350/S01011173", '7'="S01004349/S01011172"))

postcodelist <- paste(unique(newarrancoordinates$listID), "Postcodes", sep=" ")
datazonelist <- paste(unique(newarrancoordinates$listID), "Datazones", sep=" ")

m = leaflet() %>% addTiles()

m %>% setView(-5.227680, 55.582338, zoom = 10) %>% 

#allcoordinates
addMarkers(
    lng = newarrancoordinates$longitude, lat = newarrancoordinates$latitude,
    label = newarrancoordinates$postcode,
    labelOptions = labelOptions(noHide = F), group = "Postcode Plots") %>%
hideGroup("All Postcode Plots") %>% 

#alldatazones  
addPolygons(data=exampleshapes, 
            weight = 2, 
            label = datazonelist,
            group = "All Datazones") %>% 
hideGroup("Datazones") %>% 
  
#selectcoordinates
addMarkers(
    lng = newarrancoordinates$longitude, lat = newarrancoordinates$latitude,
    label = newarrancoordinates$postcode,
    labelOptions = labelOptions(noHide = F), group = newarrancoordinates$listID) %>% 
hideGroup(newarrancoordinates$listID) %>% 

#selectdatazone
addPolygons(data = exampleshapes[1] , 
            weight = 2, label = datazonelist[1], group = datazonelist[1]) %>% 
addPolygons(data = exampleshapes[2] , 
            weight = 2, label = datazonelist[2], group = datazonelist[2]) %>% 
addPolygons(data = exampleshapes[3] , 
            weight = 2, label = datazonelist[3], group = datazonelist[3]) %>% 
addPolygons(data = exampleshapes[4] , 
            weight = 2, label = datazonelist[4], group = datazonelist[4]) %>% 
addPolygons(data = exampleshapes[5] , 
            weight = 2, label = datazonelist[5], group = datazonelist[5]) %>% 
addPolygons(data = exampleshapes[6] , 
            weight = 2, label = datazonelist[6], group = datazonelist[6]) %>% 
addPolygons(data = exampleshapes[7] , 
            weight = 2, label = datazonelist[7], group = datazonelist[7]) %>% 
hideGroup(datazonelist[1]) %>%
hideGroup(datazonelist[2]) %>%
hideGroup(datazonelist[3]) %>%
hideGroup(datazonelist[4]) %>%
hideGroup(datazonelist[5]) %>%
hideGroup(datazonelist[6]) %>%
hideGroup(datazonelist[7]) %>%

#Layers control
addLayersControl(
    baseGroups = c("All Datazones", "Postcode Plots", "Nothing"),
    overlayGroups = c(newarrancoordinates$listID, datazonelist),
    options = layersControlOptions(collapsed = TRUE)
  )
```

=======
>>>>>>> 532103e92d32c720055198a75e1007f2c14bfdba
The overall aim of this project will be to create an easy template by which a user with no prior programming knowledge can create interactive graphs by overlaying some form of data attributed to a postcode alone.

[See the full code.](Arran_Workbook.html)

[See the code specific to these graphics.](front_page_graphics.html)

<<<<<<< HEAD
[See more code for these graphics.](plots.html)

[Other projects I'm working on.](https://fergustaylor.github.io) 
=======
[Other projects I'm working on.](https://fergustaylor.github.io) 
>>>>>>> 532103e92d32c720055198a75e1007f2c14bfdba
