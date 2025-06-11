# Per species #

# Read in the data
SPECIES <- read.delim("SPECIES.txt")  

# Check structure of data
str (SPECIES)

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

# Check structure of data 
str (SPECIES)

# Subset the data for each species
EG <- subset(SPECIES, VAR == 'EG') 
EU <- subset(SPECIES, VAR == 'EU') 
CA <- subset(SPECIES, VAR == 'CA') 
CX <- subset(SPECIES, VAR == 'CX') 

###### Cladocalyx (CX) ########

# trees replaced in August 2024?
sum(CX$AUG) # Total of 51 replaced 

#trees replaced in August 2024?
sum(CX$OCT) # Total of 29 replaced 

## trees never replaced?
SCORE0 <- subset(CX, SCORE == '0') 
SCORE0["SCORE"][SCORE0["SCORE"] == 0] <- NA
sum(is.na(SCORE0)) # 504 never replaced

#trees replaced once?
SCORE1 <- subset(CX, SCORE == '1') 
sum(SCORE1$SCORE) # 64 replaced once

# trees replaced twice?
SCORE2 <- subset(CX, SCORE == '2') 
sum(SCORE2$SCORE) # 16 replaced twice

###### Gradis(EG) ########

#trees replaced in August 2024?
sum(EG$AUG) # Total of 47 replaced 

# trees replaced in August 2024?
sum(EG$OCT) # Total of 26 replaced 

##trees never replaced?
SCORE0 <- subset(EG, SCORE == '0') 
SCORE0["SCORE"][SCORE0["SCORE"] == 0] <- NA
sum(is.na(SCORE0)) # 522 never replaced

#trees replaced once?
SCORE1 <- subset(EG, SCORE == '1') 
sum(SCORE1$SCORE) # 35 replaced once

# trees replaced twice?
SCORE2 <- subset(EG, SCORE == '2') 
sum(SCORE2$SCORE) # 38 replaced twice




###### Europhylla(EU) ########

#trees replaced in August 2024?
sum(EU$AUG) # Total of 97 replaced 

# trees replaced in August 2024?
sum(EU$OCT) # Total of 45 replaced 

## trees never replaced?
SCORE0 <- subset(EU, SCORE == '0') 
SCORE0["SCORE"][SCORE0["SCORE"] == 0] <- NA
sum(is.na(SCORE0)) # 445 never replaced

# trees replaced once?
SCORE1 <- subset(EU, SCORE == '1') 
sum(SCORE1$SCORE) # 120 replaced once

#trees replaced twice?
SCORE2 <- subset(EU, SCORE == '2') 
sum(SCORE2$SCORE) # 22 replaced twice





###### Cloeziana(CA) ########

#trees replaced in August 2024?
sum(CA$AUG) # Total of 44 replaced 

#trees replaced in August 2024?
sum(CA$OCT) # Total of 133  replaced 

## trees never replaced?
SCORE0 <- subset(CA, SCORE == '0') 
SCORE0["SCORE"][SCORE0["SCORE"] == 0] <- NA
sum(is.na(SCORE0)) # 411 never replaced

#trees replaced once?
SCORE1 <- subset(CA, SCORE == '1') 
sum(SCORE1$SCORE) # 153 replaced once

#trees replaced twice?
SCORE2 <- subset(CA, SCORE == '2') 
sum(SCORE2$SCORE) # 24 replaced twice


