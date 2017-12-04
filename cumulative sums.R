library(dplyr)
library(tidyr)
getwd()
df <- read.csv("https://www.dropbox.com/s/shcok8kh2vpnaet/cumsum.csv?dl=1")
write.csv(df, "cumsum.csv")

# in the most basic form it's very easy - use the cumsum() function from base R: 

df$cumsum <- cumsum(df$Sales)
df

# let's take a more realistic scenerio where you first pivot the data, and then add cumulative sum
#  (cumsum) and also the total sales and % of the total achieved (so called "running total") - 
# in this case there is only Date, so the cumulative runs over it

by_date <- df %>% 
  select(Date, Sales) %>% 
  group_by (Date) %>% 
  summarise(Sales=sum(Sales)) %>% 
  mutate(CumSales=cumsum(Sales)) %>% 
  mutate(totalSales = sum(Sales)) %>% 
  mutate(percent_of_total = cumsum(Sales)/sum(Sales)*100)

# in the second case, "state" is added , and the cumsum is reset for each state + date

by_date_2 <- df %>% 
  select(State, Date, Sales) %>% 
  group_by (State,Date) %>% 
  summarise(Sales=sum(Sales)) %>% 
  mutate(CumSales=cumsum(Sales)) %>% 
  mutate(totalSales = sum(Sales)) %>% 
  mutate(percent_of_total = cumsum(Sales)/sum(Sales)*100)

# in this case, we pivot rows to columns (with "spread") - and create corresponding 
# cumulative sums for each

by_date_3 <- df %>% 
  select(State, Date, Sales) %>% 
  group_by (State,Date) %>% 
  summarise(Sales=sum(Sales)) %>% 
  spread(State, Sales) %>% 
  mutate(CumCalifornia=cumsum(California)) %>% 
  mutate(CumFlorida=cumsum(Florida)) %>% 
  mutate(CumNewYork=cumsum(NewYork)) %>% 
  select(Date, California, CumCalifornia,Florida,CumFlorida,NewYork,CumNewYork)


         