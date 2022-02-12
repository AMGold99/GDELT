#===============================
#
#   Second Test BigQuery Project
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
test_token_location <- file.path(getwd(),"tokens","another-test-341117-c766203d1673.json")

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

DBI::dbListTables(con)
