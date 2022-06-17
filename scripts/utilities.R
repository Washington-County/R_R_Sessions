#### utilities - packages and dependencies ----

## Install packages if needed
list.of.packages <- c("DBI",
                      "bigrquery",
                      "dbplyr",
                      "DT",
                      "flextable",
                      "ggmap",
                      "ggplot2",
                      "ggpubr",
                      "gridExtra",
                      "here",
                      "janitor",
                      "kableExtra",
                      "knitr",
                      "leaflet",
                      "lubridate",
                      "magrittr",
                      "odbc",
                      "patchwork",
                      "plotly",
                      "readxl",
                      "rvest",
                      "scales",
                      "sf",
                      "skimr",
                      "summarytools",
                      "tidycensus",
                      "tidyverse",
                      "tigris",
                      "validate",
                      "writexl",
                      "zeallot",
                      "zoo")



new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

## Load package libraries

library(bigrquery)
library(DBI)
library(dbplyr)
library(DT)
library(flextable)
library(ggmap)
library(ggplot2)
library(ggpubr)
library(gridExtra)
library(here)
library(janitor)
library(kableExtra)
library(knitr)
library(leaflet) 
library(lubridate)
library(magrittr)
library(odbc)
library(patchwork)
library(plotly)
library(readxl)
library(rvest)
library(scales)
library(sf)
library(skimr)
library(summarytools)
library(tidycensus)
library(tidyverse)
library(tigris) 
library(validate)
library(writexl)
library(zeallot)
library(zoo)



## explicitly tell your R environment to use dplyr's function for select() since there are other packages have their own select() function
select <- dplyr::select



