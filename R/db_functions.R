# db_functions.R -- R functions to interact with  databases
# John Bannister
# Created 01/08/2015 -- see git for revision history
# 
# Functions related to database access and import into R. Specific to 
# db.airsci.com, although functions can be adapted to other databses.

#' Get data from owenslake database on db.airsci.com
#' 
#' @param query Text string. PostgreSQL query.
#' @return Data frame. The data returned from the query.
#' @examples
#' query_owenslake("SELECT * FROM archive.mfile_data")
query_owenslake <- function(query){
  usr <- readLines("~/config/credentials/airsci_db_cred.txt")[1]
  psswrd <- readLines("~/config/credentials/airsci_db_cred.txt")[2]
  con <- RPostgreSQL::dbConnect("PostgreSQL", host="192.168.22.42", 
                                dbname="owenslake", user=usr, password=psswrd)
  dat <- RPostgreSQL::dbGetQuery(con, query)
  RPostgreSQL::dbDisconnect(con)
  dat
}

writetable_owenslake <- function(df1, schema, tab){
  usr <- readLines("~/config/credentials/airsci_db_cred.txt")[1]
  psswrd <- readLines("~/config/credentials/airsci_db_cred.txt")[2]
  con <- RPostgreSQL::dbConnect("PostgreSQL", host="db.airsci.com", 
                                dbname="owenslake", user=usr, password=psswrd)
  caroline::dbWriteTable2(con, paste0(schema, ".",  tab), df=df1, fill.null=F, add.id=T, 
                          append=T, pg.update.seq=T)
  RPostgreSQL::dbDisconnect(con)
}

query_salton <- function(query){
  usr <- readLines("~/config/credentials/airsci_db_cred.txt")[3]
  psswrd <- readLines("~/config/credentials/airsci_db_cred.txt")[4]
  hst <- "airdbss1.cwxikzzkese5.us-west-2.rds.amazonaws.com"
  con <- RPostgreSQL::dbConnect("PostgreSQL", host=hst, port=5432,
                                dbname="saltonsea", user=usr, password=psswrd)
  dat <- RPostgreSQL::dbGetQuery(con, query)
  RPostgreSQL::dbDisconnect(con)
  dat
}

