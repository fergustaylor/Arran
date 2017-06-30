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

---
title: "README2"
runtime: shiny
output: html_document
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

This R Markdown document is made interactive using Shiny. Unlike the more traditional workflow of creating static reports, you can now create documents that allow your readers to change the assumptions underlying your analysis and see the results immediately. 

To learn more, see [Interactive Documents](http://rmarkdown.rstudio.com/authoring_shiny.html).

## Inputs and Outputs

You can embed Shiny inputs and outputs in your document. Outputs are automatically updated whenever inputs change.  This demonstrates how a standard R plot can be made interactive by wrapping it in the Shiny `renderPlot` function. The `selectInput` and `sliderInput` functions create the input widgets used to drive the plot.

```{r eruptions, echo=FALSE}
inputPanel(
  selectInput("n_breaks", label = "Number of bins:",
              choices = c(10, 20, 35, 50), selected = 20),
  
  sliderInput("bw_adjust", label = "Bandwidth adjustment:",
              min = 0.2, max = 2, value = 1, step = 0.2)
)

renderPlot({
  hist(faithful$eruptions, probability = TRUE, breaks = as.numeric(input$n_breaks),
       xlab = "Duration (minutes)", main = "Geyser eruption duration")
  
  dens <- density(faithful$eruptions, adjust = input$bw_adjust)
  lines(dens, col = "blue")
})
```

## Embedded Application

It's also possible to embed an entire Shiny application within an R Markdown document using the `shinyAppDir` function. This example embeds a Shiny application located in another directory:

```{r tabsets, echo=FALSE}
shinyAppDir(
  system.file("examples/06_tabsets", package = "shiny"),
  options = list(
    width = "100%", height = 550
  )
)
```

Note the use of the `height` parameter to determine how much vertical space the embedded application should occupy.

You can also use the `shinyApp` function to define an application inline rather then in an external directory.

In all of R code chunks above the `echo = FALSE` attribute is used. This is to prevent the R code within the chunk from rendering in the document alongside the Shiny components.

