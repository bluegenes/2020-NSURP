# slighly modified from https://raw.githubusercontent.com/ngs-docs/2018-cicese-metatranscriptomics/master/scripts/mds_plot.R
args = commandArgs(trailingOnly=TRUE)

library(ggplot2)
library(ggrepel)

comp <- read.csv(args[1])

# Label the rows
rownames(comp) <- colnames(comp)

# Transform for plotting
comp <- as.matrix(comp)

fit <- dist(comp)
fit <- cmdscale(fit)
fit <- as.data.frame(fit)

fit$lab <- rownames(fit) 

plt <- ggplot(fit, aes(x = V1, y = V2)) +
        geom_point() + 
        geom_label_repel(label = fit$lab) + 
        theme_minimal() +
        ggtitle("MDS plot of sourmash compare on reads")

pdf(file = args[2], width = 6, height = 5)
plt
dev.off()
