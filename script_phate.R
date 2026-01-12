# 1. Load Required Packages
library(phateR)
library(ggplot2)
library(ggpubr)
library(stringr)
library(microbiome)
library(phyloseq)

# 2. Load Data
genus_raw <- read.csv("phate_genus.csv", header=TRUE, row.names=1, check.names=FALSE)
meta_data <- read.csv("metadata.csv",  header=TRUE, row.names=1, check.names=FALSE)

# 3. Harmonize sample IDs (intersection + same order)
common_samples <- intersect(rownames(genus_raw), rownames(meta_data))
if (length(common_samples) < 2) stop("Not enough overlapping samples between genus table and metadata.")

genus_raw <- genus_raw[common_samples, , drop=FALSE]
meta_data <- meta_data[common_samples, , drop=FALSE]

# Ensure identical ordering
genus_raw <- genus_raw[rownames(meta_data), , drop=FALSE]

# 4. Create OTU matrix (samples x taxa)
otu_mat <- as.matrix(genus_raw)

# 5. Preprocessing: Prevalence Filtering (keep taxa present in >20% of samples)
prev <- colMeans(otu_mat > 0, na.rm = TRUE)
taxa_to_keep <- names(prev[prev > 0.2])

if (length(taxa_to_keep) == 0) {
  stop("No taxa passed prevalence filtering at threshold > 0.2. Check your OTU table or adjust threshold.")
}

otu_filtered <- otu_mat[, taxa_to_keep, drop = FALSE]

# 6. Run PHATE
set.seed(12345) 

phate_res <- phate(otu_filtered)
phate_coords <- as.data.frame(phate_res)

phate_df <- cbind(phate_coords, meta_data)

# 7. Visualization

phate_df$Disease <- str_to_title(phate_df$Disease) 
phate_df$Disease <- factor(phate_df$Disease, 
                            levels=c("Normal", "Fatty_liver", "Hepatitis","Cirrhosis", "Liver_cancer"))


ggplot(phate_df, aes(x = PHATE1, y = PHATE2, color = Disease)) + 
  geom_point(size = 3, alpha = 0.8) + 
  theme_minimal() +
  scale_color_manual(values=c("#4575b4", "#abd9e9", "#d9d9d9","#fdae61", "#d73027")) +
  theme(text = element_text(size = 14),
        strip.text.x = element_text(size = 15),
        axis.text.x = element_text(colour="black", size=13), axis.ticks.x=element_blank(),
        axis.text.y = element_text(colour="black", size=13), axis.ticks.y=element_blank()) +
  ggtitle("PHATE: Liver Disease")

