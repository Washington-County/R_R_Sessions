## Session 2: Interactive Documents - Rmarkdown, Flexdashboard, Shiny
## Date: July 1, 2022

#### Parameters in Rmarkdown ----



#### Flexdashboard ----

## Source: https://pkgs.rstudio.com/flexdashboard/

## install
install.packages("flexdashboard")
library(flexdashboard)

rmarkdown::draft(here::here("scripts", "flex_dashboard.Rmd"),
                 template = "flex_dashboard",
                 package = "flexdashboard")



#### Shiny ----

## Mastering Shiny - https://mastering-shiny.org/ ----

## Install
install.packages("shiny")
library(shiny)

## App directory - create app directory and files
## Put a single file called app.R in it. 




