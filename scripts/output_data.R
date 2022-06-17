#### Generate Reports ---- 

## Establish a folder for outputs within the project directory
#my_report_output_dir <- str_c(here::here("outputs/reports"))

## if the directory doesn't exist, create the folders.
#if(!fs::dir_exists(my_report_output_dir)) fs::dir_create(my_report_output_dir)

## create today's date for the output name
#output_date <- paste0(format(Sys.Date(), "%m%d%Y"))

#### NOTE: Change the name of the report so that it points at your .Rmd file and is named how you want it

## Date-based link for versioning
#rmarkdown::render(input = here::here("scripts", "Name_of_My_Report.Rmd"),
#                  output_file = file.path(my_report_output_dir, 
#                                          str_c("Name of My Report - ", output_date, ".html", sep = '')))

  

                                          
#### Output processed data in spreadsheets ----                                         
                                          
## Establish a folder for outputs within the project directory
#my_data_output_dir <- str_c(here::here("outputs"))

## if the directory doesn't exist, create the folders.
#if(!fs::dir_exists(my_data_output_dir)) fs::dir_create(my_data_output_dir)

## create today's date for the output name
#output_date <- paste0(format(Sys.Date(), "%m%d%Y"))

## Create excel files - replace the sheet name and dataframe names with your actual data
#sheets <- list("My Sheet 1" = my_data_1, "My Sheet 2" = my_data_2)

#writexl::write_xlsx(sheets, path = file.path(my_data_output_dir,
#                                             str_c("Names of my Data - ", output_date, ".xlsx")))
