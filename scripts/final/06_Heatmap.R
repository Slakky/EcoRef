library(gplots)
library(RColorBrewer)
df <- read.csv(file = "/home/claudio/nas/output/heatmap_dataframe.tsv", sep = "\t", header = TRUE)
myCol <- c("white", "green")
myBreaks <- c(1, 7, 20)
# pvalues are log transformed
tiff('/home/claudio/nas/heatmap.tiff', width = 3200, height = 3200, units = "px", res = 800, compression = "lzw")
heatmap.2(as.matrix(df[,-1]), dendrogram = "none", 
          Colv = FALSE, trace = "none", breaks = myBreaks, col = myCol, 
          density.info="density",
          lmat = rbind(c(3,4), c(2,1)),
          key.par = list(cex=0.5),
          symkey = FALSE,
          lwid = ()
          key.xlab = paste("-log10(P-value)"),
          labRow = FALSE, labCol = FALSE) # [,-1] because the first column is character and heatmap.2 requires numeric matrix
dev.off()