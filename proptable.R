# pre-session options

rm(list = ls())
# getwd()
# setwd("C:/Users/your preferred path")

# load tidyr for pivoting: 

library(tidyr)

df <- read.csv(url("https://www.dropbox.com/s/ylf9bkctp5byu2m/proptable.csv?dl=1"),
                     skip = 0,
                     header = TRUE, 
                     stringsAsFactors = 0)



write.csv(df, "proptable.csv")


# first, create a pivot table: 

df <- df %>% 
  spread(OS, Installs)


# then create a prop table (proportion table) on rows (1) or on columns (2)
# VERY IMPORTANT! this only works on MATRICES, so you need to subset the table
# so only numeric columns will be in the subset!


df.prop.rows <- prop.table(as.matrix(df[,2:3]),1)  

df.prop.rows

# now, let's re-attach the country names: 

df.prop.rows <- cbind.data.frame("Country"=df[,1],df.prop.rows)

df.prop.rows

# let's have a look at columns: 

df.prop.cols <- prop.table(as.matrix(df[,2:3]),2)

df.prop.cols <- cbind.data.frame("Country"=df[,1],df.prop.cols)

df.prop.cols

# check your totals to see indeed amounts to 100%

rowSums(df.prop.rows[,2:3])
colSums(df.prop.cols[,2:3])
