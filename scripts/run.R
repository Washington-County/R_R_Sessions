## The script that runs all of the scripts needed to produce the core project's deliverables

## Use the source function to run the scripts. Use the 'here' package to find the scripts based on the relative path.
source(here::here("scripts", "utilities.R"))  
source(here::here("scripts", "functions.R")) 
source(here::here("scripts", "get_data.R"))
source(here::here("scripts", "process_data.R"))
source(here::here("scripts", "output_data.R"))
