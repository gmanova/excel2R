# pre-session options

rm(list = ls())
 #getwd()
 #setwd("C:\\Users\\User\\Documents")

if (!require(stringr)) install.packages('stringr')
library(stringr)

campaigns <- read.csv("https://www.dropbox.com/s/gv83asx8qeuog0z/google%20campaigns.csv?dl=1")
write.csv(campaigns, "campaigns.csv")


# first do a simple split in order to understand how it looks: 

str_split("Android_Search_UK", "_") # splitting the text on underscore


# performing excel "text to column" to extract country this creates a LIST of split elements: 


split <- str_split(campaigns$Campaign, "_")


# take a look at the list: 

split

# this is a list of vectors. each list element "horizontally" is a charecter vector: 

class(split[[1]])
is.vector(split[[1]])

# now let's extract the list items vertically to proper columns in the data set: 

campaigns$network <- sapply(split, "[[", 1)
campaigns$platform <- sapply(split, "[[", 2)
campaigns$country <- sapply(split, "[[", 3)
campaigns$startDate <- sapply(split, "[[", 4)
campaigns$campaignType <- sapply(split, "[[", 5)


# now add as new column: 

campaigns

