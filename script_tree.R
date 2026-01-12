# 1. Load Required Packages
library(ape)
library(ggtree)
library(ggplot2)

# 2. Load Metadata
input_meta <- "metatadat.csv" 

if(file.exists(input_meta)){
  meta_full <- read.csv(input_meta, stringsAsFactors = FALSE)
  rownames(meta_full) <- meta_full$sample 
} else {
  stop("Metadata file not found.")
}

group_colors <- c(
  Cirrhosis = "#E69F00",
  Hepatitis = "#56B4E9",
  Liver_Cancer = "#009E73",
  Public_Cirrhosis = "#F0E442",
  Control = "#0072B2",
  Public_Cirrhosis_Control = "#D55E00",
  Public_Cirrhosis_Control_Saliva = "#CC79A7",
  Public_Cirrhosis_Feces = "#999999",
  Public_Cirrhosis_Saliva = "#8dd3c7",
  Public_NAFLD = "#fb8072",
  Public_Cirrhosis_Control_Feces = "#80b1d3",
  Public_Liver_Cancer = "#fdb462",
  Public_NAFLD_Control = "#b3de69",
  Public_Cirrhosis = "#fccde5"
)

# 3. Plot Tree 1: Veillonella parvula (SGB6939)
input_tree_vp <- "Tree_SGB6939_V_parvula.tre" 

if(file.exists(input_tree_vp)){
  tree_vp <- read.tree(input_tree_vp)
  meta_vp <- meta_full[meta_full$sample %in% tree_vp$tip.label, ]
  
  vp_plot <- ggtree(tree_vp) %<+% meta_vp +
    geom_tiplab(aes(label = sample_id), size = 3, offset = 0.002) + 
    geom_tippoint(aes(color = group), size = 4) +
    theme_tree2() +
    ggtitle("Veillonella parvula") +
    scale_color_manual(values = group_colors) +
    theme(legend.position = "none") # Hide legend for the first plot
} else {
  message("Tree file for V. parvula not found.")
  vp_plot <- NULL
}

# 4. Plot Tree 2: Veillonella atypica (SGB6936)
input_tree_va <- "Tree_SGB6936_V_atypica.tre" 

if(file.exists(input_tree_va)){
  tree_va <- read.tree(input_tree_va)
  meta_va <- meta_full[meta_full$sample %in% tree_va$tip.label, ]
  
  va_plot <- ggtree(tree_va) %<+% meta_va +
    geom_tiplab(aes(label = sample_id), size = 3, offset = 0.002) + 
    geom_tippoint(aes(color = group), size = 4) +
    theme_tree2() +
    ggtitle("Veillonella atypica") +
    scale_color_manual(values = group_colors) +
    theme(legend.position = "right") + 
    guides(color = guide_legend(title = NULL))
} else {
  message("Tree file for V. atypica not found.")
  va_plot <- NULL
}