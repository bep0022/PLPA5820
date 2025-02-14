### PLPA 5820 Intro to R
## Homework Coding Notes Data Visualization #1
# Introduction to ggplot

#### Load built-in dataset on R ####
data("mtcars")
# View structure of the data
str(mtcars)

#### Base function R scatterplot ####
plot(mtcars$wt, mtcars$mpg)

# Make a less basic plot
plot(mtcars$wt, mtcars$mpg, 
     xlab = "Car Weight",
     ylab = "Miles per Gallon",
     font.lab = 6,
     pch = 20) #Add axis labels, change font size, change shapes

#### ggplot basics ####
# Install and load
install.packages("ggplot2")
library(ggplot2)

# Use function
ggplot()

# Plot data
ggplot(mtcars, aes(x = wt, y = mpg)) # Specifying x and y variables, results in axes
# ggplot is based on layering 
# add data structure with the "+'
  # geom_point adds data points
  # geom_smooth adds a trendline
    # We can specify this to be the fitting linear relationship (good for variable relationship exploration)
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_point() +
  geom_smooth(method = lm, se = FALSE)

# Changing the order of the layers changes the order in which they are displyed
ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_smooth(method = lm, se = FALSE, color = "black") +
  geom_point(aes(size = wt), color = "blue") + # Alter point size, make all points blue
  xlab("Weight") + # Add x axis label
  ylab("Miles per Gallon") # Add yaxis label

ggplot(mtcars, aes(x = wt, y = mpg)) +
  geom_smooth(method = lm, se = FALSE, color = "black") +
  geom_point(aes(size = wt, color = wt)) + # OR change color w/in aes for point difference
  xlab("Weight") + # Add x axis label
  ylab("Miles per Gallon") + # Add yaxis label
  scale_color_gradient(low = "pink", high = "red") # IF you want to specify the gradient
# scale_x_log10() # Scales the x axis by log10
# scale_y_continuous(labels = scales::percent) # Turns y axis in percentages

#### Categorical + Numeric ####
# Perfect for visualizing the effects of ANOVA

# Read in data
bull.richness <- read.csv("/Users/brynleighpayne/Downloads/Bull_richness.csv")
str(bull.richness)
# Subset to soy data
bull.richness.soy.no.till <- bull.richness[bull.richness$Crop == "Soy" & 
                                             bull.richness$Treatment == "No-till",] 

# Make a box plot of soy subset
ggplot(bull.richness.soy.no.till, aes(x = GrowthStage, y = richness, color = Fungicide)) + 
  geom_boxplot() +
  xlab("") + # Add custom x axis label
  ylab("Bulleribasidiaceae richness") + # Add custom y axis label
  geom_point(position = position_jitterdodge(dodge.width = 0.9)) # Add points, "jitter" the points over the boxes

# Make a bar chart
ggplot(bull.richness.soy.no.till, aes(x = GrowthStage, y = richness, color = Fungicide)) + 
  stat_summary(fun = mean, geom = "bar", position = "dodge") + # Function plots the mean
  stat_summary(fun.data = mean_se, geom = "errorbar", position = "dodge") +  # Function plots the standard error 
  xlab("") + 
  ylab("Fungal richness") +
  geom_point(position = position_jitterdodge(dodge.width = 0.9)) 

# Color is outside lines, fill is color within the lines
ggplot(bull.richness.soy.no.till, aes(x = GrowthStage, y = richness, color = Fungicide, fill = Fungicide)) + 
  stat_summary(fun = mean, geom = "bar", position = "dodge") + # Function plots the mean
  stat_summary(fun.data = mean_se, geom = "errorbar", position = "dodge") +  # Function plots the standard error 
  xlab("") + 
  ylab("Fungal richness") +
  geom_point(position = position_jitterdodge(dodge.width = 0.9))

# Line chart - for time series data
  # No longer need to dodge
  # Add grouping function for Fungicide to draw mean lines
  # No longer needs points
  # No longer needs fill
ggplot(bull.richness.soy.no.till, aes(x = GrowthStage, y = richness, group = Fungicide, color = Fungicide)) + 
  stat_summary(fun = mean, geom = "line") +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.5) +
  xlab("") +
  ylab("Fungal Richness")

# Faceting - allows you to make separate plots for each subset of your data
# Use function facet_wrap() and ~ to specify which variables to facet
ggplot(bull.richness, aes(x = GrowthStage, y = richness, group = Fungicide, color = Fungicide)) + 
  stat_summary(fun = mean, geom = "line") +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.5) +
  xlab("") +
  ylab("Fungal Richness") + 
  facet_wrap(~Treatment*Crop, scales = "free") # Can add multiple facets with *
                              # Free scale eliminates irrelevant axis points
                              # Can switch order Crop*Treatment to change panel order


  