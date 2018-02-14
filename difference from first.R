df <- read.csv("https://www.dropbox.com/s/uhp0ne0rdxk9k7r/stocks.csv?dl=1")
library(dplyr)
library(tidyr)

df1 <- df %>% 
  select (Date, Adj.Close, stock) %>% 
  group_by(stock) %>% 
  mutate(Day1 = first(Adj.Close)) %>% 
  mutate(DiffFromDay1 = Adj.Close*100/Day1)

df2


