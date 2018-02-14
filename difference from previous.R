df <- read.csv("https://www.dropbox.com/s/uhp0ne0rdxk9k7r/stocks.csv?dl=1")
library(dplyr)
library(tidyr)

df1 <- df %>% 
  select (Date, Adj.Close, stock) %>% 
  group_by(stock) %>% 
  mutate(DiffPrev = Adj.Close - lag(Adj.Close)) %>% 
  mutate(DiffPrevPercent = (Adj.Close - lag(Adj.Close))*100/Adj.Close) 

df1


