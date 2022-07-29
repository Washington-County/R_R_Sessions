#### Shiny (Part I) ----

## Mastering Shiny - https://mastering-shiny.org/ ----

## Install
install.packages("shiny")
library(shiny)

## App directory - create app directory and files
## Put a single file called app.R in it. 


#### Part II ----

## Chapter 6 - an ER Case Study
library(shiny)
library(vroom)
library(tidyverse)

## Get data
dir.create(here::here("data", "neiss"))
download <- function(name) {
  url <- "https://github.com/hadley/mastering-shiny/raw/master/neiss/"
  download.file(paste0(url, name), paste0(here::here("data/neiss/"), name), quiet = TRUE)
}
download("injuries.tsv.gz")
download("population.tsv")
download("products.tsv")

## Load data
injuries <- vroom::vroom(here::here("data/neiss", "injuries.tsv.gz"))
products <- vroom::vroom(here::here("data/neiss", "products.tsv"))                         
population <- vroom::vroom(here::here("data/neiss", "population.tsv"))

## Exploration
selected <- injuries %>% filter(prod_code == 649)

## Join
summary <- selected %>% 
  count(age, sex, wt = weight) %>% 
  left_join(population, by = c("age", "sex")) %>% 
  mutate(rate = n / population * 1e4)

summary

summary <- selected %>% 
  count(age, sex, wt = weight)
summary


summary %>% 
  ggplot(aes(age, n, colour = sex)) + 
  geom_line() + 
  labs(y = "Estimated number of injuries")

summary <- selected %>% 
  count(age, sex, wt = weight) %>% 
  left_join(population, by = c("age", "sex")) %>% 
  mutate(rate = n / population * 1e4)

summary %>% 
  ggplot(aes(age, rate, colour = sex)) + 
  geom_line(na.rm = TRUE) + 
  labs(y = "Injuries per 10,000 people")

#prototype
source("scripts/er_shiny_app", "app.R")

injuries %>%
  mutate(diag = fct_lump(fct_infreq(diag), n = 5)) %>%
  group_by(diag) %>%
  summarise(n = as.integer(sum(weight)))


                         
## TODO - replace code in the server call with this 
count_top <- function(df, var, n = 5) {
  df %>%
    mutate({{ var }} := fct_lump(fct_infreq({{ var }}), n = n)) %>%
    group_by({{ var }}) %>%
    summarise(n = as.integer(sum(weight)))
}

output$diag <- renderTable(count_top(selected(), diag), width = "100%")
output$body_part <- renderTable(count_top(selected(), body_part), width = "100%")
output$location <- renderTable(count_top(selected(), location), width = "100%")