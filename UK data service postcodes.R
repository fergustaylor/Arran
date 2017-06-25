library(sf)
library(ggplot2) #development version!
library(tidyverse)

pcs <- read_sf("./Scotland_pcs_2011")

summary(pcs)

pcs %>%
  ggplot() +
  geom_sf()

pcs

arransubsect <- filter(pcs,substr(name,1,4)=="KA27")

arransubsect2 <- filter(pcs,substr(label,1,2)=="KA")

#Print Post codes lists
arransubsect <- filter(pcs,substr(label,1,4)=="KA27")
arransubsect %>%
  ggplot() +
  geom_sf()

geom_sf(arransubsect)

#Colour in post code maps (KA)
arransubsect2 %>%
  ggplot() +
  geom_sf(aes(fill = label))

#Colour in post code maps (Arran)
arransubsect %>%
  ggplot() +
  geom_sf(aes(fill = label))

#Colour in post code maps (Arran)
#No colour fill
arransubsect %>%
  ggplot() +
  geom_sf(aes())

#Print Post codes lists
arransubsect2 <- filter(pcs,substr(label,1,2)=="KA")
arransubsect2 %>%
  ggplot() +
  geom_sf()

geom_sf