### PLPA 5820 Intro to R
## Coding Challenge #2 Data Visualization

#### Load in Data ####
Myco <- read.csv("/Users/brynleighpayne/Downloads/MycotoxinData.csv", na.strings = "na")
View(Myco)
str(Myco)

#### Make Plots ####
# Install and load
install.packages("ggplot2")
library(ggplot2)

# Question 2 - Make boxplot 
ggplot(Myco, aes(x = Treatment, y = DON, color = Cultivar)) +
  geom_boxplot() +
  xlab("") +
  ylab("DON (ppm)")

# Question 3 - Convert data into bar chart
# Use stat_summary()
# Use geom = "bar" and dodged the positions of the bars
ggplot(Myco, aes(x = Treatment, y = DON, color = Cultivar)) +
  stat_summary(fun = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_se, geom = "errorbar", position = "dodge") +
  xlab("") +
  ylab("DON (ppm)")

# Question 4 - Add points that show distribution 
# Added fill for Cultivar, outlined points in black, and specified shape
ggplot(Myco, aes(x = Treatment, y = DON, color = Cultivar, fill = Cultivar)) +
  stat_summary(fun = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_se, geom = "errorbar", position = "dodge") +
  xlab("") +
  ylab("DON (ppm)") +
  geom_point(color = "black", position = position_jitterdodge(dodge.width = 0.9), shape = 21) 

# Question 5 - Add fill for colorblind palette
# Add scale_fill_manual() layer for the points and bars
cbbPalette <- c("#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

ggplot(Myco, aes(x = Treatment, y = DON, fill = Cultivar)) +
  stat_summary(fun = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_se, geom = "errorbar", position = "dodge") +
  xlab("") +
  ylab("DON (ppm)") +
  geom_point(color = "black", position = position_jitterdodge(dodge.width = 0.9), shape = 21) +
  scale_fill_manual(values = cbbPalette) 

# Question 6 - Add a facet based on Cultivar
# Add facet_wrap() layer and scaled to only include relevant axis points
ggplot(Myco, aes(x = Treatment, y = DON, fill = Cultivar)) +
  stat_summary(fun = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_se, geom = "errorbar", position = "dodge") +
  xlab("") +
  ylab("DON (ppm)") +
  geom_point(color = "black", position = position_jitterdodge(dodge.width = 0.9), shape = 21) +
  scale_fill_manual(values = cbbPalette) +
  facet_wrap(~Cultivar, scale = "free")

# Question 7 - Add transparency
# Add alpha for transparency, 0 = fully transparent 1 = fully opaque
ggplot(Myco, aes(x = Treatment, y = DON, fill = Cultivar)) +
  stat_summary(fun = mean, geom = "bar", position = "dodge") +
  stat_summary(fun.data = mean_se, geom = "errorbar", position = "dodge") +
  xlab("") +
  ylab("DON (ppm)") +
  geom_point(color = "black", position = position_jitterdodge(dodge.width = 0.9), shape = 21, alpha = 0.5) +
  scale_fill_manual(values = cbbPalette) +
  facet_wrap(~Cultivar, scale = "free")

# Question 8 - Explore a new way to plot the same data
# Violin plot to show distribution density using geom_violin()
ggplot(Myco, aes(x = Treatment, y = DON, fill = Cultivar)) +
  stat_summary(fun = mean, position = "dodge") +
  stat_summary(fun.data = mean_se, position = "dodge") +
  xlab("") +
  ylab("DON (ppm)") +
  geom_violin(trim=FALSE,  position = position_dodge(width = 0.9), scale = "width", adjust = 0.6) +
  geom_point(color = "black", position = position_jitterdodge(dodge.width = 0.9), shape = 21, alpha = 0.5) +
  scale_fill_manual(values = cbbPalette) +
  facet_wrap(~Cultivar, scale = "free")



