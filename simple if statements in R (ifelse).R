# pre-session options

rm(list = ls())
 #getwd()
 #setwd("C:\\Users\\User\\Documents")


if (!require(dplyr)) install.packages('dplyr')
library(dplyr)

campaigns <- read.csv("https://www.dropbox.com/s/gv83asx8qeuog0z/google%20campaigns.csv?dl=1")
write.csv(campaigns, "campaigns.csv")


# let's create a simple bin for the campaign spend, either "material" or "negligible" base
# on the cost: 

campaigns$size <-  ifelse(campaigns$Cost >= 500, "material", "negligible")

campaigns
# lets see how this can look with dplyr

campaigns$size = NULL #deletes the column

campaigns <- campaigns %>% 
            mutate(size = if_else(campaigns$Cost >= 500, "material", "negligible"))


           