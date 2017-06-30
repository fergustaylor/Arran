# Arran

## Introduction
This is an early project based on SIMD data that I'm using to learn R.
For this I intend to explore 'ggplot2' to incorporate a set of skills I'm attempting to learn through a combination of DataCamp courses, RStudio 'Cheat Sheets' and twitter.

### Early progress

Initially I used map cordinates given by Ordinance Survey to find the centre of any KA27 postcode on a map.
(KA27 being the prefix or 'postcode area' that relates to all Aran Island postcodes).
I used the function 'geom_point' to plot these postcodes as points on a map.

![Point coordinates](https://github.com/fergustaylor/Arran/blob/master/docs/Rplot03.png)

Actually in reality, I first plotted the entire map section (NR) before taking a shockingly large amount of time to work out how to filter the postcodes down futher.

![Point coordinates whole map](https://github.com/fergustaylor/Arran/blob/master/docs/Rplot02.png)

I then used SIMD 'DataZone boundraries' and plotted their ERSI Shapefiles using 'geom_sf.' I then coloured and labelled the individual data zones, and overlayed some 'percentile' data about the areas.

![DZ Outlines](https://github.com/fergustaylor/Arran/blob/master/docs/Rplot04.png)

![DZ Outlines2](https://github.com/fergustaylor/Arran/blob/master/docs/Rplot05.png)

![DZ Outlines Colourewd](https://github.com/fergustaylor/Arran/blob/master/docs/Rplot06.png)

![DZ Outlines Colourewd](https://lh4.googleusercontent.com/zJB20WDsULWK_osc0Z8dDYY3GJ_b8hCHU4lr8VmSmHIuzl5IfCtR1jT_Mm9ot8g9CbQ8TJaI8cb5pJs=w2280-h1398-rw)

After faffing about with individual shape files for every year. (The data zone labels changed after 2012), I then did the same for all the SIMD data periods.
I then added multiplot to add them together.

![Multiplot plot](https://github.com/fergustaylor/Arran/blob/master/docs/Rplot.png)

### Example coding
```yml
title: [The title of your site]
description: [A short description of your site's purpose]
```
### Other examples

If you'd like to add lists:

1. Bullet-pointing
