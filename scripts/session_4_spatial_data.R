#### Tidycensus ----

library(tidycensus)
options(tigris_use_cache = TRUE) # tells tidycensus to use previous pulls


census_api_key("9f5efb33f620fd123bdf0830cf4751921eaf80c0", install = TRUE, overwrite = TRUE)

acs_20_variables <- load_variables(2020, "acs5", cache = TRUE)


## Get County population estimate for Washington
acs_pop_wash <- get_acs(geography = "county", 
                        variables = "B01003_001",
                        state = "OR", 
                        county = "Washington", 
                        geometry = TRUE)

## Get population estimates by Race - alone or in combination with other races
acs_pop_race_wash <- 
  get_acs(geography = "county", 
          variables = c(
            `White - Alone or Multi Estimate` = "B02008_001",
            `Black or African American - Alone or Multi Estimate` = "B02009_001",
            `American Indian and Alaskan Native - Alone or Multi Estimate` = "B02010_001",
            `Asian - Alone or Multi Estimate` = "B02011_001",
            `Native Hawaiian and Pacific Islander - Alone or Multi Estimate` = "B02012_001",
            `Other Race - Alone or Multi Estimate` = "B02013_001",
            `Hispanic or Latino Estimate` = "B03003_003"),
          summary_var = c(`Total Population` = "B01003_001"),
          state = "OR", 
          county = "Washington", 
          geometry = TRUE)

acs_pop_race_wash %<>% 
  mutate(pct = estimate / summary_est) %>%
  relocate(pct, .after = summary_est)


#### Get Census Tract estimates ----

## Estimates for Washington
acs_pop_tract <- get_acs(geography = "tract", 
                         variables = "B01003_001",
                         state = "OR", 
                         county = "Washington", 
                         geometry = TRUE)

acs_pop_tract_no_geom <- get_acs(geography = "tract", 
                                 variables = "B01003_001",
                                 state = "OR", 
                                 county = "Washington", 
                                 geometry = FALSE)

#### sf package ----
library(sf)
library(dplyr)
library(ggplot2)
library(leaflet)
library(scales)
library(ggmap)


## Read in shapefile using sf
ak_regions <- read_sf("data/shapefiles/ak_regions_simp.shp")

plot(ak_regions)  

class(ak_regions)

## View coordinate system
st_crs(ak_regions)

## Transform coordinate system
ak_regions_3338 <- ak_regions %>%
  st_transform(crs = 3338)

plot(ak_regions_3338)

summary(ak_regions_3338)

## Spatial Join with population estimate
pop <- read.csv("data/shapefiles/alaska_population.csv")

pop_4326 <- st_as_sf(pop, 
                     coords = c('lng', 'lat'),
                     crs = 4326,
                     remove = F)

head(pop_4326)

st_crs(ak_regions_3338)

pop_joined <- st_join(pop_4326, ak_regions_3338, join = st_within)
## this won’t work right now because our coordinate reference systems are not the same.

pop_3338 <- st_transform(pop_4326, crs = 3338)

pop_joined <- st_join(pop_3338, ak_regions_3338, join = st_within)

head(pop_joined)

## Group and sum
pop_region <- pop_joined %>% 
  as.data.frame() %>% 
  group_by(region) %>% 
  summarise(total_pop = sum(population))

pop_region_3338 <- left_join(ak_regions_3338, pop_region)

head(pop_region)

## Save the data + geometry
write_sf(pop_region_3338, "shapefiles/ak_regions_population.shp", delete_layer = TRUE)

## Ggplot
ggplot(pop_region_3338) +
  geom_sf(aes(fill = total_pop)) +
  theme_bw() +
  labs(fill = "Total Population") +
  scale_fill_continuous(low = "khaki", high =  "firebrick", labels = comma)

## Read shapefile of rivers
rivers_3338 <- read_sf("data/shapefiles/ak_rivers_simp.shp")
## Check coordinate system
st_crs(rivers_3338)

## GGplot
ggplot() +
  geom_sf(data = pop_region_3338, aes(fill = total_pop)) +
  geom_sf(data = rivers_3338, aes(size = StrOrder), color = "black") +
  geom_sf(data = pop_3338, aes(), size = .5) +
  scale_size(range = c(0.01, 0.2), guide = F) +
  theme_bw() +
  labs(fill = "Total Population") +
  scale_fill_continuous(low = "khaki", high =  "firebrick", labels = comma)



#### Use SF package to process spatial data ----
spatially_process_alert_data <- function(df_alert, df_acs){
  
  ## Use the alert data frame of your choosing to do spatial processing
  df_alert_geo <- df_alert
  
  ## Remove records missing lat/long
  df_alert_geo %<>%
    filter(!is.na(latitude) &
             !is.na(longitude))
  
  ## Convert alert_geo into a spatial version of our data
  df_alert_sf <- sf::st_as_sf(df_alert_geo, coords = c("longitude", "latitude"), crs = 4269) #, agr = "constant")
  
  ## Check the spatial coordinate reference system
  # sf::st_crs(df_sf)
  
  ## Set coordinate system as NAD83 to match ACS
  #df_alert_sf <- sf::st_transform(df_alert_sf, 4269) 
  
  ## Aggregate the ACS population estimate at the GEOID level
  df_acs_sum <- df_acs %>% 
    group_by(GEOID, NAME) %>% 
    summarise(estimate = my_sum(estimate),
              summary_est = my_mean(summary_est))
  
  ## Check if the coordinate systems match
  #sf::st_crs(df_acs_sum) == sf::st_crs(df_sf)
  
  #### Spatial joins ----
  df_alert_acs_tract_join <- st_join(df_acs_sum, df_alert_sf)  
  
  #df_tigris_tract_join <- st_join(tigris_wash, df_sf)
  
  ## Filter out the records that did not overlap with tigris tracts
  #df_tigris_tract_join %<>%
  #  filter(COUNTYFP == "067")
  
  #### Intersection -----
  
  ## Use Intersection to check if the records in ALERT are spatially within WashCo Tracts
  # df_alert_intersects <- df_alert_sf[unlist(sf::st_intersects(df_acs_sum, df_alert_sf)), ]
  
  ## create a dataframe for those records that did not intersect with the WashCo Tracts
  # df_alert_non_intersects <- df_alert_sf[!lengths(sf::st_intersects(df_alert_sf, df_acs_sum)), ]
  
  return(list(
    
    df_acs_sum, 
    df_alert_acs_tract_join))
  
}

aggregate_spatial_alert_data <- function(df_alert_acs_tract_join){
  
  df_alert_acs_tract_counts <- df_alert_acs_tract_join %>% 
    group_by(GEOID, NAME) %>% 
    summarise(
      Total_Doses_Administered = my_sum(dose),
      Total_People_Vaccinated = my_sum(count),
      Total_People_Partially_Vaccinated = my_sum(partially_vaccinated),
      Total_People_Fully_Vaccinated = my_sum(fully_vaccinated),
      Population = my_mean(estimate),
      Pct_Population_Vaccinated = Total_People_Vaccinated / Population,
      Rate_Population_Vaccinated_per100 = round(Pct_Population_Vaccinated * 100, digits = 0),
      People_Remaining = Population - Total_People_Vaccinated)
  
  return(list(df_alert_acs_tract_counts)) 
  
}


