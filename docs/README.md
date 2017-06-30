# Arran

## Introduction
This is an early project based on SIMD data that I'm using to learn R.
For this I intend to explore 'ggplot2' to incorporate a set of skills I'm attempting to learn through a combination of DataCamp courses, RStudio 'Cheat Sheets' and twitter.

### Early progress

Initially I used map cordinates given by Ordinance Survey to find the centre of any KA27 postcode on a map.
(KA27 being the prefix or 'postcode area' that relates to all Aran Island postcodes).
I used the function 'geom_point' to plot these postcodes as points on a map.

![Point coordinates](hhttps://github.com/fergustaylor/Arran/docs/Rplot03.png)

Actually in reality, I first plotted the entire map section (NR) before taking a shockingly large amount of time to work out how to filter the postcodes down futher.

![Point coordinates whole map](https://github.com/fergustaylor/Arran/blob/master/docs/Rplot02.png)

I then used SIMD 'DataZone boundraries' and plotted their ERSI Shapefiles using 'geom_sf.' I then coloured and labelled the individual data zones, and overlayed some 'percentile' data about the areas.

![DZ Outlines](https://github.com/fergustaylor/Arran/blob/master/docs/Rplot04.png)

![DZ Outlines2](https://github.com/fergustaylor/Arran/blob/master/docs/Rplot05.png)

![DZ Outlines Colourewd](https://github.com/fergustaylor/Arran/blob/master/docs/Rplot06.png)

![DZ Outlines Colourewd](https://github.com/fergustaylor/Arran/blob/master/docs/Rplot07.png)

After faffing about with individual shape files for every year. (The data zone labels changed after 2012), I then did the same for all the SIMD data periods.
I then added multiplot to add them together.

![Multiplot plot](https://github.com/fergustaylor/Arran/blob/master/docs/Rplot.png)

```yml
title: [The title of your site]
description: [A short description of your site's purpose]
```

Additionally, you may choose to set the following optional variables:

```yml
show_downloads: ["true" or "false" to indicate whether to provide a download URL]
google_analytics: [Your Google Analytics tracking ID]
```

### Stylesheet

If you'd like to add your own custom styles:

1. Create a file called `/assets/css/style.scss` in your site
2. Add the following content to the top of the file, exactly as shown:
    ```scss
    ---
    ---

    @import "{{ site.theme }}";
    ```
3. Add any custom CSS (or Sass, including imports) you'd like immediately after the `@import` line

### Layouts

If you'd like to change the theme's HTML layout:

1. [Copy the original template](https://github.com/pages-themes/minimal/blob/master/_layouts/default.html) from the theme's repository<br />(*Pro-tip: click "raw" to make copying easier*)
2. Create a file called `/_layouts/default.html` in your site
3. Paste the default layout content copied in the first step
4. Customize the layout as you'd like

## Roadmap

See the [open issues](https://github.com/pages-themes/minimal/issues) for a list of proposed features (and known issues).

## Project philosophy

The Minimal theme is intended to make it quick and easy for GitHub Pages users to create their first (or 100th) website. The theme should meet the vast majority of users' needs out of the box, erring on the side of simplicity rather than flexibility, and provide users the opportunity to opt-in to additional complexity if they have specific needs or wish to further customize their experience (such as adding custom CSS or modifying the default layout). It should also look great, but that goes without saying.

## Contributing

Interested in contributing to Minimal? We'd love your help. Minimal is an open source project, built one contribution at a time by users like you. See [the CONTRIBUTING file](CONTRIBUTING.md) for instructions on how to contribute.

### Previewing the theme locally

If you'd like to preview the theme locally (for example, in the process of proposing a change):

1. Clone down the theme's repository (`git clone https://github.com/pages-themes/minimal`)
2. `cd` into the theme's directory
3. Run `script/bootstrap` to install the necessary dependencies
4. Run `bundle exec jekyll serve` to start the preview server
5. Visit [`localhost:4000`](http://localhost:4000) in your browser to preview the theme

### Running tests

The theme contains a minimal test suite, to ensure a site with the theme would build successfully. To run the tests, simply run `script/cibuild`. You'll need to run `script/bootstrap` one before the test script will work.
