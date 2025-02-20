### PLPA 5820 Intro to R
## Homework Coding Notes Data Visualization #2
# Advanced Visualization

# Load/Install Packages
library(tidyverse)
install.packages("ggpubr")
library(ggpubr)
library(ggrepel)

# Make vector containing custom color palette
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

# Load in Data
sample.data.bac <- read.csv("/Users/brynleighpayne/Downloads/BacterialAlpha.csv", na.strings = "na")
str(sample.data.bac)

# Make variables "Time_Point" and "Crop" into a Factor instead of an Integer
sample.data.bac$Time_Point <- as.factor(sample.data.bac$Time_Point)
str(sample.data.bac)
sample.data.bac$Crop <- as.factor(sample.data.bac$Crop)
str(sample.data.bac)

# Change ggplot's automatic alphabetical order
sample.data.bac$Crop <- factor(sample.data.bac$Crop, levels = c("Soil", "Cotton", "Soybean"))

#### Stitching multiple plots together: https://journals.asm.org/doi/10.1128/spectrum.00377-23 ####
# Plot one - B
bac.even <- ggplot(sample.data.bac, aes(x = Time_Point, y = even, color = Crop)) + # Define aesthetics
  geom_boxplot(position = position_dodge()) + # Add boxplots with dodged positions
  geom_point(position = position_jitterdodge(0.05)) + # Add jittered points for individual points
  xlab("Time") + # Label the x axis
  ylab("Pielou's evenness") + # Label the y axis
  scale_color_manual(values = cbbPalette) + # Manually set colors
  theme_classic() # Use a classic theme for the plot
bac.even # Plot the ggplot object

# Plot 2 - A
sample.data.bac.nosoil <- subset(sample.data.bac, Crop != "Soil") # Remove Soil variable

water.imbibed <- ggplot(sample.data.bac.nosoil, aes(Time_Point, 1000 * Water_Imbibed, color = Crop)) +  # Define aesthetics: x-axis as Time.Point, y-axis as Water_Imbibed (converted to mg), and color by Crop
  geom_jitter(width = 0.5, alpha = 0.5) +  # Add jittered points to show individual data points with some transparency
  stat_summary(fun = mean, geom = "line", aes(group = Crop)) +  # Add lines representing the mean value for each Crop group
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.5) +  # Add error bars representing the standard error of the mean
  xlab("Hours post sowing") +  # Label the x-axis
  ylab("Water Imbibed (mg)") +  # Label the y-axis
  scale_color_manual(values = c(cbbPalette[[2]], cbbPalette[[3]]), name = "", labels = c("", "")) +  # Manually set colors for the Crop variable
  theme_classic() +  # Use a classic theme for the plot
  theme(strip.background = element_blank(), legend.position = "none") +  # Customize theme: remove strip background and position legend to the right
  facet_wrap(~Crop, scales = "free")  # Create separate panels for each Crop, allowing free scales
water.imbibed

# Plot 3 - C
water.imbibed.cor <- ggplot(sample.data.bac.nosoil, aes(y = even, x = 1000 * Water_Imbibed, color = Crop)) +  # Define aesthetics: y-axis as even, x-axis as Water_Imbibed (converted to mg), and color by Crop
  geom_point(aes(shape = Time_Point)) +  # Add points with different shapes based on Time.Point
  geom_smooth(se = FALSE, method = lm) +  # Add a linear model smooth line without confidence interval shading
  xlab("Water Imbibed (mg)") +  # Label the x-axis
  ylab("Pielou's evenness") +  # Label the y-axis
  scale_color_manual(values = c(cbbPalette[[2]], cbbPalette[[3]]), name = "", labels = c("Cotton", "Soybean")) +  # Manually set colors for the Crop variable
  scale_shape_manual(values = c(15, 16, 17, 18), name = "", labels = c("0 hrs", "6 hrs", "12 hrs", "18 hrs")) +  # Manually set shapes for the Time.Point variable
  theme_classic() +  # Use a classic theme for the plot
  theme(strip.background = element_blank(), legend.position = "none") +
  facet_wrap(~Crop, scales = "free")  # Create separate panels for each Crop, allowing free scales

water.imbibed.cor

# Put the plots together
# Arrange multiple ggplot objects into a single figure
figure2 <- ggarrange(
  water.imbibed,  # First plot: water.imbibed
  bac.even,  # Second plot: bac.even
  water.imbibed.cor,  # Third plot: water.imbibed.cor
  labels = "auto",  # Automatically label the plots (A, B, C, etc.)
  nrow = 3,  # Arrange the plots in 3 rows
  ncol = 1,  # Arrange the plots in 1 column
  legend = FALSE  # Do not include a legend in the combined figure
)
figure2

# Integrating basic statistics into plots for exploratory analyses
bac.even +
  stat_compare_means(method = "anova") # Add layer for Anova

bac.even +
  geom_pwc(aes(group = Crop), method = "t_test", label = "p.adj.format") # pvalues as significance levels

bac.even +
  geom_pwc(aes(group = Crop), method = "t_test", label = "p.adj.signif") # With * to indicate significance

bac.even + 
  geom_pwc(aes(group = Crop), method = "t_test", label = "{p.adj.format}{p.adj.signif}") # Combined

# Displaying correlation data
water.imbibed.cor +
  stat_cor() + # Add in linear regression line
  stat_regline_equation() # Add in linear regression equation

# Specific point labeling
# Figure 4
# Read in new dataset - differential abundance test
diff.abund <- read.csv("/Users/brynleighpayne/Downloads/diff_abund.csv")
str(diff.abund)

# Transform pvalue to allow for better visualization
diff.abund$log10_pvalue <- -log10(diff.abund$p_CropSoybean)
diff.abund.label <- diff.abund[diff.abund$log10_pvalue > 25,]

# Make the plot
ggplot() + 
  geom_point(data = diff.abund, aes(x = lfc_CropSoybean, y = log10_pvalue, color = diff_CropSoybean)) + 
  theme_classic() +
  geom_text_repel(data = diff.abund.label, aes(x = lfc_CropSoybean, y = log10_pvalue, color = diff_CropSoybean, label = Label)) 

# Add manual colorblind friendly scheme and axes labels 
ggplot() + 
  geom_point(data = diff.abund, aes(x = lfc_CropSoybean, y = log10_pvalue, color = diff_CropSoybean)) + 
  theme_classic() +
  geom_text_repel(data = diff.abund.label, aes(x = lfc_CropSoybean, y = log10_pvalue, color = diff_CropSoybean, label = Label)) +
  scale_color_manual(values = cbbPalette, name = "Significant") +
  xlab("Log fold change soil vs. soybean") +
  ylab("-log10 p-value")

# Emphasize certain points as a different shape and/or color
ggplot() + 
  geom_point(data = diff.abund, aes(x = lfc_CropSoybean, y = log10_pvalue, color = diff_CropSoybean)) + 
  geom_point(data = diff.abund.label, aes(x = lfc_CropSoybean, y = log10_pvalue, color = diff_CropSoybean), shape = 17, color = "red", size = 4) + 
  theme_classic() +
  geom_text_repel(data = diff.abund.label, aes(x = lfc_CropSoybean, y = log10_pvalue, color = diff_CropSoybean, label = Label), color = "red") +
  scale_color_manual(values = cbbPalette, name = "Significant") +
  xlab("Log fold change soil vs. soybean") +
  ylab("-log10 p-value")

#### EXTRA: Adding significance letters to represent multiple pairwise comparisons of an ANOVA
# Loading required packages
library(lme4)
library(emmeans) #version 1.8.7
library(multcomp)
library(multcompView)

# Read in the data
STAND <- read.csv("raw_data_valent2023_pythium_seedtreatment.csv", na.strings = "na")

# Calculating the mean by groups
ave_stand <- STAND %>%
  filter(days_post_planting != "173 days after planting") %>%
  group_by(Plot, Treatment_name, Rep, days_post_planting) %>%
  dplyr::summarize(
    ave.stand = mean(stand, na.rm=TRUE))

# Linear model
lm <- lmer(ave.stand ~ Treatment_name*days_post_planting + (1|Rep), data = ave_stand)
car::Anova(lm)

lsmeans <- emmeans(lm, ~Treatment_name|days_post_planting) # estimate lsmeans of variety within siteXyear
Results_lsmeansEC <- multcomp::cld(lsmeans, alpha = 0.05, reversed = TRUE, details = TRUE,  Letters = letters) # contrast with Tukey ajustment
Results_lsmeansEC

# Extracting the letters for the bars
sig.diff.letters <- data.frame(Results_lsmeansEC$emmeans$Treatment_name, 
                               Results_lsmeansEC$emmeans$days_post_planting,
                               str_trim(Results_lsmeansEC$emmeans$.group))
colnames(sig.diff.letters) <- c("Treatment_name", 
                                "days_post_planting",
                                "Letters")

# for plotting with letters from significance test
ave_stand2 <- ave_stand %>%
  group_by(Treatment_name, days_post_planting) %>%
  dplyr::summarize(
    ave.stand2 = mean(ave.stand, na.rm=TRUE),
    se = sd(ave.stand)/sqrt(4)) %>%
  left_join(sig.diff.letters) 

ave_stand$Treatment_name <- factor(ave_stand$Treatment_name, levels = c("Neg. control",
                                                                        "Pos. control",
                                                                        "Intego Suite",
                                                                        "V-10525",
                                                                        "Cruiser Maxx",
                                                                        "Cruiser Maxx + Vayantis",
                                                                        "V-10522",
                                                                        "V-10522 + Lumisena"))

ave_stand$days_post_planting <- factor(ave_stand$days_post_planting, levels = c("8 days after planting",
                                                                                "15 days after planting", 
                                                                                "21 days after planting",
                                                                                "29 days after planting"))

# Final plot with the letters on the bars
ggplot(ave_stand, aes(x = Treatment_name, y = ave.stand)) + 
  stat_summary(fun=mean,geom="bar") +
  stat_summary(fun.data = mean_se, geom = "errorbar", width = 0.5) +
  ylab("Number of emerged plants") + 
  geom_jitter(width = 0.02, alpha = 0.5) +
  geom_text(data = ave_stand2, aes(label = Letters, y = ave.stand2+(3*se)), vjust = -0.5) +
  xlab("")+
  theme_classic() +
  theme(
    strip.background = element_rect(color="white", fill="white", size=1.5, linetype="solid"),
    strip.text.x = element_text(size = 12, color = "black"),
    axis.text.x = element_text(angle = 45, vjust = 1, hjust=1)) +
  facet_wrap(~days_post_planting)


