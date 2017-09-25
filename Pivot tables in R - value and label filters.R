# clean up the environment

rm(list = ls())

# we'll need dplyr and tidyr for this, by far easier than with base R

library(dplyr)
library(tidyr)

# read in the Canadian SuperStore dataset from this dropbox address:

df <- read.csv("C:/Users/User/Dropbox (Personal)/Personal/Courses/Excel2R/Dataframes/superstore.csv")
write.csv(df, "superstore.csv")


# in a previous tutorial we created a summary table with this dplyr code, summarising
# sales by product category, region and customer segment: 

pivot2 <- df %>% 
  select(Product.Category, Region, Customer.Segment, Sales) %>% 
  group_by(Product.Category, Region, Customer.Segment) %>% 
  summarise(TotalSales = sum(Sales))

head(pivot2)



# first, let's create a label filter emulating a WHERE clause, so only sales > 10000$ will
# be taken into account: 

pivot2 <- df %>% 
  select(Product.Category, Region, Customer.Segment, Sales) %>%
  filter(Product.Category=="Furniture") %>% 
  group_by(Product.Category, Region, Customer.Segment) %>% 
  summarise(TotalSales = sum(Sales))

# same, but product category being EITHER Furniture OR Technology

pivot2 <- df %>% 
  select(Product.Category, Region, Customer.Segment, Sales) %>%
  filter(Product.Category=="Furniture"|Product.Category=="Technology") %>% 
  group_by(Product.Category, Region, Customer.Segment) %>% 
  summarise(TotalSales = sum(Sales))

# same, but product category being Furniture AND customer segment being Consumer

pivot2 <- df %>% 
  select(Product.Category, Region, Customer.Segment, Sales) %>%
  filter(Product.Category=="Furniture"& Customer.Segment=="Consumer") %>% 
  group_by(Product.Category, Region, Customer.Segment) %>% 
  summarise(TotalSales = sum(Sales))  

head(pivot2)
# now let's look at value filters, either before summing (=WHERE) or after (=HAVING)

# So to filter what goes "into" the summary tables (WHERE clause), introduce the filter BEFORE
# the summarise function: 

pivot2 <- df %>% 
  select(Product.Category, Region, Customer.Segment, Sales) %>%
  filter(Sales >= 10000) %>% 
  group_by(Product.Category, Region, Customer.Segment) %>% 
  summarise(TotalSales = sum(Sales))  

# So to filter the summary totals (HAVING clause), introduce the filter AFTER
# the summarise function: 

pivot2 <- df %>% 
  select(Product.Category, Region, Customer.Segment, Sales) %>%
  group_by(Product.Category, Region, Customer.Segment) %>% 
  summarise(TotalSales = sum(Sales)) %>% 
  filter(TotalSales >= 100000)

# and of course, can combine:

pivot2 <- df %>% 
  select(Product.Category, Region, Customer.Segment, Sales) %>%
  filter(Sales >= 10000) %>% 
  group_by(Product.Category, Region, Customer.Segment) %>% 
  summarise(TotalSales = sum(Sales)) %>% 
  filter(TotalSales >= 100000)


