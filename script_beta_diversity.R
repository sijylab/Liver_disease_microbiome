# 1. Load Required Packages
library(vegan)
library(ggplot2)

# 2. Load Data
genus_raw  <- read.csv("beta_genus.csv", header=TRUE, row.names=1, check.names=FALSE)
meta_data  <- read.csv("metadata.csv",  header=TRUE, row.names=1, check.names=FALSE)  

# 3. PCoA Ordination & Plotting
distance_matrix <- vegdist(genus_raw, method="robust.aitchison", binary=FALSE)

pcoa_res <- cmdscale(distance_matrix, k = 3, eig = TRUE)

eig_var <- round(pcoa_res$eig / sum(pcoa_res$eig) * 100, digits=2)

pcoa_df <- data.frame(PC1 = pcoa_res$points[,1], 
                      PC2 = pcoa_res$points[,2])

plot_data <- cbind(pcoa_df, Disease = meta_data$Disease)

plot_data$Disease <- factor(plot_data$Disease, 
                             levels=c("Normal", "Fatty_liver", "Hepatitis", "Cirrhosis", "Liver_cancer"))

x_lab <- paste0("PCA 1 [", eig_var[1], "%]")
y_lab <- paste0("PCA 2 [", eig_var[2], "%]")

group_colors <- c("#4575b4", "#abd9e9", "#d9d9d9", "#fdae61", "#d73027")

ggplot(plot_data, aes(x = PC1, y = PC2, color = Disease)) +
  geom_point(size=3, alpha=0.8) +
  stat_ellipse(level = 0.9, type = "norm", linetype = 2) +
  labs(x = x_lab, y = y_lab, color = "Group") +
  scale_color_manual(values = group_colors) +
  theme_bw() +
  theme(text = element_text(size = 12),
        axis.text = element_text(color="black", size=11),
        panel.grid = element_blank())
