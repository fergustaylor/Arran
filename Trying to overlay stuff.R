library(sf)
library(ggplot2) #development version!
library(tidyverse)

pcs <- read_sf("alldata/Scotland_pcs_2011")

#Print Post codes lists
arransubsect <- filter(pcs,substr(label,1,4)=="KA27")
arransubsect %>%
  ggplot() +
  geom_sf()

#Colour in post code maps (Arran)
#No colour fill
arransubsect %>%
  ggplot() +
  geom_sf(aes())

## Plotting the Arran coordinates
ggplot(data = arrancoordinates) +
  geom_point(mapping = aes(x = longitude, y = latitude)) +
  ggtitle("Arran Postcodes") +
  labs(title = "Arran Postcodes", x = "Longitude", y = "Latitude") +
  theme(plot.title = element_text(hjust = 0.5))

#Colour in post code maps (Arran)
#No colour fill
arransubsect %>%
  ggplot() +
  geom_sf(aes())

ggplot(data = arrancoordinates) +
  geom_point(mapping = aes(x = longitude, y = latitude)) +
  ggtitle("Arran Postcodes") +
  labs(title = "Arran Postcodes", x = "Longitude", y = "Latitude") +
  theme(plot.title = element_text(hjust = 0.5))

  
  