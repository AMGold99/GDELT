#===============================
#
#   Query GDELT protest data
#   'gdelt-bq.full.events_partitioned
#   'BQ project: another-test
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
# setwd("/home/[username]/GDELT")

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

# view tables within the database connection
DBI::dbListTables(con)



# design SQL query
sql <- "SELECT * FROM `events_partitioned`
        WHERE _PARTITIONTIME > '2000-01-01' 
              AND 
              _PARTITIONTIME < '2000-01-04'"


# CAUTION: BILLABLE
# execute query and create dataframe
df <- dbGetQuery(conn = con,
                 statement = sql)



