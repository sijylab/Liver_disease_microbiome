# 1. Run DMM Model Selection
set.seed(123) 
library(DirichletMultinomial)
library(lattice)
library(xtable)

fit_counts <- count_matrix
dmn_list <- list()

for(i in 1:6){
  message(paste("Fitting DMM model for K =", i))
  dmn_list[[i]] <- dmn(fit_counts, i, verbose=FALSE)
}

lplc <- sapply(dmn_list, laplace) # Laplace approximation
BIC  <- sapply(dmn_list, BIC)     # Bayesian Information Criterion
AIC  <- sapply(dmn_list, AIC)     # Akaike Information Criterion

best_k <- which.min(lplc)
best_model <- dmn_list[[best_k]]

message(paste("Optimal number of clusters (based on Laplace):", best_k))

pdf("Model_Fit.pdf", onefile=T)
plot(lplc, type="b", main="Model Fit (Laplace)", xlab="Number of Components (K)", ylab="Laplace")
plot(BIC, type="b", main="Model Fit (BIC)", xlab="Number of Components (K)", ylab="BIC")
plot(AIC, type="b", main="Model Fit (AIC)", xlab="Number of Components (K)", ylab="AIC")
dev.off()

# 2. Cluster Assignment
mixture_weights <- mixture(best_model, assign=TRUE)
cluster_assignments <- data.frame(SampleID = rownames(count_matrix), 
                                  Cluster = mixture_weights,
                                  row.names = rownames(count_matrix))
