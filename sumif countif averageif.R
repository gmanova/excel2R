setwd("C:/Users/User/Documents")
# pre-session options

rm(list = ls())
getwd()
setwd("C:/Users/your preferred path")

library(ISLR)
library(dplyr)

Hitters

write.csv(Hitters, "Hitters.csv")

# to sumif, or sumifs (and, or) we need to construct a vector of the filtered
# values first, and then use a sum/average/length etc. operator on it: 


# lets see which hitters saw a lot of action (AtBat) but did not hit with consistancy (hits)

BadHitters <- Hitters[Hitters$AtBat>=400 & Hitters$Hits <= 100,][,1:2]

sum(BadHitters[,1])
sum(BadHitters[,2])
mean(BadHitters[,1])
sd(BadHitters[,2])

# Something neat in R which is harder to do in Excel, is use an OR operator: 
# let’s sumif AtBats for hitters who are under 300 AtBats OR over 600 AtBats: 

HighLowHitters <- Hitters[Hitters$AtBat>=600 | Hitters$AtBat <= 300,][,1:2]
sum(HighLowHitters[,1])

# you can also get these operators to run on all columns:

colSums(BadHitters)[1:2]
colMeans(BadHitters)[1:2]



# recall that count is trickier in R, we use which to discard NA values from the count

length(!is.na(BadHitters)[,1])

# and same with dplyr, this time using an AND operator instead of OR: 

Hitters %>%
  filter(AtBat >= 400 & Hits <=100) %>%
  select(AtBat, Hits) %>%
  summarise(sumAB = sum(AtBat), sumH = sum(Hits))

# now let's sum up the At Bats for batters whose names start with Ch:
# note that the batter names in this data set are not an actual data column, 
# rather a seperate entity called "rownames", and the first charechter is always a hyphen: 

startsWith(rownames(Hitters), "-Ch")


# note that this creates a boolean vector with some "Trues", so applying this to the AtBat 
# is the equivalent of a sumif-starts with CH: 

Hitters %>%
  filter(startsWith(rownames(Hitters), "-Ch"))%>%
  select(AtBat)%>%
  summarise(sumAB = sum(AtBat))



# in base R: 

sum(Hitters$AtBat[startsWith(rownames(Hitters), "-Ch")])



