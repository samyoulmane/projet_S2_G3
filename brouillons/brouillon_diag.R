# Libs
library(tidyverse)
library(DT)
library(desctable)
library(cowplot)
library(corrplot)
library(RColorBrewer)

# Importation
wdbc <- read_csv("data/wdbc.data", col_names = FALSE)

features <- c("radius_mean", "texture_mean", "perimeter_mean", "area_mean", "smoothness_mean", "compactness_mean", "concavity_mean", "concave_points_mean", "symmetry_mean", "fractal_dimension_mean", "radius_worst", "texture_worst", "perimeter_worst", "area_worst", "smoothness_worst", "compactness_worst", "concavity_worst", "concave_points_worst", "symmetry_worst", "fractal_dimension_worst")

# Nom des colonnes
colnames(wdbc) <- c("id",
                     "diagnosis",
                     "radius_mean",
                     "texture_mean",
                     "perimeter_mean",
                     "area_mean",
                     "smoothness_mean",
                     "compactness_mean",
                     "concavity_mean",
                     "concave_points_mean",
                     "symmetry_mean", 
                     "fractal_dimension_mean",
                     "radius_se",
                     "texture_se",
                     "perimeter_se",
                     "area_se",
                     "smoothness_se",
                     "compactness_se",
                     "concavity_se",
                     "concave_points_se",
                     "symmetry_se", 
                     "fractal_dimension_se",
                     "radius_worst",
                     "texture_worst",
                     "perimeter_worst",
                     "area_worst",
                     "smoothness_worst",
                     "compactness_worst",
                     "concavity_worst",
                     "concave_points_worst",
                     "symmetry_worst", 
                     "fractal_dimension_worst")

wdbc$diagnosis <- factor(wdbc$diagnosis)

# Description
desctable(wdbc) %>% datatable

# Graphiques
draw_g <- function(value = "radius_mean") {
  ggplot(data = wdbc) +
    aes_string(x = value, fill = "diagnosis") +
    geom_density(adjust = 1) +
    theme_minimal() +
    theme(legend.position = 'none', axis.text.y = element_text())
}

lapply(features, draw_g) -> a

plot_grid(plotlist = a)

cor_data <- cor(wdbc[,c(-1, -2)])

col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))
corrplot(cor_data, method = "color", col = col(200),
         type = "upper", order = "hclust", number.cex = .7,
         addCoef.col = "black", # Add coefficient of correlation
         tl.col = "black", tl.srt = 90, # Text label color and rotation
         # Combine with significance
         p.mat = p.mat, sig.level = 0.01, insig = "blank", 
         # hide correlation coefficient on the principal diagonal
         diag = FALSE)
