# Liver disease microbiome

This repository contains the source code and processed data files necessary to reproduce the analysis and figures presented in the manuscript:

> **Title:** Stage-dependent gut microbiome and functional signatures across the liver disease spectrum: an integrative multi-cohort study


---

## 1. Data Availability

### Raw Sequencing Data
The raw sequencing reads generated in this study have been deposited in the NCBI SRA database under the accession number:
* **Accession Number:** PRJNA1281303, PRJNA1281307, PRJNA1281308, PRJNA1281344, PRJNA1281347, PRJNA1281352, PRJNA1281353, PRJNA1281362, PRJNA1281365, and PRJNA1281367


### Processed Data & Metadata
The processed data files included in this repository are:

* **ASV Tables:**
    * `Supple_table_ASV.csv` (and `.zip`): Raw ASV count table.
    * `Supple_table_ASV_taxa.csv`: Taxonomic classification for each ASV.
* **Species-level Data:**
    * `Supple_table_species.xlsx`: Processed species-level abundance table.
* **Functional Annotation:**
    * `Supple_table_KO.xlsx`: KEGG Orthology (KO) functional annotation table inferred from the microbiome data.
* **Metadata:**
    * The sample metadata (including grouping information, age, sex, and BMI) is provided as **Supplementary Table** accompanying the published manuscript.

---

## 2. Analysis Scripts


### Diversity & Clustering (DMM)
* `script_dmm.R`: Script for performing Dirichlet Multinomial Mixtures (DMM) modeling to identify community types.
* `script_beta_diversity.R`: Script for calculating beta diversity metrics (e.g., Bray-Curtis, UniFrac) and PCoA plotting.
* `script_tree.R`: Script for phylogenetic tree construction and manipulation associated with the analysis.
* `script_phate.R`: Script for PHATE dimensionality reduction analysis.

### Machine Learning Analysis
The machine learning models and associated validation scripts used in this study are maintained in a separate repository by the first author. Please refer to the link below for full reproducibility of the ML section:
* **Repository Link:** [https://github.com/jorgevazcast/Liver_Disease_Microbiome_ML]

---

## 3. System Requirements & Dependencies

To run the scripts provided in this repository, the following R packages are required:

* R version: [e.g., 4.2.0]
* Key Packages: `DirichletMultinomial`, `phyloseq`, `vegan`, `phateR`, `tidyverse`, etc.

---

## 4. Usage Instructions

1.  Download the repository.
2.  Unzip `Supple_table_ASV.csv.zip`.
3.  Load the datasets into R using the provided scripts.
4.  Run `script_dmm.R` to reproduce the clustering results shown in Figure [X].

---

## Contact
For any questions regarding the data or code, please contact:
[Your Name/Email or Corresponding Author's Email]
