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
  project = "gdelt-bq",              # database
  dataset = "full",                  # dataset within the table
)

DBI::dbListTables(con)
