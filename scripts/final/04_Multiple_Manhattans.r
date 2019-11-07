library(qqman)
library(scales)
library(data.table)
library(RColorBrewer)
path = '~/Desktop/Manhattans/'
output = '~/Desktop/Plots/'

## get all the file names with extensions from the path folder
file.names <- dir(path, pattern = '*.plot')

## header sanity check
headers.list <- lapply(paste(path,file.names, sep = ""), readLines, n = 1 )
if (length(unique(headers.list)) != 1){
  stop("The headers of your files do not match!")
}

## vector with every condition
cond.unique <- unique(sapply(strsplit(file.names, '\\.'), "[[", 1))
 
df.list <- list()
nr.df = 0
last.position = 1


## loops integer through every condition
for (i in seq_along(cond.unique)){
  ## all files with the given condition 
  files <- dir(path, pattern = sprintf('^%s.*.plot', cond.unique[i]))
  ## vector with every subcondition 
  subconditions <- sapply(strsplit(files, '\\.'), "[[", 2)
  ## loops through every subcondition
  for (u in seq_along(files)){
    df <- read.table(paste(path, files[u], sep=""), stringsAsFactors = F, header = T)
    
    nr.df <- nr.df + 1
    # Creates new COND column
    df$COND <- rep(sprintf('%s %s', cond.unique[i], subconditions[u]), nrow(df))
    names(df) <- NULL
    df.list[[nr.df]] <- df
  }
  ##  binding dataframes of the same condition to a single plottable df
  df.plot <- rbindlist(df.list[last.position:nr.df])
  names(df.plot) <- c(unlist(strsplit(headers.list[[1]], " ")), "COND")
  last.position <- nr.df + 1
    ## plots here
  tiff(paste(output,sprintf('%s.tiff', cond.unique[i])), units = "in", width = 5, height = 5, res = 300)
  colors <- alpha(c(brewer.pal(n = length(files), name = 'Dark2')), 0.5)
  manhattan(df.plot, cex = 0.25, col = colors, suggestiveline = F)
  dev.off()
}

## LEGACY CODE - chunks of code not used but usefull for future reference ##

## frequency table of how many sub conditions (0M, 0.5M, 1M) every condition has
#cond.freq <- as.data.frame(table(sapply(strsplit(file.names, '\\.'), "[[", 1)))

#max.env <- cond.freq[cond.freq$Freq == max(cond.freq$Freq), 2]

