# pre-session options

rm(list = ls())
# getwd()
# setwd("C:\\Users\\User\\Dropbox (Personal)\\Personal\\Courses\\Excel2R\\Dataframes")


# create a dataframe of mtcars: 

mtcars <- data.frame(mtcars)

# since the car names are rownames, they are not "available" as a column - fixing that: 
# adding the car names as a column, and deleting the row names: 

mtcars$carName <- rownames(mtcars)
rownames(mtcars) <- NULL

# now let's import the lookup table: 

countries <- read.csv("https://www.dropbox.com/s/m6tkyuolbckkyb4/mtcars_countries.csv?dl=1")

write.csv(mtcars, "mtcars.csv")
write.csv(countries, "countries.csv")

# merge the lookup table to the main mtcars table based on the "model" column
# NOTE: if you don't explicitely tell which columns to join, it'll join all: 

mtcars_merged <- merge(mtcars, countries, by.x = "carName", by.y = "model")


# now with explicit column selection: 

mtcars_merged <- merge(mtcars, countries[,c("model","manf_Country")], 
                       by.x = "carName", by.y = "model")

# or just use column numbers: 

mtcars_merged <- merge(mtcars, countries[,1:2], 
                       by.x = "carName", by.y = "model")

# with dplyr:

library(dplyr)

# without excluding columns

mtcars_merged_DL1 <- left_join(mtcars, countries, by = c("carName" = "model"))

# excluding the useless columns

mtcars_merged_DL2 <- left_join(mtcars, select(countries, c(1:2)) , by = c("carName" = "model"))
