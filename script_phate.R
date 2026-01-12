# 1. Load Required Packages
library(phateR)
library(ggplot2)
library(ggpubr)
library(stringr)
library(microbiome) 

# 2. Load Data
input_table <- "genus.csv"  
input_meta      <- "metadata.csv"    

if(file.exists(input_table) & file.exists(input_meta)){
  
  otu_raw <- read.csv(input_table, header=TRUE, row.names=1)
  meta_data <- read.csv(input_meta, header=TRUE, row.names=1)
  
  if(ncol(otu_raw) > nrow(otu_raw) & !("Bacteria" %in% rownames(otu_raw))) {
    otu_mat <- as.matrix(otu_raw)
  } else {
    otu_mat <- as.matrix(t(otu_raw))
  }
  
  common_samples <- intersect(rownames(otu_mat), rownames(meta_data))
  otu_mat <- otu_mat[common_samples, ]
  meta_data <- meta_data[common_samples, ]
  
} else {
  stop("Input files not found. Please check filenames.")
}

# 3. Preprocessing (Prevalence Filtering)
prev <- colMeans(otu_mat > 0) # Simple prevalence calculation
taxa_to_keep <- names(prev[prev > 0.2])
otu_filtered <- otu_mat[, taxa_to_keep]


# 4. Run PHATE
set.seed(12345) 

message("Running PHATE embedding...")
phate_res <- phate(otu_filtered)
phate_coords <- as.data.frame(phate_res)

phate_df <- cbind(phate_coords, meta_data)

# 5. Visualization

phate_df$Disease <- str_to_title(phate_df$Disease) 
phate_df$Disease <- factor(phate_df$Disease, 
                            levels=c("Normal", "Fatty_liver", "Hepatitis","Cirrhosis", "Liver_cancer"))

if("dmm3" %in% colnames(phate_df)){
  phate_df$dmm3 <- factor(phate_df$dmm3, levels = c("Bact", "Low-R", "Prev")) 
}

plot_cat <- ggplot(phate_df, aes(x = PHATE1, y = PHATE2, color = Disease)) + 
  geom_point(size = 3, alpha = 0.8) + 
  theme_minimal() +
  scale_color_manual(values=c("#4575b4", "#abd9e9", "#d9d9d9","#fdae61", "#d73027")) +
  theme(text = element_text(size = 14),
        strip.text.x = element_text(size = 15),
        axis.text.x = element_text(colour="black", size=13), axis.ticks.x=element_blank(),
        axis.text.y = element_text(colour="black", size=13), axis.ticks.y=element_blank()) +
  ggtitle("PHATE: Liver Disease")

plot_dmm <- ggplot(phate_df, aes(x = PHATE1, y = PHATE2, color = dmm3)) + 
  geom_point(size = 3, alpha = 0.8) + 
  theme_minimal() +
  scale_color_manual(values=c("#f0943b", "#eb5752", "#347881")) + # Orange, Red, Darkgreen
  theme(text = element_text(size = 14),
        strip.text.x = element_text(size = 15),
        axis.text.x = element_text(colour="black", size=13), axis.ticks.x=element_blank(),
        axis.text.y = element_text(colour="black", size=13), axis.ticks.y=element_blank()) +
  ggtitle("PHATE: Enterotype")
