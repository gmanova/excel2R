# pre-session options

rm(list = ls())
 #getwd()
 #setwd("C:\\Users\\User\\Documents")

if (!require(stringr)) install.packages('stringr')
library(stringr)
if (!require(dplyr)) install.packages('dplyr')
library(dplyr)

campaigns <- read.csv("https://www.dropbox.com/s/gv83asx8qeuog0z/google%20campaigns.csv?dl=1")
write.csv(campaigns, "campaigns.csv")


# first lets see how a basic search works, and how to use it with/out case recognition:

grepl("ios","iOS_Search_UK") # yields 0 (FALSE) - the equivalent of "FIND()"
grepl("ios",tolower("iOS_Search_UK")) # yields 1 (TRUE) - the equivalent of "SEARCH()"

# and you can simply pass the ignore.case argument to handle case sensitivness:

grepl("ios","iOS_Search_UK", ignore.case = TRUE) # yields 1 (TRUE)


# Now let's create a new metadata column of which phone type: 

campaigns$PhoneType <-  ifelse(grepl("ios",campaigns$Campaign, ignore.case = TRUE), "iPhone", "Android")

# lets see how this can look with stringr and dplyr, which are very popular tidyverse packages: 

campaigns$PhoneType = NULL

str_detect(tolower(campaigns$Campaign), "ios")

campaigns <- campaigns %>% 
            mutate(PhoneType = 
                   if_else(str_detect(tolower(campaigns$Campaign), "ios"),"iPhone", "Android"))


# in case you actually want to know the index place in the vector where the expression 
# starts, like Find() or Search() in excel, you can use the str_locate() function
# which outputs a MATRIX of the start position and end position. so assuming you want the 
# start position: 

# base R: 

str_locate(campaigns$Campaign, "iOS")

# now this is a MATRIX, so we can extract the "start" column, and add it to the 
# dataset as a new column: 

#base R: 

campaigns$OS_Start <- str_locate(campaigns$Campaign, "iOS")[,1]

