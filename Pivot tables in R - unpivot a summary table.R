# clean up the environment

rm(list = ls())

# we'll need dplyr and reshape2 for this

library(dplyr)
library(reshape2)


# read in the sales dataset from this dropbox address and write the CSV to your machine:

df <- read.csv("C:/Users/User/Dropbox (Personal)/Personal/Courses/Excel2R/Dataframes/territory_sales.csv")
write.csv(df, "territory_sales.csv")



df_flat <- melt(df, "Country", variable.name = "Quarter",  value.name = "Sales") #variable.name = "Quarter"
write.csv(df_flat, "territory_sales_flat.csv")
       