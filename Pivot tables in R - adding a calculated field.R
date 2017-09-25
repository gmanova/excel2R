# clean up the environment

rm(list = ls())

# we'll need dplyr and tidyr for this, by far easier than with base R

library(dplyr)
library(tidyr)

# read in the Canadian SuperStore dataset from this dropbox address:

df <- read.csv("C:/Users/User/Dropbox (Personal)/Personal/Courses/Excel2R/Dataframes/superstore.csv")
write.csv(df, "superstore.csv")

# in a previous tutorial, we created this summary table: 

pivot <- df %>% 
  select(Product.Category, Region, Customer.Segment, Sales)%>% 
  group_by(Product.Category, Region, Customer.Segment) %>% 
  summarise(TotalSales = sum(Sales), AvgSales = mean(Sales,na.rm = TRUE), 
            NumSales = length(!is.na(Sales)))

head(pivot) 

# Now, let's add a calculated column from two other columns and calculate 
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

# note that MUTATE can be used here (creating a new column) but since the new column is a summary
# operation, it can also simply be added to the summary function: 

pivot <- df %>% 
  select(Product.Category, Region, Customer.Segment, Sales, Profit)%>% 
  group_by(Product.Category, Region, Customer.Segment) %>% 
  summarise(TotalSales = sum(Sales), TotalProfit = sum(Profit), 
            AvgSales = mean(Sales,na.rm = TRUE), 
            NumSales = length(!is.na(Sales)),
            AvgProfitMar = sum(TotalProfit)/TotalSales) %>% 
  arrange(Region, desc(AvgSales))

head(pivot)
