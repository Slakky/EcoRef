library(gplots)
library(RColorBrewer)
df <- read.csv(file = "/home/claudio/nas/output/heatmap_dataframe.tsv", sep = "\t", header = TRUE)
myCol <- c("#e5f5f9","#99d8c9","#2ca25f")
myBreaks <- c(1, 5, 7, 20) # pvalues are log transformed
tiff('/home/claudio/nas/heatmap.tiff', width = 1000, height = 1000, compression = "lzw", res = 300)
heatmap.2(as.matrix(df[,-1]), dendrogram = "row", Colv = FALSE, Rowv=FALSE, density.info = "none", trace = "none", breaks = myBreaks, col = myCol, symkey = FALSE) # [,-1] because the first column is character and heatmap.2 requires numeric matrix