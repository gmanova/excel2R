# pre-session options

rm(list = ls())
# getwd()
# setwd("C:/Users/your preferred path")

####### a simple case first, which works the same in Excel and in R  #######
####### trimming extra white spaces from start and end #####################

stringVec <- c("  David Johnson", " Jason Gardner ", "Emma Ferdinand  ")
write.csv(as.data.frame(stringVec), "stringVec.csv")
trimws(stringVec)

########## when the extra white space is in the middle - won't work ####
########## (unlike Excel) ##############################################

stringVec2 <- c("  David Johnson", " Jason    Gardner ", "Emma Ferdinand  ")
write.csv(as.data.frame(stringVec2), "stringVec2.csv")
trimws(stringVec2)

# what can be done here, is to get assistance from a regular expression operator
# (i.e. "regex", a big topic which i do not cover here)
# we need to use a regular expression \\s+ to eliminate whitespace repetition of more than 1

stringVec2 <- trimws(gsub("\\s+", " ", stringVec2))
stringVec2

# although there are more ways to do this, it's also a very convenient way to trim other unwanted 
# charecters if you know what they are. in this case, we'll get rid of all preceding, trailing and 
# repeating underscores: 

stringVec3 <- c("_David_Johnson", "_Jason____Gardner ", "Emma_Ferdinand__")

# we'll replace the underscores with spaces, trim, and then replace the remaining space delimiter 
# back to an underscore: 

stringVec3 <- gsub(" ", "_",(trimws(gsub("\\_+", " ", stringVec3))))

library(dplyr)
library(stringr)

stringVec3 <- c("_David_Johnson", "_Jason____Gardner ", "Emma_Ferdinand__")

stringVec3 <-  stringVec3 %>% 
  str_replace_all("\\_+"," ") %>% 
  str_trim(side = "both") %>% 
  str_replace_all(" ", "_")
