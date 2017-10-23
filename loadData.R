# data_convert.R
# converts .sav files to R data frames and sends to PostgreSQL databse
# Bradley Wilson, last modified 6/30/17

root.dir <- "~/hrrp/openhrrp-src"
setwd(root.dir)

## Package loading, sourcing
library(haven)
library(RPostgreSQL)
library(dplyr)

###
data.folder <- paste0(root.dir, '/data')

readSavFile <- function(data.in, path.in) {
  # Loads HRHRP .sav file as a tbl_df
  data.out <- read_sav(paste(path.in, data.in, sep = "/"))
  return(data.out)
}

building <- as.data.frame(readSavFile("Building.sav", data.folder))
individual <- as.data.frame(readSavFile("Individual.sav", data.folder))
household <- as.data.frame(readSavFile("Household.sav", data.folder))
house_owner <- as.data.frame(readSavFile("House_Owner.sav", data.folder))


###
pg <- dbDriver("PostgreSQL")
con <- dbConnect(pg, user="postgres", password="postgres",
                 host="localhost", dbname="openhrrp")

##
dbWriteTable(con,'building', building, row.names=FALSE, overwrite = TRUE)
dbWriteTable(con,'individual', individualdf, row.names=FALSE, overwrite = TRUE)
dbWriteTable(con,'household', household, row.names=FALSE, overwrite = TRUE)
dbWriteTable(con,'house_owner', house_ownerdf, row.names=FALSE, overwrite = TRUE)
dbDisconnect(con)

dbDisconnect(con)



##






