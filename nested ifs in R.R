# pre-session options

rm(list = ls())
 #getwd()
 #setwd("C:\\Users\\User\\Documents")

if (!require(dplyr)) install.packages('dplyr')
library(dplyr)

campaigns <- read.csv("https://www.dropbox.com/s/gv83asx8qeuog0z/google%20campaigns.csv?dl=1")
write.csv(campaigns, "campaigns.csv")


# let's create a 4 level bin for the campaign spend, based
# on the cost: 

campaigns$size <-  ifelse(campaigns$Cost <=1000, "small", 
                   ifelse(campaigns$Cost<=5000, "medium", 
                   ifelse(campaigns$Cost<=10000, "large",      
                   "reallyhuge!")))
                     

# lets see how this can look with dplyr

campaigns$size = NULL #delete the column and redo

campaigns <- campaigns %>% 
            mutate(size = ifelse(campaigns$Cost <=1000, "small", 
                          ifelse(campaigns$Cost<=5000, "medium", 
                          ifelse(campaigns$Cost<=10000, "large",      
                          "reallyhuge!"))))



# BUT, there is a cooler way to do it in dplyr. dplyr is built with more than a little 
# sql logic to it, and it has a built in case statement sytax to simplify nested ifs: 

campaigns$size = NULL #delete the column and redo

campaigns <- campaigns %>% 
                mutate(size = case_when(Cost<=1000 ~ "small",
                                        Cost<=5000 ~ "medium", 
                                        Cost<=10000 ~"large", 
                                        Cost>10000 ~ "reallyhuge!"))

