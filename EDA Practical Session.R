options(warn = -1)


library(plyr)
library(tidyverse)
library(data.table)
library(lubridate)
library(cowplot)
library(corrplot)

#####
path.dir = getwd()
data.dir = paste0(path.dir,"/Data")


####
df = fread(paste0(data.dir,"/Train.csv")) %>% as.data.frame()
rid = fread(paste0(data.dir,"/Riders.csv")) %>% as.data.frame()




#### re-code pick up time and extract pick up hour
df = df %>% mutate(
  Pickup_Time = strptime(`Pickup - Time`,format = "%I:%M:%S %p") %>% as.POSIXct(),
  weekday = (`Pickup - Weekday (Mo = 1)` %in% c(1:5)),
  worktime = (hour(Pickup_Time) %in% seq(8,18)) & (`Pickup - Weekday (Mo = 1)` %in% c(1:5)),
  p_hour = hour(Pickup_Time),
  dd= as.factor(`Distance (KM)`),
  #### drop columns
  `Placement - Day of Month` = NULL,
  `Placement - Weekday (Mo = 1)` = NULL,
  `Confirmation - Day of Month` = NULL,
  `Confirmation - Weekday (Mo = 1)` = NULL,
  `Arrival at Pickup - Day of Month` = NULL,
  `Arrival at Pickup - Weekday (Mo = 1)` = NULL,
  `Placement - Time` = NULL,
  `Confirmation - Time` = NULL,
  `Arrival at Pickup - Time` = NULL,
  `Pickup - Time` = NULL,
  placement_time=NULL,
  Confirmation_Time = NULL,
  Arrival_Time = NULL,
  Pickup_Time = NULL,
  `Order No` = NULL,
  `Vehicle Type` = NULL,
  `Pickup - Day of Month` = NULL,
  `Arrival at Destination - Day of Month` = NULL,
  `Arrival at Destination - Weekday (Mo = 1)` = NULL,
  `Arrival at Destination - Time` = NULL
) %>% 
  left_join(rid, by = "Rider Id")

#### re-code weekdays
df$weekdays = ifelse(df$`Pickup - Weekday (Mo = 1)` ==1,"Monday",
  ifelse(df$`Pickup - Weekday (Mo = 1)` == 2,"Tuesday",
    ifelse(df$`Pickup - Weekday (Mo = 1)` == 3,"Wednesday",
      ifelse(df$`Pickup - Weekday (Mo = 1)`==4,"Thursday",
        ifelse(df$`Pickup - Weekday (Mo = 1)`==5,"Friday",
          ifelse(df$`Pickup - Weekday (Mo = 1)`==6,"Saturday","Sunday"))))))

###################################################
#### Basic Exploratory Data Analysis
###################################################

###### MISSING VALUES
df[df== ""] <- NA
#check fir columns with missing values
na.cols <- which(colSums(is.na(df)) > 0)
na.cols <- sort(colSums(sapply(df[na.cols], is.na)), decreasing = TRUE)
paste('There are', length(na.cols), 'columns with missing values')
na.cols

## Check the dim and structure of the data
dim(df)
### what constitute our data/ characteristics of the data
colnames(df)
str(df)
## you can also use class to check the attribute of the data


#### correlation
# get numeric columns
corr.df <- df

num.cols <- sapply(corr.df,is.numeric)
corr <- corr.df[,num.cols] %>% cor()

# only want the columns that show strong correlations with SalePrice
corr.SalePrice <- as.matrix(sort(corr[,'Time from Pickup to Arrival'], decreasing = TRUE))
corr.idx <- names(which(apply(corr.SalePrice, 1, function(x) (x > 0.01 | x < -0.01))))

## Visuals
corrplot(as.matrix(corr[corr.idx,corr.idx]), type = 'upper', method='color', addCoef.col = 'black', tl.cex = .7,cl.cex = .7, number.cex=.7)

summary(df$`Time from Pickup to Arrival`)
summary(df$`Distance (KM)`)
summary(df$Temperature)

## measure of spread
range()
quantile()
sd()
var()
## measure of central tendency
mean()
median()
mode()

#### Understanding data through graph
@ histogram,barplot,piechart,boxplot,scatterplot
### histogram : mostly used on continous variables
### barplot: mostly used on categorical features
### piechart: mostly used on categorical features
#### boxplot: mostly used for detecting outliers




## checking the distribution of the arrival time
df %>% 
  ggplot(aes(x = df$`Time from Pickup to Arrival`)) +
  geom_histogram(fill = "cornflowerblue",color = "black")+
  #theme_grey() + 
  theme(axis.line = element_blank(),
    # axis.text = element_blank(),
    axis.ticks = element_blank(),
    plot.title = element_text(hjust = 0.5))+
  labs(title = paste("Distribution of Time from Pickup to Arrival"))+
  xlab("Time from Pickup to Arrival")+
  ylab("Counts")

### Distance
## checking the distribution of the distance travelled
df %>% 
  ggplot(aes(x = df$`Distance (KM)`)) +
  geom_histogram(fill = "cornflowerblue",color = "black")+
  theme_grey() + 
  theme(axis.line = element_blank(),
    # axis.text = element_blank(),
    axis.ticks = element_blank(),
    plot.title = element_text(hjust = 0.5))+
  labs(title = paste("Distribution of the Distance travelled"))+
  xlab("Distance")+
  ylab("Counts")

### average per distance
df %>% 
  ggplot(aes(x = dd, y = `Time from Pickup to Arrival`))+
  geom_boxplot(aes(color = dd))+
  labs(title = "Time from Pickup to Arrival per Distance")+
  xlab("Distance")+
  theme(legend.text = element_blank(),
    legend.position = "none",
    axis.line = element_blank(),
    # axis.text = element_blank(),
    axis.ticks = element_blank(),
    plot.title = element_text(hjust = 0.5))






### most travel weekdays
w1= df %>% 
  ggplot(aes(x = reorder(df$weekdays,`Time from Pickup to Arrival`)))+
  geom_bar(fill = "cornflowerblue")+
  geom_text(aes(label = ..count..),hjust = 0.5,size = 3.5,
    stat = "count",vjust = 1.5, color = "white")+
  labs(title = paste("When (day of the week) do People use sendy logistics?"))+
  xlab("Day of the week")+
  ylab("Counts")

## average travel time per weekday
w2 = df %>% 
  ggplot(aes(x = reorder(as.factor(weekdays),`Time from Pickup to Arrival`), y = `Time from Pickup to Arrival`))+
  geom_boxplot(aes(color = as.factor(weekdays)))+
  labs(title = "Time from Pickup to Arrival per Weekday")+
  xlab("Day of the week")+
  theme(legend.text = element_blank(),
    legend.position = "none",
    axis.line = element_blank(),
    # axis.text = element_blank(),
    axis.ticks = element_blank(),
    plot.title = element_text(hjust = 0.5))
plot_grid(w1,w2,align = "h")

##### PICK UP HOUR
h1 = df %>% group_by(p_hour) %>%
  summarise(count = n()) %>% 
  #filter(count>150) %>% 
  ggplot(aes(x = reorder(p_hour,count), y =count))+
  geom_col(fill = "cornflowerblue")+
  theme(axis.line = element_blank(),
    # axis.text = element_blank(),
    axis.ticks = element_blank(),
    plot.title = element_text(hjust = 0.5))+
  labs(title = paste("When (Hour of the day) do People use sendy logistics?"))+
  xlab("Hour of the day")+
  ylab("Counts")+
  coord_flip()

### average travel time per hour
h2 = df %>% 
  ggplot(aes(x = as.factor(p_hour), y = `Time from Pickup to Arrival`))+
  geom_boxplot(aes(color = as.factor(p_hour)))+
  labs(title = "Time from Pickup to Arrival per Hour")+
  xlab("Hour of the Day")+
  theme(legend.text = element_blank(),
    legend.position = "none",
    axis.line = element_blank(),
    # axis.text = element_blank(),
    axis.ticks = element_blank(),
    plot.title = element_text(hjust = 0.5))
plot_grid(h1,h2,align = "h")

###########
### personal or business
df %>% 
  ggplot(aes(x = df$`Personal or Business`))+
  geom_bar(fill = "cornflowerblue")+
  geom_text(aes(label = ..count..),hjust = 0.5,size = 3.5,
    stat = "count",vjust = 1.5, color = "white")

## average travel time per travel reason
df %>% 
  ggplot(aes(x = as.factor(`Personal or Business`), y = `Time from Pickup to Arrival`))+
  geom_boxplot(aes(color = as.factor(`Personal or Business`)))+
  labs(title = "Time from Pickup to Arrival per Distance")+
  xlab("Distance")+
  theme(legend.text = element_blank(),
    legend.position = "none",
    axis.line = element_blank(),
    # axis.text = element_blank(),
    axis.ticks = element_blank(),
    plot.title = element_text(hjust = 0.5))


### most plaform
df %>% 
  ggplot(aes(x = df$`Platform Type`))+
  geom_bar(fill = "cornflowerblue")+
  geom_text(aes(label = ..count..),hjust = 0.5,size = 3.5,
    stat = "count",vjust = -0.5, color = "black")




## average travel time per hour

### ride per rider
df %>% group_by(`Rider Id`) %>%
  summarise(count = n()) %>% 
  filter(count>150) %>% 
  ggplot(aes(x = reorder(`Rider Id`,count), y =count))+
  geom_col(fill = "cornflowerblue")+
  theme(axis.line = element_blank(),
    # axis.text = element_blank(),
    axis.ticks = element_blank(),
    plot.title = element_text(hjust = 0.5))+
  labs(title = paste("Top Riders"))+
  xlab("Riders")+
  ylab("Counts")+
  coord_flip()

a = df %>% group_by(`Rider Id`) %>%
  summarise(count = n()) %>% 
  filter(count>150) %>% 
  left_join(rid,by = "Rider Id")

a %>% 
  ggplot(aes(x = reorder(`Rider Id`,Average_Rating), y =Average_Rating))+
  geom_col(fill = "cornflowerblue")+
  theme(axis.line = element_blank(),
    # axis.text = element_blank(),
    axis.ticks = element_blank(),
    plot.title = element_text(hjust = 0.5))+
  labs(title = paste("Top Riders"))+
  xlab("Riders")+
  ylab("Counts")+
  coord_flip()

## travel per user
df %>% group_by(`User Id`) %>%
  summarise(count = n()) %>% 
  filter(count>150) %>% 
  ggplot(aes(x = reorder(`User Id`,count), y =count))+
  geom_col(fill = "cornflowerblue")+
  theme(axis.line = element_blank(),
    # axis.text = element_blank(),
    axis.ticks = element_blank(),
    plot.title = element_text(hjust = 0.5))+
  labs(title = paste("Top Riders"))+
  xlab("Riders")+
  ylab("Counts")+
  coord_flip()


## analyzing spatial data
leaflet(data = df) %>% addProviderTiles("Esri.NatGeoWorldMap") %>%
  addCircleMarkers(~`Pickup Long`, ~`Pickup Lat`, radius = 1,
    color = "blue", fillOpacity = 0.3)




