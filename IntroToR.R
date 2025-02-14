### PLPA 5820 Intro to R
## Homework Coding Practice #1

#### 4 hashtags delineates a section of code ####
# Be careful with aces, X is not equal to x

#### Learning Objectives ####
# Use basic mathematical operators in R
# Know some of the data types
# Install packages
# Load data into R (.csv or .txt)

#### Exercise 1: R is a big calculator ####
2+2
2-2
2/2
2*2

#### Exercise 2: Objects <- or = ####
x <- 2
y = 3
# Now can be seen in the environment
x
x+y
x-y
# Character variables
name <- "Brynleigh"
seven <- "7" # R will not think of this as numeric, but now as a character
#seven <- 7 # Use this instead for it to still be a numeric object

seven + x # Error in seven + x : non-numeric argument to binary operator

#### Functions ####
# Use the class function to figure out character type
class(seven)
class(x)

# Use concatenate function - makes vector out of strings
vec <- c(1,2,3,4,5,6,7)
vec1 <- c(1:7)  # Shorthand for the same as above
#vec <- 1:7 # Also works without c()
vec2 <- c("Brynleigh", "Anet") # Character vector
vec3 <- c(TRUE, FALSE, TRUE)  # Logical vector - Caps recognized by R

vec[4] # Telling the vector to return the 4th value
vec2[1]
vec + 2 # Adds 2 to each value in vector

# Basic functions in R
vec
mean(vec)
sd(vec)
sum(vec)
median(vec)
min(vec)
max(vec)
summary(vec)
abs(vec)
sqrt(vec)
sqrt(sum(vec))
log(vec)
log10(vec)
exp(vec)

#### Logical Operators ####
# > greater than
# < less than
# | or
# & and
# = equals (used for assigning values from left to right)
# == exactly equal (for showing equality between values)
# >= greater than or equal to
# != not equal to

1 > 2
1 < 2
1 <= 2
1 == 1

t <- 1:10
t[(t > 8) | (t < 5)] # Values of t that are greater than 8 or less than 5
t[t != 2]

32 %in% t # ask R if a number exists in a vector

#### Data types ####
x # Scalar object
vec # Vectors
mat1 <- matrix(data = c(1,2,3), nrow = 3, ncol = 3) # Matrices
mat2 <- matrix(data = c("Brynleigh", "Anet", "Zach", nrow = 3, ncol = 3))

mat1[1]
mat1[2]
mat1[3]
mat1[4]

mat1[1,3] # First row, third column
mat1[1,] # First row
mat1[,3] # Third column

df <- data.frame(mat1[,1], mat2[,1]) # Dataframes - like matrices that can contain multiple data types
colnames(df) <- c("value", "name")
df[1,2] # First row, second column
df$value # Accessing columns
df$value[1]
df$name[3]

# Subsetting or indexing
# The element of the column value that is equal to Brynleigh
df$value[df$name == "Brynleigh"]
df$value[df$name %in% c("Brynleigh", "Anet")] #FOR EXAM: return the elements of 
#the column value within the dataframe df such that name is not equals to Brynleigh and Anet
df$value[df$name != "Anet"]

subset(df, name == "Brynleigh") # Use subset function
df$log_value <- log(df$value) # Make a new column
df

#### Installing Packages ####
# tidyverse
# lme4
# purr

install.packages("tidyverse")  # Installs package, use quotes around the package name
library(tidyverse) # Loads functions into R

#### Reading data into R ####
# .csv or .txt files
csv <- read.csv("/Users/brynleighpayne/Desktop/Example.csv", na.strings = "na")
csv2 <- file.choose() # NOT reproducible method, opens browser to select file
