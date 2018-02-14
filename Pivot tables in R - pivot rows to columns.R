# clean up the environment

rm(list = ls())

# we'll need dplyr and tidyr for this, by far easier than with base R

library(dplyr)
library(tidyr)

# read in the Canadian SuperStore dataset from this dropbox address:

df <- read.csv("https://www.dropbox.com/s/kj9yioc24iq4pdb/superstore.csv?dl=1")
write.csv(df, "superstore.csv")


# in a previous tutorial we created a summary table with this dplyr code, summarising
# sales by product category, region and customer segment: 

pivot2 <- df %>% 
  select(Product.Category, Region, Customer.Segment, Sales) %>% 
  group_by(Product.Category, Region, Customer.Segment) %>% 
  summarise(TotalSales = sum(Sales))

head(pivot2)

# let's emulate an Excel pivoting, by spreading out the  regions to 
# seperate columns. 
# we use the TidyR "spread" function to summarize the region in columns: 

pivot2 %>% 
  spread(Region, TotalSales)
