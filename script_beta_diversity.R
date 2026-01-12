# 1. Load Required Packages
library(vegan)
library(ggplot2)

# 2. Load Data
input_genus <- "genus.csv"  
input_meta  <- "metadata.csv"   

if(file.exists(input_genus) & file.exists(input_meta)){
  
  genus_raw <- read.csv(input_genus, header=TRUE, row.names=1)
  genus_data <- as.data.frame(t(genus_raw)) 
  meta_data <- read.csv(input_meta, header=TRUE, row.names=1)
  common_samples <- intersect(rownames(genus_data), rownames(meta_data))
  genus_data <- genus_data[common_samples, ]
  meta_data <- meta_data[common_samples, ]
  
} else {
  stop("Input files not found. Please check filenames.")
}


# 3. PCoA Ordination & Plotting

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