library(gplots)
library(RColorBrewer)
df <- read.csv(file = "/home/claudio/nas/output/heatmap_dataframe.tsv", sep = "\t", header = TRUE)
myCol <- brewer.pal(4, "Set3")[3:4]
myBreaks <- c(1, 7, 10)
tiff('/home/claudio/nas/heatmap.tiff', width = 3200, height = 3200, units = "px", res = 800, compression = "lzw")
heatmap.2(as.matrix(df[,-1]), dendrogram = "row",  
          Colv = FALSE, trace = "none", breaks = myBreaks, col = myCol, 
          density.info="density",
          lmat = rbind(c(3,4), c(2,1)),
          lwid = c(2,7),
          lhei = c(1.5,9),
          keysize = 0.3,
          key.par = list(cex=0.3),
          symkey = FALSE,
          key.xlab = paste("-log10(P-value)"),
          labRow = FALSE, labCol = FALSE) # [,-1] because the first column is character 
dev.off()