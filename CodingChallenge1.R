### PLPA 5820 Intro to R
## In-Class Coding Challenge #1 :)

# Create a vector 'z' with values 1-200
z <- c(1:200)
mean(z) # Answer: [1] 100.5
sd(z) # Answer: [1] 57.87918

# Create a logical vector 'zlog' that is TRUE for z values>30 and FALSE otherwise
zlog <- (z > 30)

# Make a dataframe = zdf with z and zlog as columns
zdf <- data.frame(z, zlog)
View(zdf)

# Change column names
colnames(zdf) <- c("zvec", "zlogic")
View(zdf)

# Make a new column = zvec squared
zdf$zsquared <- (zdf$zvec)^2
View(zdf)

# Subset zdf to include only zsquared > 10 and < 100
subzdf <- subset(zdf, zsquared > 10) 
subzdf <- subzdf[subzdf$zsquared < 100, ]

str(subzdf)
View(subzdf)

# Subset zdf to include only the values on row 26
zdf26 <- subset(zdf[26,])
View(zdf26)

# Subset zdf to include only the values in the column zsquared in the 180th row
zdf180 <- zdf[180, 3]
View(zdf180)

# Committing and pushing to GitHub
csv <- read.csv("/Users/brynleighpayne/Downloads/TipsR.csv", na.strings = "na")
View(csv)
