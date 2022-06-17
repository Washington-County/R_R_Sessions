## The central script for processing the project's data. 
## This includes renaming, recoding, formatting, transforming, and joining data.


## Create a dataframe for processing based on the source you read in
#data <- data_source

## EXAMPLES of processing data

## Rename variables - make all names snake case and remove conventions (e.g. "exp_person_") you don't want to keep
#data %<>% 
#  standardize_names() # custom function in the 'functions.R' script

## Rename any odd variable names
#data %<>%
#  rename(my_new_variable_name = my_original_variable_name)


## Create a new variable based on logic
#data %<>% 
#  mutate(
#    my_new_variable = 
#     case_when(my_original_variable == 1 &
#               my_other_variable == "this phrase" ~ 1,
#               TRUE ~ 0))

## Filter the datadrame to keep the records you need for output
# data_final <- data

# data_final %<>%
#   filter(my_new_variable == 1 &
#         is.na(my_other_variable))

## Select the variables you want to keep in the dataframe
#data_final %<>%
#  select(my_variables_to_keep)

## Change the order of certain variables
#data_final %<>%
#  relocate(my_fav_variable, .before = my_less_fav_variable)
