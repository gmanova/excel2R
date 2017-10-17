# pre-session options

rm(list = ls())
# getwd()
# setwd("C:/Users/your preferred path")


df <- read.csv(url("https://www.dropbox.com/s/bt2kaytzzsx6hle/dates.csv?dl=1"),
               skip = 0,
               header = TRUE, 
               stringsAsFactors = FALSE)

write.csv(df, "dates.csv")

# by default this is imported as a dataframe, so let's just convert to a single vector so we won't 
# have to keep referring to it as a subset: 

crappyDate <- df[,1] 

# now let's extract the year, month and date using substr: note the logic is 
# 1) the string, 2) starting spot 3) end spot (and not count steps like excel)
# for the "right" we use nachr() - this is the equivalent of using len() in Excel

year <- substr(crappyDate,1,4) # = left
month <- substr(crappyDate,6,7) # = mid
day <- substr(crappyDate,nchar(crappyDate)-1, nchar(crappyDate)) # = right

# now paste for a proper date vector: 

date <- paste(year, month, day, sep = "-")

# use as.posixct to make sure it adheres to R's date standard

date <- as.POSIXct(date)

# not a must, but install and load lubridate to play around with Excel-like date functions:

install.packages("lubridate")
library(lubridate)

month(date)
day(date)
