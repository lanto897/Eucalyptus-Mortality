# Read in the data
ALLDATA <- read.delim("ALLDATA.txt")  

# Check structure of data
str (ALLDATA)

# All variables are the correct structure
ALLDATA$Species    <- as.factor(ALLDATA$Species)
ALLDATA$DomForm    <- as.factor(ALLDATA$DomForm)
ALLDATA$DomTexture    <- as.factor(ALLDATA$DomTexture)

ALLDATA$AUG   <- as.numeric(ALLDATA$AUG)
ALLDATA$OCT    <- as.numeric(ALLDATA$OCT)

ALLDATA$Oakleaf   <- as.numeric(ALLDATA$Oakleaf)
ALLDATA$Glenrosa    <- as.numeric(ALLDATA$Glenrosa)
ALLDATA$Tukulu   <- as.numeric(ALLDATA$Tukulu)
ALLDATA$Westleigh    <- as.numeric(ALLDATA$Westleigh)

ALLDATA$FineSandyLoam    <- as.numeric(ALLDATA$FineSandyLoam)
ALLDATA$FineSand   <- as.numeric(ALLDATA$FineSand)
ALLDATA$LoamyFineSand    <- as.numeric(ALLDATA$LoamyFineSand)

# Check structure of data
str (ALLDATA)

# Normality testing
#install.packages ("nortest") #Install once
library (nortest)

shapiro.test (ALLDATA$AUG) # Not normal
shapiro.test (ALLDATA$OCT) # Not normal

# Distribution of data
#install.packages ("fitdistrplus") #Install once
library(fitdistrplus)


# August data
normal.f <- fitdist(ALLDATA$AUG, "norm")   # normal
pois.f <- fitdist(ALLDATA$AUG, "pois")     # poisson
negBin.f <- fitdist(ALLDATA$AUG, "nbinom") # negative binomial

normal.f$aic 
pois.f$aic 
negBin.f$aic # Negative binomial lowest.


# October data
normal.f <- fitdist(ALLDATA$OCT, "norm")   # normal
pois.f <- fitdist(ALLDATA$OCT, "pois")     # poisson
negBin.f <- fitdist(ALLDATA$OCT, "nbinom") # negative binomial

normal.f$aic 
pois.f$aic 
negBin.f$aic # Negative binomial lowest.



#ANOVAS and INTERACTIONS
install.packages ("MASS")
install.packages ("lme4")
install.packages ("multcomp") 
install.packages ("emmeans") 
install.packages ("rcompanion")
install.packages ("multcompView")
install.packages ("FSA") 

library (MASS)
library (lme4)
library (multcomp)
library (emmeans)
library(rcompanion)
library(multcompView)
library(FSA)


# AUGUST ANOVAS
#Species
modGLM <- glm.nb(AUG ~ Species, data = ALLDATA)
anova (modGLM, test = "Chisq") 
Phoc<- dunnTest(AUG ~ Species, data = ALLDATA, method = "none")
Phoc
Phocdunns <- Phoc$res
cld <- cldList(comparison = Phocdunns$Comparison,
               p.value    = Phocdunns$P.adj,
               threshold  = 0.05)[1:2]
names(cld)[1]<-"Species" # change the name of grouping factor according to the dataset (df)
cld

ggplot(ALLDATA, aes(x = Species, y = AUG, fill = Species)) +
  geom_boxplot(fatten = 4, colour = "black", lwd = 1, outlier.shape = NA) + 
  xlab("Species") + 
  ylab("Total trees replaced") + 
  theme_classic() +
  scale_fill_manual(values = c("CA" = "white", 
                               "CX" = "purple", 
                               "EG" = "salmon", 
                               "EU" = "skyblue")) + 
  theme(axis.text = element_text(size = 23, color = "black"),
        axis.title = element_text(size = 30, color = "black", face = "bold"),
        axis.line = element_line(size = 0.75, colour = "black"),
        axis.ticks = element_line(size = 0.75, color = "black"),
        legend.position = "none") +  # Esorina tanteraka ny legend
  scale_x_discrete(labels = c("CA" = "E. cloeziana", 
                              "CX" = "E. cladocalyx", 
                              "EG" = "E. grandis", 
                              "EU" = "E. urophylla")) +
  ylim(0, 30) +
  annotate("text", x = c(1.3, 2.3, 3.3, 4.3), y = c(7.7, 5, 5, 13),
           label = c("a", "a", "a", "a"), size = 8, hjust = 0.5)


# Subset the data for each species
EG <- subset(ALLDATA, Species == 'EG')
EU <- subset(ALLDATA, Species == 'EU')
CA <- subset(ALLDATA, Species == 'CA')
CX <- subset(ALLDATA, Species == 'CX')


# AUGUST INTERACTIONS
#Species * elevation
modGLM <- glm.nb(AUG ~ Species*AvELEV, data = ALLDATA)
anova (modGLM, test = "Chisq") 

## EACH SPECIES* AvELEV
library(MASS)
model <- glm.nb(AUG ~ 0 + Species + Species:AvELEV, data = ALLDATA)

# Summarize model
summary(model)

# Visualize interaction
library(ggplot2)
ggplot(ALLDATA, aes(x = AvELEV, y = AUG, color = Species, shape = Species)) +
  geom_point() +
  geom_smooth(method = "glm.nb", family = "quasipoisson", se = FALSE) +  # Changed to quasipoisson
  labs(title = "Interaction between Species & Elevation in AUG",
       x = "Elevation (AvELEV)", y = "AUG") +
  theme_minimal()

#Species * slope
modGLM <- glm.nb(AUG ~ Species*AvSLOPE, data = ALLDATA)
anova (modGLM, test = "Chisq") 


#Species * roughness
modGLM <- glm.nb(AUG ~ Species*AvROUGH, data = ALLDATA)
anova (modGLM, test = "Chisq") 

#Species * ruggedness
modGLM <- glm.nb(AUG ~ Species*AvRUGG, data = ALLDATA)
anova (modGLM, test = "Chisq") 

#Species * soil suitability
modGLM <- glm.nb(AUG ~ Species*AvSSI, data = ALLDATA)
anova (modGLM, test = "Chisq") 

#Species * effective rooting depth
modGLM <- glm.nb(AUG ~ Species*AvERD, data = ALLDATA)
anova (modGLM, test = "Chisq") 

#Species * DomForm
modGLM <- glm.nb(AUG ~ Species*DomForm, data = ALLDATA)
anova (modGLM, test = "Chisq") 

#Species * DomTexture
modGLM <- glm.nb(AUG ~ Species*DomTexture, data = ALLDATA)
anova (modGLM, test = "Chisq") 



# OCTOBER ANOVAS
# Species
modGLM <- glm.nb(OCT ~ Species, data = ALLDATA)
anova (modGLM, test = "Chisq") 

Phoc<- dunnTest(OCT ~ Species, data = ALLDATA, method = "none")
Phoc
Phocdunns <- Phoc$res
cld <- cldList(comparison = Phocdunns$Comparison,
               p.value    = Phocdunns$P.adj,
               threshold  = 0.05)[1:2]
names(cld)[1]<-"Species" # change the name of grouping factor according to the dataset (df)
cld

ggplot(ALLDATA, aes(x = Species, y = OCT, fill = Species)) +
  geom_boxplot(fatten = 4, colour = "black", lwd = 1, outlier.shape = NA) + 
  xlab("Species") + 
  ylab("Total trees replaced") + 
  theme_classic() +
  scale_fill_manual(values = c("CA" = "white", 
                               "CX" = "purple", 
                               "EG" = "salmon", 
                               "EU" = "skyblue")) + 
  theme(axis.text = element_text(size = 23, color = "black"),
        axis.title = element_text(size = 30, color = "black", face = "bold"),
        axis.line = element_line(size = 0.75, colour = "black"),
        axis.ticks = element_line(size = 0.75, color = "black"),
        legend.position = "none") +  # Esorina tanteraka ny legend
  scale_x_discrete(labels = c("CA" = "E. cloeziana", 
                              "CX" = "E. cladocalyx", 
                              "EG" = "E. grandis", 
                              "EU" = "E. urophylla")) +
  ylim(0, 30) +
  annotate("text", x = c(1.3, 2.3, 3.3, 4.3), y = c(13.2, 4, 4, 7),
           label = c("a", "b", "b", "b"), size = 8, hjust = 0.5)


# OCTOBER INTERACTIONS
#Species * elevation
modGLM <- glm.nb(OCT ~ Species*AvELEV, data = ALLDATA)
anova (modGLM, test = "Chisq") 

#Species * slope
modGLM <- glm.nb(OCT ~ Species*AvSLOPE, data = ALLDATA)
anova (modGLM, test = "Chisq") 

#Species * roughness
modGLM <- glm.nb(OCT ~ Species*AvROUGH, data = ALLDATA)
anova (modGLM, test = "Chisq") 

#Species * ruggedness
modGLM <- glm.nb(OCT ~ Species*AvRUGG, data = ALLDATA)
anova (modGLM, test = "Chisq") 

#Species * soil suitability index
modGLM <- glm.nb(OCT ~ Species*AvSSI, data = ALLDATA)
anova (modGLM, test = "Chisq") 



#Species * effective rooting depth
modGLM <- glm.nb(OCT ~ Species*AvERD, data = ALLDATA)
anova (modGLM, test = "Chisq") 


#Species * DomForm
modGLM <- glm.nb(OCT ~ Species*DomForm, data = ALLDATA)
anova (modGLM, test = "Chisq") 

#Species * DomTexture
modGLM <- glm.nb(OCT ~ Species*DomTexture, data = ALLDATA)
anova (modGLM, test = "Chisq") 


#PLOT 


#OCT~SPECIES *ELEVATION

if (!all(c("Species", "AvELEV", "AUG", "OCT") %in% colnames(ALLDATA))) {
  stop("Required columns not found in ALLDATA.")
}

#for AUG and AvELEV
p_aug_elev <- plot_continuous_interaction("AUG", "AvELEV", ALLDATA)
print(p_aug_elev)
#ggsave("AUG_AvELEV.png", plot = p_aug_elev, width = 8, height = 6, dpi = 300)

#interaction for OCT and AvELEV
p_oct_elev <- plot_continuous_interaction("OCT", "AvELEV", ALLDATA)
print(p_oct_elev)
#ggsave("OCT_AvELEV.png", plot = p_oct_elev, width = 8, height = 6, dpi = 300)



#OCT~SPECIES *SSI
# Check required columns for AvSSI
if (!all(c("Species", "AvELEV", "AUG", "OCT") %in% colnames(ALLDATA))) {
  stop("Required columns not found in ALLDATA.")
}

# Plot and save interaction for AUG and AvSSI
p_aug_ssi <- plot_continuous_interaction("AUG", "AvSSI", ALLDATA)
print(p_aug_ssi)


# Plot and save interaction for OCT and AvSSI
p_oct_ssi<- plot_continuous_interaction("OCT", "AvSSI", ALLDATA)
print(p_oct_ssi)


#OCT~SPECIES *ERD

if (!all(c("Species", "AvELEV", "AUG", "OCT") %in% colnames(ALLDATA))) {
  stop("Required columns not found in ALLDATA.")
}

# Plot and save interaction for AUG and AvERD
p_aug_erd <- plot_continuous_interaction("AUG", "AvERD", ALLDATA)
print(p_aug_erd)


# Plot and save interaction for OCT and AvERD
p_oct_erd <- plot_continuous_interaction("OCT", "AvERD", ALLDATA)
print(p_oct_erd)

#OCT~SPECIES *ROUGH
# Check required columns for AvROUGH
if (!all(c("Species", "AvELEV", "AUG", "OCT") %in% colnames(ALLDATA))) {
  stop("Required columns not found in ALLDATA.")
}

# Plot interaction for AUG and AvROUGH
p_aug_rough <- plot_continuous_interaction("AUG", "AvROUGH", ALLDATA)
print(p_aug_rough)


# Plot interaction for OCT and AvELEV
p_oct_rough <- plot_continuous_interaction("OCT", "AvROUGH", ALLDATA)
print(p_oct_rough)

#OCT~SPECIES *RUGG
# Check required columns for AvRUGG
if (!all(c("Species", "AvELEV", "AUG", "OCT") %in% colnames(ALLDATA))) {
  stop("Required columns not found in ALLDATA.")
}

# interaction for AUG and AvRUGG
p_aug_rugg <- plot_continuous_interaction("AUG", "AvRUGG", ALLDATA)
print(p_aug_rugg)


# Plot interaction for OCT and AvRUGG
p_oct_rugg <- plot_continuous_interaction("OCT", "AvRUGG", ALLDATA)
print(p_oct_rugg)

# Modified plot_continuous_interaction function with yellow changed to vibrant orange
plot_continuous_interaction <- function(response, predictor, data) {
  formula <- as.formula(paste(response, "~ Species *", predictor))
  mod <- glm.nb(formula, data = data)
  
  pred_data <- expand.grid(
    Species = levels(data$Species),
    temp = seq(min(data[[predictor]], na.rm = TRUE), 
               max(data[[predictor]], na.rm = TRUE), 
               length.out = 100)
  )
  names(pred_data)[2] <- predictor
  pred_data$fit <- predict(mod, newdata = pred_data, type = "response")
  
  p <- ggplot(pred_data, aes_string(x = predictor, y = "fit", color = "Species")) +
    geom_line(size = 1.2, alpha = 0.9) +
    labs(
      title = paste(response, "vs", predictor, "by Species"),
      x = predictor,
      y = paste(response, "(Predicted Number of Dead Trees)")
    ) +
    scale_color_manual(values = c("CX" = "#1F77B4", "EU" = "#2CA02C", 
                                  "EG" = "#D62728", "CA" = "#E69F00")) +  # Yellow changed to vibrant orange
    theme_minimal() +
    theme(
      legend.position = "top",
      legend.title = element_text(face = "bold"),
      legend.text = element_text(size = 10),
      plot.title = element_text(face = "bold", size = 12),
      axis.title = element_text(size = 10)
    )
  
  return(p)
}




#OCT~SPECIES *SLOPE
# Check if required columns exist in ALLDATA
if (!all(c("Species", "AvSLOPE", "AUG", "OCT") %in% colnames(ALLDATA))) {
  stop("Required columns (Species, AvSLOPE, AUG, OCT) not found in ALLDATA. Please check your dataset.")
}

# Ensure Species is a factor
ALLDATA$Species <- as.factor(ALLDATA$Species)

# Plot interaction between Species and AvSLOPE for AUG
p_aug_slope <- plot_continuous_interaction("AUG", "AvSLOPE", ALLDATA)
print(p_aug_slope)

# Plot interaction between Species and AvSLOPE for OCT
p_oct_slope <- plot_continuous_interaction("OCT", "AvSLOPE", ALLDATA)
print(p_oct_slope)




