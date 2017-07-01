# Arran

## Introduction
This is an early project based on SIMD data that I'm using to learn R.
For this I intend to explore 'ggplot2' to incorporate a set of skills I'm attempting to learn through a combination of DataCamp courses, RStudio 'Cheat Sheets' and twitter.

### Early progress

Initially I used map cordinates given by Ordinance Survey to find the centre of any KA27 postcode on a map.
(KA27 being the prefix or 'postcode area' that relates to all Aran Island postcodes).
I used the function 'geom_point' to plot these postcodes as points on a map.

![Point coordinates](https://github.com/fergustaylor/Arran/raw/master/docs/Rplot03.png)

![Point coordinates14](https://raw.githubusercontent.com/username/projectname/branch/path/to/img.png)

![Point coordinates13](Rplot03.png)


![Point coordinates12](https://fergustaylor.github.io/Arran/figure-html/Rplot03.png)


![Point coordinates5](https://fergustaylor.github.io/Arran/raw/master/docs/Rplot03.png)

![Point coordinates6](https://fergustaylor.github.io/Arran/docs/Rplot03.png)

![Point coordinates2](https://fergustaylor.github.io/Arran/docs/Rplot03.png)

![Point coordinates3](https://callumgwtaylor.github.io/blog/post/2017-06-05-using-sf-gganimate-and-the-humanitarian-data-exchange-to-map-acled-data-for-africa_files/figure-html/acled_2017-1.png)

https://callumgwtaylor.github.io/blog/post/2017-05-28-plotting-deprivation-in-scotland-using-geofacet-and-sf-in-r_files/figure-html/geofacet_deprivation_plots-1.png

Actually in reality, I first plotted the entire map section (NR) before taking a shockingly large amount of time to work out how to filter the postcodes down futher.

![Point coordinates whole map](https://github.com/fergustaylor/Arran/raw/master/docs/Rplot02.png)

I then used SIMD 'DataZone boundraries' and plotted their ERSI Shapefiles using 'geom_sf.' I then coloured and labelled the individual data zones, and overlayed some 'percentile' data about the areas.

![DZ Outlines](https://github.com/fergustaylor/Arran/raw/master/docs/Rplot04.png)

![DZ Outlines2](https://github.com/fergustaylor/Arran/raw/master/docs/Rplot05.png)

![DZ Outlines Colourewd](https://github.com/fergustaylor/Arran/raw/master/docs/Rplot06.png)

After faffing about with individual shape files for every year. (The data zone labels changed after 2012), I then did the same for all the SIMD data periods.
I then added multiplot to add them together.

![Multiplot plot](https://github.com/fergustaylor/Arran/raw/master/docs/Rplot.png)

### Example coding
```yml
title: [The title of your site]
description: [A short description of your site's purpose]
```
### Other examples

If you'd like to add lists:

1. Bullet-pointing

[Back to main site](https://fergustaylor.github.io) 

[Another example readme](https://github.com/fergustaylor/Arran/raw/master/docs/CopyOfREADME.md)
