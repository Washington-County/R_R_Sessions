## Session 2: Interactive Documents - Rmarkdown, Flexdashboard, Shiny
## Date: July 5, 2022

#### Parameters in Rmarkdown ----

## Source: https://bookdown.org/yihui/rmarkdown/parameterized-reports.html

## See: General QA Report: K:\CD and ORPHEUS\Orpheus_exports_\COVID EXPORTS\Data Quality Project\Case-Data-Cleaning-2022\report_templates\General QA_Parametrized.Rmd


#### Flexdashboard ----

## Source: https://pkgs.rstudio.com/flexdashboard/

## See: COVID Metrics: K:\CD and ORPHEUS\Orpheus_exports_\COVID EXPORTS\Data Requests and Tasks\COVID-Metrics\COVID-Metrics\outputs\reports\Versioning\COVID Metrics Report - 06292022.html

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




