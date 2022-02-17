#===============================
#
#   Second Test BigQuery Project
#   Uses GDELT-BQ data
#   Asa Gold, Feb 2022
#
#===============================


####-------PREAMBLE----------------####

# load packages
# devtools::install_github("r-dbi/bigrquery")
library(dplyr)
library(DBI)
library(bigrquery)
library(dbplyr)

# set working directory to project folder (only necessary to run if not in project)
setwd("/home/gold1/GDELT")

# specify location of service account token
test_token_location <- file.path(getwd(),"tokens","another-test-341117-c766203d1673.json")

# authorize BigQuery connection w/ service account token
bigrquery::bq_auth(path = test_token_location) 

# NOTE: You need to create a new service account token for each project (not for each account)


####---------DATABASE CONNECTION--------------####

# create database connection object
con <- DBI::dbConnect(
  bigrquery::bigquery(),             # specify that connection will be to BigQuery
  project = "gdelt-bq",              # database
  dataset = "full",                  # dataset within the table
  billing = "another-test-341117"
)

DBI::dbListTables(con)


events <- dplyr::tbl(con, "events_partitioned")
glimpse(events)

# design query
event_query <- events %>%              
  dplyr::select(dplyr::everything()) %>%
  dplyr::filter(
    `DATEADDED` > 20000101 & `DATEADDED` < 20000201, # still can't figure out PARTITIONTIME issue (it's a pseudocolumn, R won't recognize it)
    ActionGeo_CountryCode == "US",
    (str_detect(Actor1Code, "EDU") | str_detect(Actor2Code, "EDU"))
    ) %>%
  show_query()


# activate query and pull data into local memory
# CAUTION: BILLABLE
event_df <- event_query %>%
  dplyr::collect()

