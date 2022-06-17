#### custom functions ----

## This script contans custom written functions that are optional and may be useful, but also may not be relevant/needed for any particular project

## Standardize variable names to lower case with an underscore separator and removing unneeded prefixes & suffixes
standardize_names <- function(df){
  
  df %>%
    janitor::clean_names() %>%
    rename_with(~ gsub('^exp_person_', '', .x)) %>% 
    rename_with(~ gsub('^reald_', '', .x)) %>% 
    rename_with(~ gsub('^exp_admission_', '', .x)) %>%
    rename_with(~ gsub('^exp_lab_', '', .x)) %>%
    rename_with(~ gsub('_txt$', '', .x)) %>% 
    rename_with(~ gsub('_text$', '', .x)) %>%
   #rename_with(~ gsub('_name$', '', .x)) %>%
    rename_with(~ gsub('_code$', '', .x)) %>%
    rename_with(~ gsub('_if_yes_specify$', '', .x))
}  

## Display the dataframes currently loaded in your global R environment
list_data_frames <- ls()[sapply(ls(), function(x) any(is.data.frame(get(x))))]

## Create a function to modify our dataframes with all of the dates for the time period specified
complete_dates <- function(df, date_start, date_end, date_variable, count_variable){
  
  date_start <- enquo(date_start)
  date_end   <- enquo(date_end)
  date_variable <- enquo(date_variable)
  count_variable <- enquo(count_variable)
  
  # Create default column names
  count_variable_nm <- as_label(count_variable)
  
  df %>%
    mutate(date = as.Date(!!date_variable)) %>% 
    complete(date = seq.Date(as.Date(!!date_start), as.Date(!!date_end), by = "day")) %>% 
    mutate(!!count_variable_nm := case_when(is.na(!!count_variable) ~ 0, TRUE ~ !!count_variable)) %>% 
    mutate(date = as.POSIXct(as.character(date)))  
}

  
## convenient aggregation functions
my_sum <- function(x, ..., na.rm = TRUE){
  
  base::sum(x, na.rm = na.rm)
}

my_mean <- function(x, ..., na.rm = TRUE){
  
  base::mean(x, na.rm = na.rm)
}

my_median <- function(x, ..., na.rm = TRUE){
  
  base::median(x, na.rm = na.rm)
}

## Formatted  aggregating functions
my_sum_round <- function(x, ..., na.rm = TRUE){
  
  base::format(
    base::round(
      base::sum(x, na.rm = na.rm), digits = 0),
    big.mark = ",", big.interval = 3)
}

my_distinct <- function(x){
  
  base::format(
    base::round(
      dplyr::n_distinct(x), digits = 0),
    big.mark = ",", big.interval = 3)
}

my_mean_round <- function(x, ..., na.rm = TRUE){
  
  base::round(base::mean(x, ..., na.rm = na.rm), digits = 1)
}

my_pct <- function(x, ...){
  base::paste(base::round(x*100, digits = 1), "%", sep = "")
}

my_table <- function(df, variable){
  
  variable <- enquo(variable)
  
  df %>%
    tabyl(!!variable) %>%
    adorn_pct_formatting(digits = 1) %>%
    arrange(desc(n)) %>%
    knitr::kable(format = "html", align = 'r') %>%
    kableExtra::kable_styling(full_width = FALSE, position = "left")
}

my_tabyl <- function(df, variable){
  
  variable <- enquo(variable) 
  
  df %>%
    tabyl(!!variable) %>%
  View()
  
  }

my_crosstabyl <- function(df, variable, ...){
  
  variable <- enquo(variable)
  
  df %>% 
    tabyl(!!variable, ...) %>%   
    adorn_totals(where = c("row","col")) %>% 
    adorn_percentages(denominator = "col") %>% 
    adorn_pct_formatting(digits = 1) %>% 
    adorn_ns(position = "front")
  
}

my_crosstabyl_pct <- function(df, variable, ...){
  
  variable <- enquo(variable)
  
  df %>% 
    tabyl(!!variable, ...) %>%
    adorn_percentages() %>%
    adorn_pct_formatting()
  
}


my_datatable <- function(df, variable){
  
  variable <- enquo(variable)
  
  df %>%
    group_by(!!variable) %>%
    summarise(count = n()) %>%
    DT::datatable(options = list(order = list(list(2, 'desc')), pageLength = 50)) 
}

my_aggregates <- function(df, group_by_variable, variable){
  
  group_by_variable <- enquo(group_by_variable)
  variable <- enquo(variable)
  
  df %>%
    group_by(!!group_by_variable) %>%
    summarise(Sum    = my_sum(!!variable),
              Mean   = my_mean(!!variable),
              Min    = min(!!variable),
              Max    = max(!!variable))
  
}

my_scatter_plot <- function(df, variable_x, variable_y){
  
  variable_x <- enquo(variable_x)
  variable_y <- enquo(variable_y)
  
  df %>% 
    ggplot(aes(x = !!variable_x, 
               y = !!variable_y)) +
    geom_point() +
    geom_smooth(method='lm')  
}

my_bar_plot <- function(df, variable_x, variable_y){
  
  variable_x <- enquo(variable_x)
  variable_y <- enquo(variable_y)
  
  df %>% 
    ggplot(aes(x = !!variable_x, 
               y = !!variable_y)) +
    geom_bar(stat = "identity") +
    geom_text(aes(label = !!variable_y), 
              vjust = 1.8, 
              color = "white",
              size = 3.0) +
    theme_minimal()
}

my_race_bar_plot <- function(df, variable_y){
  
  if (!all(c("race", "race_nh", "Race", "raceNH", "reald_race_rr", "reald_race_mr", "reald_race_rr_imputed", "reald_race_mr_imputed") %in% names(df))) {
    stop("`df` must contain columns for the recoded broad race categories")
  }
  
  variable_y <- enquo(variable_y)
  
  df %>% 
    ggplot(aes(x = reald_race_imputed, 
               y = !!variable_y)) +
    geom_bar(stat = "identity") +
    geom_text(aes(label = !!variable_y), 
              vjust = 0, 
              color = "black",
              size = 3.5) +
    theme_minimal() +
    scale_x_discrete(labels=c("American Indian and Alaska Native" = "AIAN",
                              "Black or African American" = "Black",
                              "Hispanic or Latino/a/x" = "LatinX",
                              "Middle Eastern and North African" = "MENA",
                              "Native Hawaiian and Pacific Islander" = "NHPI"))
}

