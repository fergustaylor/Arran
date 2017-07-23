## Introduction
This is an early project based on SIMD data that I'm using to try and learn R.
I intend to explore the package ['ggplot2'](http://ggplot2.tidyverse.org/reference/ggsf.html) to practice a set of skills I'm attempting to learn through a combination of [DataCamp courses](https://www.datacamp.com/courses/free-introduction-to-r), [RStudio 'Cheat Sheets'](https://www.rstudio.com/resources/cheatsheets/) and [twitter](https://twitter.com/hashtag/Rstats?src=hash).


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

The next steps will be to overlay this data over a map using leaflet.

```{r}
library(leaflet)
library(rgdal)
m = leaflet() %>% addTiles()

mymap <- m %>% setView(-5.227680, 55.582338, zoom = 10) %>% 

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

The overall aim of this project will be to create an easy template by which a user with no prior programming knowledge can create interactive graphs by overlaying some form of data attributed to a postcode alone.

[Current Progress.](massively_facet.html) 

[See the full code.](Arran_Workbook.html)

[See the code specific to these graphics.](front_page_graphics.html)

[See more code for these graphics.](plots.html)

[Other projects I'm working on.](https://fergustaylor.github.io) 
