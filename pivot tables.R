# clean up the environment

rm(list = ls())

# we'll need dplyr and tidyr for this, by far easier than with base R

library(dplyr)
library(tidyr)

# read in the Canadian SuperStore dataset from this dropbox address:

df <- read.csv("C:/Users/User/Dropbox (Personal)/Personal/Courses/Excel2R/Dataframes/superstore.csv")
write.csv(df, "superstore.csv")

# with dplyr, pivoting data takes a very sql-like approach. let's say we wish to 
# pivot so we see the total sales per product category, region and customer segment. 
# in sql, it would be something like: 
  # SELECT Product.Category, Region, Customer.Segment, SUM(Sales)
  # FROM df
  # GROUP BY Product.Category, Region, Customer.Segment

# in dplyr, we follow a similar logic: 

# first select the columns

pivot <- df %>% 
  select(Product.Category, Region, Customer.Segment, Sales)

head(pivot)
# then group by

pivot <- df %>% 
  select(Product.Category, Region, Customer.Segment, Sales)%>% 
  group_by(Product.Category, Region, Customer.Segment)

# then tell R how to sum the sales (sum, count, average etcs): 

pivot <- df %>% 
  select(Product.Category, Region, Customer.Segment, Sales)%>% 
  group_by(Product.Category, Region, Customer.Segment) %>% 
  summarise(TotalSales = sum(Sales))

head(pivot)

# and here's our pivot "select" statement, so to speak. 
# let's add a few things, as we would in Excel pivot or sql - more computed columns,
# adding avg sales and number (count) of sales transactions: 

pivot <- df %>% 
  select(Product.Category, Region, Customer.Segment, Sales)%>% 
  group_by(Product.Category, Region, Customer.Segment) %>% 
  summarise(TotalSales = sum(Sales), AvgSales = mean(Sales,na.rm = TRUE), 
            NumSales = length(!is.na(Sales)))

head(pivot) 
# finally, let's add a calculated column from two other columns and calculate 
# profitability. we'll add "Profit" to the summarize function, and use profit/sales
# in the calculated column: 

pivot <- df %>% 
  select(Product.Category, Region, Customer.Segment, Sales, Profit)%>% 
  group_by(Product.Category, Region, Customer.Segment) %>% 
  summarise(TotalSales = sum(Sales), TotalProfit = sum(Profit), 
            AvgSales = mean(Sales,na.rm = TRUE), 
            NumSales = length(!is.na(Sales))) %>% 
  mutate(AvgProfitMar = sum(TotalProfit)/TotalSales) %>% 
  arrange(Region, desc(AvgSales))

head(pivot)

# let's emulate an Excel pivoting, by spreading out the  regions to 
# seperate columns. let's take the original pivot with just one metric, TotalSales:

  
pivot2 <- df %>% 
  select(Product.Category, Region, Customer.Segment, Sales) %>% 
  group_by(Product.Category, Region, Customer.Segment) %>% 
  summarise(TotalSales = sum(Sales))

head(pivot2)

# we use the TidyR "spread" function to summarize the region in columns: 

pivot2 %>% 
  spread(Region, TotalSales)

# finally, let's subset with filters, like you would in an excel pivot when 
# wanting to zero in on a particular category of data

furniture <- pivot2 %>% 
  filter(Product.Category=="Furniture")
  
furniture
