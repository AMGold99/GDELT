#===============================
#
#   Test BigQuery Project
#   Asa Gold, Feb 2022
#
#===============================

# set to TRUE if you are okay with running billable code; 
# set to FALSE if you want warnings
billable <- TRUE 


####-------PREAMBLE----------------####

# load packages
# devtools::install_github("r-dbi/bigrquery")
library(dplyr)
library(DBI)
library(bigrquery)

# set working directory to project folder (only necessary to run if not in project)
setwd("/home/gold1/GDELT")

# specify location of service account token
test_token_location <- file.path(getwd(),"tokens","sound-essence-338916-4e13b1f2db43.json")

# authorize BigQuery connection w/ service account token
bigrquery::bq_auth(path = test_token_location) 

# NOTE: You need to create a new service account token for each project (not for each account)


####---------DATABASE CONNECTION--------------####

# create database connection object
con <- DBI::dbConnect(
  bigrquery::bigquery(),             # specify that connection will be to BigQuery
  project = "bigquery-public-data",  # table within the project
  dataset = "baseball",              # dataset within the table
  billing = "sound-essence-338916"   # project ID
)

# list tables contained within the database connection you just made
DBI::dbListTables(con)

# instatiate dataframe from table within database connection
skeds <- dplyr::tbl(con, "schedules")

# preview the dataframe
dplyr::glimpse(skeds)

# download actual data

if(billable) {
  
  available_teams <- skeds %>%
    dplyr::select(homeTeamName) %>%
    dplyr::filter(homeTeamName == "Reds") %>%
    dplyr::distinct() %>%
    dplyr::collect()
  
  # HELPFUL HINT: use show_query() to reveal the raw SQL query code
    dplyr::select(skeds, homeTeamName) %>%
    dplyr::distinct() %>%
    dplyr::show_query()
  
  
} else {
  stop("Warning! Billable set to false. Running this code would reduce free query quota.")
}

