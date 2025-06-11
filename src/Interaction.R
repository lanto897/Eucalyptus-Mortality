
# install.packages(c("ggplot2", "patchwork"))
library(ggplot2)
library(patchwork)

# Read in the data
ALLDATA <- read.delim("ALLDATA.txt")

# Check structure of data
str(ALLDATA)

# Ensure variables are correctly formatted
ALLDATA$Species <- as.factor(ALLDATA$Species)
ALLDATA$AUG <- as.numeric(ALLDATA$AUG)
ALLDATA$OCT <- as.numeric(ALLDATA$OCT)

# Check structure again
str(ALLDATA)

# Define common theme elements with reduced axis title font size
common_theme <- theme_classic() +
  theme(
    axis.text = element_text(size = 12, color = "black"),
    axis.title = element_text(size = 10, color = "black", face = "bold"), # Reduced from 14 to 10
    legend.title = element_blank(),
    legend.text = element_text(size = 12, color = "black"),
    legend.position = "top",
    legend.key.size = unit(1, 'cm'),
    legend.background = element_rect(fill = "white", color = NA),
    axis.line = element_line(size = 0.5, colour = "black"),
    axis.ticks = element_line(size = 0.5, color = "black")
  )

# Define common scale for colors
common_colors <- scale_color_manual(
  values = c("black", "purple", "coral1", "cornflowerblue"),
  labels = c("E. cloeziana", "E. cladocalyx", "E. grandis", "E. urophylla")
)


# Plot 1: August Roughness (AvROUGH)
p1 <- ggplot(ALLDATA, aes(x = AvROUGH, y = AUG, color = Species)) +
  geom_point(size = 4) +
  geom_smooth(method = lm, se = FALSE, fullrange = TRUE, size = 1.5) +
  xlab("Terrain Roughness") +
  ylab("Number of Replaced Trees") +
  common_colors +
  common_theme +
  ylim(0, 40)

# Plot 2: October Elevation (y=OCT)
p2 <- ggplot(ALLDATA, aes(x = AvELEV, y = OCT, color = Species)) +
  geom_point(size = 4) +
  geom_smooth(method = lm, se = FALSE, fullrange = TRUE, size = 1.5) +
  xlab("Elevation (m)") +
  ylab("Number of Replaced Trees") +
  common_colors +
  common_theme +
  ylim(0, 40)

# Plot 3: August Slope
p3 <- ggplot(ALLDATA, aes(x = AvSLOPE, y = AUG, color = Species)) +
  geom_point(size = 4) +
  geom_smooth(method = lm, se = FALSE, fullrange = TRUE, size = 1.5) +
  xlab("Slope (degrees)") +
  ylab("Number of Replaced Trees") +
  common_colors +
  common_theme +
  ylim(0, 40)

# Plot 4: August Ruggedness (AvRUGG)
p4 <- ggplot(ALLDATA, aes(x = AvRUGG, y = AUG, color = Species)) +
  geom_point(size = 4) +
  geom_smooth(method = lm, se = FALSE, fullrange = TRUE, size = 1.5) +
  xlab("Terrain Ruggedness") +
  ylab("Number of Replaced Trees") +
  common_colors +
  common_theme +
  ylim(0, 40)

# Plot 5: August SSI
p5 <- ggplot(ALLDATA, aes(x = AvSSI, y = AUG, color = Species)) +
  geom_point(size = 4) +
  geom_smooth(method = lm, se = FALSE, fullrange = TRUE, size = 1.5) +
  xlab("Soil Suitability Index") +
  ylab("Number of Replaced Trees") +
  common_colors +
  common_theme +
  ylim(0, 40)

# Plot 6: August ERD
p6 <- ggplot(ALLDATA, aes(x = AvERD, y = AUG, color = Species)) +
  geom_point(size = 4) +
  geom_smooth(method = lm, se = FALSE, fullrange = TRUE, size = 1.5) +
  xlab("Effective Rooting Depth (m)") +
  ylab("Number of Replaced Trees") +
  common_colors +
  common_theme +
  ylim(0, 40)

# Combine plots in a 3x2 grid with subplot labels
combined_plot <- (p1 + labs(tag = "(a)") + 
                    p2 + labs(tag = "(b)") + 
                    p3 + labs(tag = "(c)") + 
                    p4 + labs(tag = "(d)") + 
                    p5 + labs(tag = "(e)") + 
                    p6 + labs(tag = "(f)")) +
  plot_layout(ncol = 2, nrow = 3) +
  plot_annotation(
    theme = theme(plot.title = element_text(hjust = 0.5, face = "bold", size = 16))
  ) &
  theme(plot.tag = element_text(face = "bold", size = 12))

# Save as high-resolution PNG to fill an A4 page (portrait)
ggsave("combined_eucalyptus_plots.png", combined_plot, width = 8.27, height = 11.69, dpi = 300, units = "in")

# Display the plot
print(combined_plot)
