################################# INTRO #################################
# Libs
library(plyr)
library(readr)
library(tidyverse)
library(DT)
library(desctable)
library(cowplot)
library(corrplot)
library(RColorBrewer)
library(NbClust)
library(factoextra)
library(dendextend)

# Importation des données
wdbc <- read_csv("data/wdbc.data", col_names = FALSE)

# Nom des colonnes
colnames <- c("radius", "texture", "perimeter", "area", "smoothness", "compactness", "concavity",  "concave_points", "symmetry",  "fractal_dimension")
variables <- gsub("_", " ", colnames) %>% str_to_title
colnames_mean <- paste0(colnames, "_mean")
colnames_se <- paste0(colnames, "_se")
colnames_worst <- paste0(colnames, "_worst")
colnames(wdbc) <- c("id", "diagnosis", colnames_mean, colnames_se, colnames_worst)

## Diagnosis en numérique (B=0, M=1)
wdbc2 <- wdbc
wdbc2$diagnosis <- revalue(wdbc$diagnosis, c("B"="0", "M"="1")) %>% as.numeric

################################# CODE ##################################


# Construction du modèle en imposant deux clusters
model_km <- kmeans(wdbc_scaled, 2)
model_km

# Visualisation des clusters
fviz_cluster(data = wdbc_scaled, model_km)

# Vérification par rapport au diagnostic
wdbc2 <- wdbc2 %>% mutate(clusters_km = model_km$cluster)
table(wdbc2$clusters_km, wdbc2$diagnosis)
