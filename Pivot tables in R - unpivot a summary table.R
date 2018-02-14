# clean up the environment

rm(list = ls())

# we'll need dplyr and reshape2 for this

library(dplyr)
library(reshape2)


# read in the sales dataset from this dropbox address and write the CSV to your machine:

df <- read.csv("https://www.dropbox.com/s/q7tqy4d7cq1f67q/territory_sales.csv?dl=1")
write.csv(df, "territory_sales.csv")



df_flat <- melt(df, "Country", variable.name = "Quarter",  value.name = "Sales") #variable.name = "Quarter"
write.csv(df_flat, "territory_sales_flat.csv")
       