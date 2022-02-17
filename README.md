# GDELT

Protest data from GDELT for Economics of Student Protest

## Under Construction

Scripts in this repo are test cases using sample data. No billing has been attached.

## Organization

### Code

Query scripts.
Example SQL query below. Sifts through data added between Jan 1 and Feb 1, 2010, and returns all education-related protest events occuring in the United States
```
SELECT * FROM `gdelt-bq.full.events_partitioned`
WHERE (
    (_PARTITIONTIME > "2010-01-01" 
    AND 
    _PARTITIONTIME < "2010-02-01") 
AND (`ActionGeo_CountryCode` = 'US') 
AND (
    REGEXP_CONTAINS(`Actor1Code`, 'EDU') 
    OR 
    REGEXP_CONTAINS(`Actor2Code`, 'EDU')
    )
AND `EventRootCode` = '14'
)
```

### Output

Resulting datatables.

## Navigating BigQuery

More to come.

## Creating a Project

More to come.

## Authentication

For security reasons (Google really doesn't like it when you publish service account tokens to a public GitHub repository), I am only storing the **tokens** directory in my private RStudio project. If you need to run the database connection, let me know. 

## Creating Service Account Token

After creating a project (and ensuring it is the currently selected one at the top of the page by the three hexagons), visit the **IAM & ADMIN** sidebar. Select **Service Accounts**. 

Near the top of the page, click **+ Create Service Account**. Enter your name and a brief description of what you will use the token for in the **Service account details** section, then click **CREATE AND CONTINUE**. 

In the second section, select the role of **Owner** from the dropdown list.

The third section can be skipped for now, but we may want to adjust permissions if more than one of us will be utilizing the token (which is probably not a good idea).

Once you click **DONE**, you will be taken back to the main **Service accounts** page within **IAM & Admin**. Here, click on the email of your service account. 

Select **KEYS** from the topbar. 

Click **ADD KEY**, then select **Create new key**. JSON should be the default format. If not, make sure JSON is selected, then click **CREATE**. This will initiate a download. Upload that downloaded .json file to your RStudio project directory. 

Now, when initiating a database connection, use the file path to that .json file to authenticate your account before creating the connection object and listing tables, etc.

```r
bigrquery::bq_auth(path = json_file_path) 
```

## Packages Required

-   [dplyr](https://dplyr.tidyverse.org/)
-   [DBI](https://dbi.r-dbi.org/)
-   [bigrquery](https://bigrquery.r-dbi.org/)
