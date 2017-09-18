setwd("C:/Users/User/Documents")
# pre-session options

rm(list = ls())
# getwd()
# setwd("C:/Users/your preferred path")

######## Base R ###################
##### let's see various totals vectors to the Hitters and mtcars data set #####
##### R is not clever like excel, and doesn't know to ignore non-numerics: ####

# first a simply case: all variables are numeric
# note that the model names are obviously not numeric, but techincally they are not 
# part of the variable set - they are stored in the "rownames" object, so when running
# functions on columns or rows, they are ignored by R:

mtcars <- mtcars
write.csv(mtcars, "mtcars.csv")

# row sums, means: 
mtcars
rowSums(mtcars)
rowMeans(mtcars)

# column sums, means: 

colSums(mtcars)
colMeans(mtcars)

# what about other totals, such as Var, sd, median, or count(length)? 
# use the apply() function - 1 = rows, 2 = columns: 

apply(mtcars, 1, median)
apply(mtcars, 2, median)
apply(mtcars, 1, sd)
apply(mtcars, 2, sd)
apply(mtcars, 1, length)
apply(mtcars, 2, length)

# it gets trickier when there is a mix of numeric and non numeric data

library(ISLR)
Hitters <- Hitters
write.csv(Hitters, "Hitters.csv")

colSums(Hitters) # gets an error


# we need to filter the numerics only: 

colSums(Filter(is.numeric, Hitters))

# to discount NAs: 
colSums(Filter(is.numeric, Hitters), na.rm = TRUE)

# likewise, with apply: 

apply(Filter(is.numeric,Hitters), na.rm = TRUE, 2, median)

#  the dplyr package adds a lot of additional functionality to this type of aggregation

library(dplyr)


# summarise_all does for all columns

mtcars %>%
  summarise_all(funs(mean))

# you can rename easily so you know exactly what you did: 

mtcars %>%
  summarise_all(funs(avg = mean))

# but it won't work for non numerics: 

Hitters %>%
  summarise_all(funs(avg = mean))

# so, can use regular summarise, specifying exact variables (column names)

Hitters %>%
  summarise(sum(AtBat), sum(Hits), sum(Salary, na.rm = TRUE))

# or with a dplyr short cut, with summarise_at: 

Hitters %>%
  summarise_at(c("AtBat","Hits", "Salary"), sum, na.rm = TRUE)


# you can also choose a different aggregate function for each variable, and rename
# accordingly: 

Hitters %>%
  summarise(meanAB = mean(AtBat), sumH = sum(Hits), medSalary = median(Salary, na.rm = TRUE))

# as in base R, if we want to quickly sum over the numeric columns only: 

Hitters %>%
  summarise_if(is.numeric, mean, na.rm = TRUE)

# and if you wish to rename: 

Hitters %>%
  summarise_if(is.numeric, funs(avg = mean), na.rm = TRUE)





