# pre-session options

rm(list = ls())
# getwd()
# setwd("C:/Users/User/Documents")

###############  EXAMPLE 1 - with NA  ###################

# creating a small dataframe: 

df <- as.data.frame(
  cbind(
  c(LETTERS[1:7]),       
  (c(1,3,2,4,5,3,NA)),
  rnorm(7)
  )
  )
names(df) <- c("col1", "col2","col3")


# checking the structure and data types
str(df)

# write to csv to open in Excel

write.csv(df, "df.csv")

#LENGTH() IN R IS NOT THE SAME AS LEN() IN EXCEL! LENGTH() MEASURES THE LENGTH OF A VECTOR!

length(df$col3) #count elements in col3
length(df$col2) #count elements in col2
length(as.numeric(df$col2))

!is.na(df$col2) #return logical (TRUE/FALSE vector on non-NA's in col2)

which(!is.na(df$col2)) # which() returns the indexes of "true" in the vector
length(which(!is.na(df$col2))) # check the length of the vector 

################## EXAMPLE 2 - empty value instead of NA ########################

# creating a small dataframe: 

df1 <- as.data.frame(
  cbind(
    c(LETTERS[1:7]),       
    (c(1,3,2,4,5,3,"")),
    rnorm(7)
  )
)
names(df1) <- c("col1", "col2","col3")

# checking the structure and data types

str(df1)

# write to csv to open in Excel

write.csv(df1, "df1.csv")    

length(df1$col3) #count elements in col3
length(df1$col2) #count elements in col2

df1$col2 != "" #return logical (TRUE/FALSE vector on non-empty in col2)

which(df1$col2 != "") # use which() to return the indexes of the true in the logical vector
length(which(df1$col2 != "")) # check the length of the vector 

######################## summary ###########################

# long story short, in order to emulate an excel count() function, you need to figure out what it is
# you want to count first, then set filters accordingly within the length() function

length(which(!is.na(df$col2)))
length(which(df1$col2 != ""))

# so base R is not very friendly to count stuff. but the dplyr package helps: 

# if the %>% throws you off, think of it as "then", a connection which passes previous statment results to 
# the next statement

library(dplyr)

df %>% 
  summarise(col2 = n())

# so still, counts the NA, so let's deal with it in a neat way: 

df %>% 
  filter(!is.na(col2)) %>%
  summarise(col2 = n())

# first we select df, then filter only non- NA's, then summarise with count using the n() function
# it's still now where nearly as friendly as excel, but at least it makes sense. 


