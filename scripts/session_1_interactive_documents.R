## Session 1: Interactive Documents: Rmarkdown 
## Date: June 17, 2022

## See 'session_1_Rmarkdown_Report.R in the scripts folder 
## for our examples of building an rmarkdown report

#### Generate the Rmarkdown Report we created ---- 

## Establish a folder for outputs within the project directory
my_report_output_dir <- str_c(here::here("outputs/reports"))

## if the directory doesn't exist, create the folders.
if(!fs::dir_exists(my_report_output_dir)) fs::dir_create(my_report_output_dir)

## create today's date for the output name
output_date <- paste0(format(Sys.Date(), "%m%d%Y"))

#### NOTE: Change the name of the report so that it points at your .Rmd file and is named how you want it

## Date-based link for versioning
rmarkdown::render(input = here::here("scripts", "session_1_Rmarkdown_Report.Rmd"),
                  output_file = file.path(my_report_output_dir,
                                          str_c("Session 1 Rmarkdown Report - ", output_date, ".html", sep = '')))


