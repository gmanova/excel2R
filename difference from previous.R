# pre-session options

rm(list = ls())
# getwd()
# setwd("C:\\Users\\User\\Dropbox (Personal)\\Personal\\Courses\\Excel2R\\Dataframes")

df <- read.csv("C:/Users/User/Dropbox (Personal)/Personal/Courses/Excel2R/Dataframes/stocks.csv")
write.csv(df, "stocks.csv")

library(dplyr)
library(tidyr)

df1 <- df %>% 
  select (Date, Adj.Close, stock) %>% 
  group_by(stock) %>% 
  mutate(DiffPrev = Adj.Close - lag(Adj.Close)) %>% 
  mutate(DiffPrevPercent = (Adj.Close - lag(Adj.Close))*100/lag(Adj.Close)) 

df1


