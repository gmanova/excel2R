

##################################################################################
# the object of this series on ggplot2 is not to learn ggplot2 from the bottom   #
# up, there are books and books on it. it's supposed to give you a really handy  #
# framework to quickly produce plots when you need to utilizing excel instincts. #
#                                                                                #
# As such, despite not always necessary, i reshape the data first as you would   #
# with Pivot Tables in Excel and then graph them. this simplifies things even if #
# code is slightly longer.                                                       #  
##################################################################################

rm(list = ls())
getwd()

library(ggplot2)
library(dplyr)
library(tidyr)

df <- read.csv("https://www.dropbox.com/s/kj9yioc24iq4pdb/superstore.csv?dl=1")
write.csv("superstore.csv")

############## BAR AND COLUMN PLOTS ############################################## 


# 1) MAKE SURE YOUR CATEGORICAL FIELDS ARE FACTORS FIRST! (coerce with as.factor if necessary)
  
str(df)

# 2) as usual, although not mandatory, i prefer to reshape the data and pivot to the data you need.
# in this case - count of items by order priority
 
df1 <- df %>% 
  select(Province,Order.Priority) %>% 
  group_by (Province,Order.Priority) %>% 
  summarise(TotalOrders = n())  # if you don't know this, go to my videos about pivoting data


 p <-ggplot(data=df1, aes(x=Province, 
                         y=TotalOrders,
                         fill = Order.Priority))

 #so far there is no difference from regular bar charts, now just add the position arguments
 # (here in the 2nd line and in the geom_text for the labels): 
 
 p + 
   geom_bar(stat = "identity", #confusing subject, when plotting pivoted data, always leave "identity"
            position = "fill",
            width = 0.6,      # how wide (0-1) the bars are
            color = "black",  # the outline color of the bars
            size = 0.5,         # the thickness of the outline
            alpha = 0.5) +    # the opaqueness of the fill colors
   theme_minimal()+           # the background
   theme(legend.position = "right", axis.text.x = element_text(angle = 45, hjust = 0.8)) +                         # legend position
   labs(x= "Order Priority by Province", y = "Total Orders", title = "Total Orders by Priority",
        caption = "2016 data")+  # axis labels and footnote
   scale_x_discrete(limits = c("Ontario", "Alberta","British Columbia", "Quebec")) + # filter only certain factors
   geom_text(aes(label = TotalOrders), position = position_fill(vjust = 0.5), size = 3)  # the labels
   #coord_flip()+              # flip from column to bar horizontal
   
   
   # however this shows the 100% but with the actual numbers, not %. to fix, just like in Excel you would
   # further manipulate the pivot table, create a % of total column and plot that instead: 
   
   
   df2 <- df1 %>% 
   mutate(PercentOfTotal = round(TotalOrders / sum(TotalOrders),digits = 2)) # if you don't know this, go to my videos about pivoting data
 
 p2 <-ggplot(data=df2, aes(x=Province, 
                          y=PercentOfTotal,
                          fill = Order.Priority))
 
 #so far there is no difference from regular bar charts, now just add the position arguments
 # (here in the 2nd line and in the geom_text for the labels): 
 
 p2 + 
   geom_bar(stat = "identity", #confusing subject, when plotting pivoted data, always leave "identity"
            position = "fill",
            width = 0.6,      # how wide (0-1) the bars are
            color = "black",  # the outline color of the bars
            size = 0.5,         # the thickness of the outline
            alpha = 0.5) +    # the opaqueness of the fill colors
   theme_minimal()+           # the background
   theme(legend.position = "right", axis.text.x = element_text(angle = 45, hjust = 0.8)) +                         # legend position
   labs(x= "Order Priority by Province", y = "Total Orders", title = "Total Orders by Priority",
        caption = "2016 data")+  # axis labels and footnote
   scale_x_discrete(limits = c("Ontario", "Alberta","British Columbia", "Quebec")) + # filter only certain factors
   geom_text(aes(label = PercentOfTotal), position = position_fill(vjust = 0.5), size = 3)  # the labels

 
 

   
 
