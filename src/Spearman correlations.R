############## Per species ##############

# Read in the data
SPECIES <- read.delim("SPECIES.txt")  

# Check structure of data
str (SPECIES)

# To make sure all variables are numeric for spearman correlations
SPECIES$AUG    <- as.numeric(SPECIES$AUG)
SPECIES$OCT    <- as.numeric(SPECIES$OCT)
SPECIES$SCORE    <- as.numeric(SPECIES$SCORE)
SPECIES$Cartref    <- as.numeric(SPECIES$Cartref)
SPECIES$Glenrosa    <- as.numeric(SPECIES$Glenrosa)
SPECIES$Oakleaf    <- as.numeric(SPECIES$Oakleaf)
SPECIES$Tukulu    <- as.numeric(SPECIES$Tukulu)
SPECIES$Westleigh    <- as.numeric(SPECIES$Westleigh)
SPECIES$FineSand    <- as.numeric(SPECIES$FineSand)
SPECIES$FineSandyLoam    <- as.numeric(SPECIES$FineSandyLoam)
SPECIES$LoamyFineSand    <- as.numeric(SPECIES$LoamyFineSand)
SPECIES$SoilSuitIndex    <- as.numeric(SPECIES$SoilSuitIndex)
SPECIES$EffectRootDepth    <- as.numeric(SPECIES$EffectRootDepth)
SPECIES$Elevation    <- as.numeric(SPECIES$Elevation)
SPECIES$Slope    <- as.numeric(SPECIES$Slope)
SPECIES$Roughness    <- as.numeric(SPECIES$Roughness)
SPECIES$Ruggedness    <- as.numeric(SPECIES$Ruggedness)

# Check structure of data again
str (SPECIES)

# Subset the data for each species
EG <- subset(SPECIES, VAR == 'EG') 
EU <- subset(SPECIES, VAR == 'EU') 
CA <- subset(SPECIES, VAR == 'CA') 
CX <- subset(SPECIES, VAR == 'CX') 
SCORE <-subset(SPECIES, VAR=='SCORE')

# Spearman correlations
#install.packages ("Hmisc") 
library(Hmisc)

### for cladocalyx
# Select column 2 to 18 only
pairs(CX [,2:18]) 

mycor<-rcorr(as.matrix(CX[2:18]), type="spearman")
mycor$r  # Spearman correlation coefficient
mycor$P  # p value

library(xlsx)
write.xlsx(mycor$r, 'mycor_new.xlsx')

### for grandis
pairs(EG [,2:18]) 

mycorEG<-rcorr(as.matrix(EG[2:18]), type="spearman")
mycorEG$r # Spearman correlation EG coefficient
mycorEG$P # p value
library(xlsx)
write.xlsx(mycorEG$r, 'mycorEG1R.xlsx')
write.xlsx(mycorEG$P, 'mycorEG1P.xlsx')

### for urophylla
pairs(EU [,2:18]) 

mycorEU<-rcorr(as.matrix(EU[2:18]), type="spearman")
mycorEU$r # Spearman correlation EU coefficient
mycorEU$P # p value
library(xlsx)
write.xlsx(mycorEG$r, 'mycorEu1R.xlsx')
write.xlsx(mycorEG$P, 'mycorEu1P.xlsx')



### for cloeziana
pairs(CA [,2:18]) 

mycorCA<-rcorr(as.matrix(CA[2:18]), type="spearman")
mycorCA$r # Spearman correlation CA coefficient
mycorCA$P # p value
library(xlsx)
write.xlsx(mycorCA$r, 'mycorCA1R.xlsx')
write.xlsx(mycorCA$P, 'mycorCA1P.xlsx')







