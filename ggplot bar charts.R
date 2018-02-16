

##################################################################################
# the object of this series on ggplot2 is not to learn ggplot2 from the bottom   #
# up, there are books and books on it. it's supposed to give you a really handy  #
# framework to quickly produce when you need to utilizing excel instincts.       #
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

#footnote (not so important, just explaining why i choose to do it in a certain way)

ggplot(data=df, aes(x=Order.Priority))+
  geom_bar()  # this will work for counting items per category

ggplot(data=df, aes(x=Order.Priority, y = Sales))+
  geom_bar()  # but this will not. it will throw exception

ggplot(data=df, aes(x=Order.Priority, y = Sales))+
  geom_bar(stat = "identity") # this solves it, but can get confusin. i'd rather reshape my data!

######################################
# so the longer way - the excel way! #
######################################

# 1) MAKE SURE YOUR CATEGORICAL FIELDS ARE FACTORS FIRST!
  
str(df)

# 2) reshape your data and pivot to the data you need. in this case - count of items
#     by order priority
 
 df1 <- df %>% 
   select(Order.Priority) %>% 
   group_by (Order.Priority) %>% 
   summarise(TotalOrders = n()) %>% 
   arrange(desc(TotalOrders)) # if you don't know this, go to my videos about pivoting data
 
 df1
 
# 3) create the base of your chart: data, x/y variables, sorting, and color

 p<-ggplot(data=df1, aes(x=Order.Priority, 
                         y=TotalOrders,
                         fill = "red"
 ))
 p + geom_bar(stat = "identity")
 
 p<-ggplot(data=df1, aes(x=reorder(Order.Priority, -TotalOrders), 
                                   y=TotalOrders,
                                   fill = Order.Priority
                                   ))
 p + geom_bar(stat = "identity")
 
  # 4) add layers. there are countless options but i think these will cover 90% of your
  #     needs. use this as a template.
 
 p +
   geom_bar(stat = "identity", #confusing subject, when plotting pivoted data, always leave "identity"
            width = 0.5,      # how wide (0-1) the bars are
            color = "black",  # the outline color of the bars
            size = 1,         # the thickness of the outline
            alpha = 0.5) +    # the opaqueness of the fill colors
   theme_minimal()+           # the background
   geom_text(aes(label = TotalOrders), vjust = 10, size = 3) + # the labels
   theme(legend.position = "right") +                         # legend position
   labs(x= "Order Priority", y = "Total Orders", title = "Total Orders by Priority", caption = "2016 data")+  # axis labels and footnote
   coord_flip()+              # flip from column to bar horizontal
   scale_x_discrete(limits = c("High", "Low","Critical")) # filter only certain factors
 
 # 5) now the same, only use sum sales instead of count items: 
 
 df2 <- df %>% 
   select(Order.Priority, Sales) %>% 
   group_by (Order.Priority) %>% 
   summarise(SumOrders = sum(Sales)) %>% 
   arrange(desc(SumOrders)) 
 
 p2<-ggplot(data=df2, aes(x=reorder(Order.Priority, -SumOrders), 
                         y=SumOrders,
                         fill = Order.Priority
                         ))

 p2 +
   geom_bar(stat = "identity", 
            width = 0.5,      
            color = "black",  
            size = 1,         
            alpha = 0.5) +    
   theme_minimal()+          
   geom_text(aes(label = SumOrders), hjust = 2, size = 3, angle = 90) + 
   theme(legend.position = "right") +                        
   labs(x= "Order Priority", y = "Total Orders", title = "Total Orders by Priority", caption = "2016 data")+  
   coord_flip()+              
   scale_x_discrete(limits = c("High", "Low","Critical")) 
 
 

   
 
