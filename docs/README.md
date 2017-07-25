## Introduction
This is an early project based on SIMD data that I'm using to try and learn R.
I intend to explore the package ['ggplot2'](http://ggplot2.tidyverse.org/reference/ggsf.html) to practice a set of skills I'm attempting to learn through a combination of [DataCamp courses](https://www.datacamp.com/courses/free-introduction-to-r), [RStudio 'Cheat Sheets'](https://www.rstudio.com/resources/cheatsheets/) and [twitter](https://twitter.com/hashtag/Rstats?src=hash).

SIMD Datazones and Example Markers

<style>
	iframe {
		width: 500px;
		height: 500px;
	}
</style>
<iframe src="map.html">
</iframe>

[See the map.](map.html)

SIMD Percentiles

<style>
	iframe {
		width: 500px;
		height: 500px;
	}
</style>
<iframe src="map2.html">
</iframe>

[See the map.](map2.html)

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

<style>
	iframe {
		width: 500px;
		height: 500px;
	}
</style>
<iframe src="Function10.html">
</iframe>

[See these plots in a new window.](Function10.html)

I've since overlaid this data onto an interactive map using leaflet.

[Example map1.](map.html)

[Example map2.](map2.html)

The overall aim of this project is to create an easy template by which a user with no prior programming knowledge can create interactive graphs by overlaying some form of data assigned to a postcode alone.

The reason I've chosen postcode is that it's a widely-used measurement that can be integrated with the project easily.
Since I've already imported a list of Arran Postcodes with coordinates, I can create markers for any given address using one.
For example, I had a list of each GP clinic taken from their website, (http://www.arranmedical.co.uk/contact/).
If I put this information onto an excel chart, I can subsect the full postcode list by the clinic list, giving me a new list with coordinates I can then plot as markers on a map.
I can easily label them by including another column in the orginal excel table. Using this method is the same amount of effort plotting the data for 10 markers as it would be for 100.

I can then overlay onto the map+markers any information I want. In my first 2 maps I've shown SIMD DataZones, but I could create zones dividing up the map by closest clinic for example, or distance to the ferry for hospital transport.

If I used OS postcode tiles I could even overlay some information (a continuous/ variable matched to a colour palate) assigned to that postcode. (Like the percentile data, but showing many smaller areas over Arran).

[See this example.](mapping.html#example_markers)

[See the full code.](Arran_Workbook.html)

[See the code specific to these graphics.](front_page_graphics.html)

[Other projects I'm working on.](https://fergustaylor.github.io) 
