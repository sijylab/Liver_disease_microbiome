# Liver Disease Microbiome

This repository contains the source code and processed data files required to reproduce the analyses and figures presented in the manuscript:


---

## 1. Data Availability

### Raw Sequencing Data
All raw 16S rRNA gene and shotgun metagenomic sequencing reads generated in this study have been deposited in the NCBI Sequence Read Archive (SRA) under the following accession numbers:

**PRJNA1281303, PRJNA1281307, PRJNA1281308, PRJNA1281344, PRJNA1281347, PRJNA1281352, PRJNA1281353, PRJNA1281362, PRJNA1281365, PRJNA1281367**

---

### Processed Data & Metadata

The processed data files provided in this repository are organized as follows:

#### `data/raw/`
- **Supple_table_ASV.csv** (and .zip): Raw ASV count table.
- **Supple_table_ASV_taxa.csv**: Taxonomic classification corresponding to each ASV.
- **Supple_table_species.xlsx**: Processed species-level abundance table derived from ASV data.
- **Supple_table_KO.xlsx**: KEGG Orthology (KO) functional annotation table inferred from the microbiome data.

#### `data/processed/`
- **beta_genus.csv**: Genus-level abundance table used as input for beta diversity and DMM clustering analyses.
- **phate_genus.csv**: Genus-level abundance table used as input for PHATE dimensionality reduction analysis.

These processed genus-level tables were derived from the ASV tables after standard filtering, normalization, and taxonomic aggregation steps as described in the Methods section of the manuscript.

#### Metadata
Sample metadata (including disease stage, age, sex, and BMI) are provided as a Supplementary Table accompanying the published manuscript.  
For reproducibility, users should export the metadata table as `metadata.csv` and place it in the working directory when running the scripts.

---

## 2. Analysis Scripts

### Diversity, Clustering, and Ordination
- **script_beta_diversity.R**: Calculates beta diversity metrics and generates PCoA plots  
  *Input:* `data/processed/beta_genus.csv`, `metadata.csv`
- **script_dmm.R**: Performs Dirichlet Multinomial Mixtures (DMM) modeling to identify community types  
  *Input:* `data/processed/beta_genus.csv`, `metadata.csv`
- **script_phate.R**: Performs PHATE dimensionality reduction analysis  
  *Input:* `data/processed/phate_genus.csv`, `metadata.csv`
- **script_tree.R**: Phylogenetic tree construction and manipulation associated with the analysis

---

### Machine Learning Analysis
All machine learning models and validation scripts used in this study are maintained in a separate repository:

🔗 https://github.com/jorgevazcast/Liver_Disease_Microbiome_ML

Please refer to that repository for full reproducibility of the machine learning analyses.

---

## 3. System Requirements & Dependencies

- **R version:** 4.3.0
- **Key packages:**  
  `DirichletMultinomial`, `vegan`, `phateR`, `ape`, `phyloseq`, `microbiome`, `ggplot2`, `ggpubr`

---

## 4. Usage Instructions

1. Clone or download this repository.
2. Place the metadata file (`metadata.csv`) in your working directory.
3. Run the analysis scripts in the following order, as needed:
   - `script_beta_diversity.R` (beta diversity and ordination)
   - `script_dmm.R` (community clustering)
   - `script_phate.R` (PHATE analysis)
   - `script_tree.R` (phylogenetic analyses)

Each script contains internal comments describing required input formats and preprocessing steps.
