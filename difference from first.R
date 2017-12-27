rm(list = ls())
#getwd()
#setwd("C:\\Users\\User\\Documents")

df <- read.csv("C:/Users/User/Dropbox (Personal)/Personal/Courses/Excel2R/Dataframes/stocks.csv")
write.csv(df, 'stocks.csv')

if (!require(dplyr)) install.packages('dplyr')
library(dplyr)

df1 <- df %>% 
  select (Date, Adj.Close, stock) %>% 
  group_by(stock) %>% 
  mutate(Day1 = first(Adj.Close)) %>% 
  mutate(DiffFromStart = Adj.Close-Day1) %>% 
  mutate(DiffFromStartPercent = Adj.Close/Day1)

df2


