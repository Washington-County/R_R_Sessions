## The central script for inputting data. 
## This script should contain spreadsheets that are read in as well as connections to APIs and relational databases.

data(mtcars)
data(iris)

#install.packages("datasets")
data(airquality)










#### Read in spreadsheet data ----
#my_data_sheet <- readxl::read_excel(here::here("data", "Name of Data.xlsx"),
#                                    sheet = "Sheet1")


#### SQL Server - Regional Data Mart ---- 

## NOTE: Uncommet and amend this code below if you're pulling data from the regional data mart.

# Connect to the Data Mart

## NOTE: this connection method is through the Multnomah 'multpartner' approach that uses a desktop shortcut when opening R
# con <- DBI::dbConnect(odbc::odbc(),
#                       Driver = "SQL Server",
#                       Server = "bienv-orpheus.multco.us//SQLSVR,2505",
#                       Database = "HD_ORPHEUS_UAT",
#                       Trusted_Connection = "True")

## Bring the data schema into R as a dataframe
# dm_schema <- DBI::dbGetQuery(con, 
#                              "SELECT * from information_schema.COLUMNS")


## Submit SQL query to the Data Mart for case info
#data_source <- DBI::dbGetQuery(con, 
#                                        SELECT 
#                                          CaseID
#                                        FROM  HD_ORPHEUS_UAT.OPERA.t_Case_Recent
#                                        WHERE 
#                                          DiseaseID = 165 AND
#                                          CountyName = 'Washington' AND
#                                          StatusCode in ('Confirmed', 'Presumptive')")



## NOTE: This setup connection is to Washington County's proxy server of the regional data mart
#con <- dbConnect(odbc::odbc(), "MultCoDataMart")

#case_pat_source <- DBI::dbGetQuery(con, 
#           "SELECT 
#              CaseID
#            FROM MultCoDataMart.HD_ORPHEUS_PRD.OPERA.t_Case_Recent
#            WHERE 
#                  DiseaseID = 165 AND
#                  CountyName = 'Washington' AND
#                  StatusCode in ('Confirmed', 'Presumptive')")
