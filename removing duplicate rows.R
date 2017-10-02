# pre-session options

rm(list = ls())
# getwd()
# setwd("C:/Users/your preferred path")

###############  EXAMPLE 1 - with NA  ###################


library(ISLR)
df <- Hitters
write.csv(df, "baseball_hitters.csv")

# let's say we want to remove all instances where hitters played the same number of years
# and had the same number of home runs (for whatever reason)

# base R: 

df_deduped <- df[!duplicated(df[c("Years", "HmRun")]),]

# decypher: duplicated() returns a vector of true/false on the specified columns. passing that to 
# df yields the TRUE rows. 

# As usual, dplyr has something nicer and more intuitive to work with: 

# in dplyr: 

library(dplyr)

df_deduped_dplyr <-  df %>% 
                     distinct(Years, HmRun, .keep_all = TRUE)

# also try to see what happens if you don't specify .keep_all = TRUE. it will do the same - but 
# only keep the two relevant rows, which is not what we want (we want all the data, minus the
# rows with duped column)

# note that if you want to actually take a look at the duped values, it might be easier in base R
# simply use the above code without "!" :

df_duped <- df[duplicated(df[c("Years", "HmRun")]),]



