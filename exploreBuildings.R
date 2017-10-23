# Exploration of building table from pgSql database
library(RPostgreSQL)
library(dplyr)

root.dir <- "~/hrrp/openhrrp-src"

pg <- dbDriver("PostgreSQL")
con <- dbConnect(pg, user="postgres", password="postgres",
                 host="localhost", dbname="openhrrp")

##
# dbExistsTable(con, "building")

df_building <- dbGetQuery(con, "SELECT * from building limit 5000; ")
df_building <- as.data.frame(sapply(df_building, as.numeric))

write.csv(as.data.frame(colnames(df_building)), file=paste0(root.dir, "/outputs/buildingColNames.csv"))

df_building_af <- as.data.frame(sapply(df_building, as.factor))


summarizeColumn <- function(column) {
  return (summary(column))
}

summarizeColumn(df_building_af$fam_cn)


##jsut a comment
