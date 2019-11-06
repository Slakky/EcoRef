library(gplots)
library(RColorBrewer)
df <- read.csv(file = "/home/claudio/nas/output/heatmap_dataframe.tsv", sep = "\t", header = TRUE)
myCol <- brewer.pal(n = 3, name = "Dark2")
myBreaks <- c(0, 7, 5, 1) # pvalues are log transformed
tiff('/home/claudio/nas/heatmap.tiff', width = 1000, height = 1000, compression = "lzw", res = 300)
heatmap.2(as.matrix(df[,-1]), dendrogram = "row", Colv = FALSE, tracecol = NA, breaks = myBreaks, col = myCol) # [,-1] because the first column is character and heatmap.2 requires numeric matrix
