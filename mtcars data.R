rmarkdown::render("mtcars data.R")
rmarkdown::render("mtcars data.R", "pdf_document" )
# Loading the dataset into a dataframe
data("mtcars")

#To see the structure of the dataset
str(mtcars)

# To see the top 6 rows of the data
head(mtcars)

# To see the bottow rows of the dataset
tail(mtcars)

# To get more information about the dataset
?mtcars

#Exploring the dataset

  #To see the number of rows
nrow(mtcars)

  # To see the number of columns
ncol(mtcars)

  # To perform the 5 number summary on the entire dataset
summary(mtcars)

  #To find the mode of every variable in the dataset, since this is not an inbuilt function, we have to calculate for each variable.
     
     # for the miles per gallon(mpg) data
  mode_mpg <- names(sort(-table(mtcars$mpg)))[1]
mode_mpg
paste("the mode of the miles per gallon is", mode_mpg)  

      #for the cylinder(cyl) data
mode_cyl <- names(sort(-table(mtcars$cyl)))[1]
mode_cyl
paste("the mode of the cylinder is", mode_cyl)  

      #for the displacement data
mode_disp <- names(sort(-table(mtcars$disp)))[1]
mode_disp
paste("the mode of the displacement is", mode_disp)  

      #for the gross horsepower data
mode_hp <- names(sort(-table(mtcars$hp)))[1]
mode_hp    
paste("the mode of the Horsepower is", mode_hp)  

      #for the rear axle ratio (drat)
mode_drat <- names(sort(-table(mtcars$drat)))[1]
mode_drat
paste("the mode of the rear axle ratio is", mode_drat)  

      #for the weight
mode_wt <- names(sort(-table(mtcars$wt)))[1]
mode_wt
paste("the mode of the weight is", mode_wt)  

      #for the 1/4 mile time
mode_qsec <- names(sort(-table(mtcars$qsec)))[1]
mode_qsec
paste("the mode of the quarter mile is", mode_qsec)  

      #for the engine
mode_vs <- names(sort(-table(mtcars$vs)))[1]
mode_vs
paste("the mode for the engine type is", mode_vs)    

      #for the transmission
mode_am <- names(sort(-table(mtcars$am)))[1]
mode_am
paste("the most automatic transmission type is", mode_am)    

      #for the number of forward gears
mode_gear <- names(sort(-table(mtcars$gear)))[1]
mode_gear
paste("the mode for the number of forward gear is", mode_gear)    

      #for the number of carburetors
mode_carb <- names(sort(-table(mtcars$carb)))[1]
mode_carb
paste("the mode for the number of carburetors is", mode_carb)  

#Exploring the number of cars and their miles per hour
library(ggplot2)
ggplot(mtcars, aes(mpg)) +
  geom_histogram(binwidth = 4)  + xlab('Miles Per Gallon')  +  ylab('Number of Cars') + 
      ggtitle('Distribution by Mileage')

#Exploring the distribution by cylinders  
library(ggplot2)
ggplot(mtcars, aes(cyl)) +
  geom_histogram(binwidth = 1)  + xlab('Number of Cylinders')  +  ylab('Number of Cars') + 
  ggtitle('Distribution by the Number of Cylinders')

#Exploring the distribution by horsepower
library(ggplot2)
ggplot(mtcars, aes(hp)) +
  geom_histogram(binwidth = 15)  + xlab('Gross Horsepower')  +  ylab('Number of Cars') + 
  ggtitle('Distribution by Horsepower')

#Exploring the distribution by the rear axle ratio
library(ggplot2)
ggplot(mtcars, aes(drat)) +
  geom_histogram(binwidth = 15)  + xlab('Rear Axle Ratio')  +  ylab('Number of Cars') + 
  ggtitle('Distribution by Raer Axle Ratio')

#Exploring the distribution by Weight
library(ggplot2)
ggplot(mtcars, aes(wt)) +
  geom_histogram(binwidth = 15)  + xlab('Weight')  +  ylab('Number of Cars') + 
  ggtitle('Distribution by Weight')

#Exploring the distribution by the quarter mile ratio
library(ggplot2)
ggplot(mtcars, aes(qsec)) +
  geom_histogram(binwidth = 15)  + xlab('Quarter Mile Ratio')  +  ylab('Number of Cars') + 
  ggtitle('Distribution by the Quarter Mile Ratio')

#Exploring the distribution by engine type
library(ggplot2)
ggplot(mtcars, aes(vs)) +
  geom_histogram(binwidth = 15)  + xlab('Engine Type')  +  ylab('Number of Cars') + 
  ggtitle('Distribution by Engine Type')

library(ggplot2)
qplot(data = mtcars, x = mpg, y = vs, geom = "bar", stat = "identity") + facet_wrap("vs")

#Exploring the distribution by transmission
library(ggplot2)
ggplot(mtcars, aes(am)) +
  geom_histogram(binwidth = 15)  + xlab('Transmission Type')  +  ylab('Number of Cars') + 
  ggtitle('Distribution by Transmission Type')

#Exploring the distribution by the Number of Forward Gears
library(ggplot2)
ggplot(mtcars, aes(gear)) +
  geom_histogram(binwidth = 15)  + xlab('Number of Forward Gears')  +  ylab('Number of Cars') +
  ggtitle('Distribution by Number of Forward Gears')

#Exploring the distribution by the Number of Carburetors
library(ggplot2)
ggplot(mtcars, aes(carb)) +
  geom_histogram(binwidth = 15)  + xlab('Number of Carburetors')  +  ylab('Number of Cars') +
  ggtitle('Distribution by Number of Carburetors')




#### Correlation between the mileage and the horsepower
cor(mtcars$mpg, mtcars$hp)  
cor.test(mtcars$mpg, mtcars$hp)
ggplot(mtcars, aes(hp, mpg)) + 
  geom_point() + geom_smooth(method = "lm", se = FALSE) + colour(hp) +
  ylab("Miles per Gallon") +
  xlab("Number of Horsepower") +
  ggtitle("Correlation between the Number of Horsepower and the Mileage")

ggplot(mtcars, aes(hp, mpg)) + stat_smooth() + 
  geom_point() + 
  ylab("Miles per Gallon") +
  xlab("Number of Horsepower") +
  ggtitle("Correlation between the Number of Horsepower and the Mileage")

#### Correlation between the mileage and the displacement
cor(mtcars$mpg, mtcars$disp)  
cor.test(mtcars$mpg, mtcars$disp)
ggplot(mtcars, aes(disp, mpg)) + 
  geom_point() + geom_smooth(method = "lm", se = FALSE) + 
  ylab("Miles per Gallon") +
  xlab("Displacement") +
  ggtitle("Correlation between the Displacement and the Mileage")

ggplot(mtcars, aes(disp, mpg)) + stat_smooth() + 
  geom_point() + 
  ylab("Miles per Gallon") +
  xlab("Dislacement") +
  ggtitle("Correlation between the Displacement and the Mileage")


#### Correlation between the mileage and the quarter mile ratio
cor(mtcars$mpg, mtcars$qsec)  
cor.test(mtcars$mpg, mtcars$qsec)

ggplot(mtcars, aes(qsec, mpg)) + 
  geom_point() + geom_smooth(method = "lm", se = FALSE) + 
  ylab("Miles per Gallon") +
  xlab("Quarter Mile Ratio") +
  ggtitle("Correlation between the Number of Quarter Mile Ratio and the Mileage")

ggplot(mtcars, aes(qsec, mpg)) + stat_smooth() + 
  geom_point() + 
  ylab("Miles per Gallon") +
  xlab("Quarter Mile Ratio") +
  ggtitle("Correlation between the Quarter Mile Ratio and the Mileage")


#### Correlation between the mileage and the number of cylinders
cor(mtcars$mpg, mtcars$cyl)  
cor.test(mtcars$mpg, mtcars$qsec)

qplot(cyl, mpg, data = mtcars, colour = cyl, geom = "point", 
  ylab = "Miles per Gallon",   xlab ="Number of Cylinders", 
  main = "Correlation between the Number of Cylinders and the Mileage")

ggplot(mtcars, aes(cyl, mpg)) + 
  geom_point() + geom_smooth(method = "lm", se = FALSE) + 
  ylab("Miles per Gallon") +
  xlab("Number of Cylinders") +
  ggtitle("Correlation between the Number of Cylinders and the Mileage")

#### Correlation plot for the mcars dataset
library(corrplot)
M <- cor(mtcars)
corrplot::corrplot(M,  method = 'square') 
corrplot(M, type = "lower")  
corrplot.mixed(M, lower.col = "black", number.cex = .9)
  