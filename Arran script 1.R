library(sf)
library(ggplot2) #development version!
library(tidyverse)

#not really sure
Arran <- read_sf("./data")

NR_Building <- read_sf("./untitled")

NR_Foreshore <- read_sf("./untitled4")

NR_Foreshore %>%
  ggplot() +
  geom_sf()

NR_Foreshore %>%
  ggplot() +
  geom_sf(aes(fill = ID))