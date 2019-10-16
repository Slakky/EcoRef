library(qqman)
library(scales)
library(data.table)
path = '~/Desktop/Plots/'
file.names <- dir(path, pattern = '*.plot')
env.unique <- unique(sapply(strsplit(file.names, '\\.'), "[[", 1))
conditions <- sapply(strsplit(file.names, '\\.'), "[[", 1)
cond.freq <- as.data.frame(table(conditions))
max.env <- cond.freq[cond.freq$Freq == max(cond.freq$Freq), 2]

## initialize empty list
df.list <- list()

## loops through evert condition
for (i in seq_along(env.unique)){
## gets subconditions according to matching pattern 
  files <- dir(path, pattern = sprintf('%s.*', env.unique[i]))
## loops through every subcondition
  for (u in seq_along(files)){
    df <- read.table(paste(path, files[u], sep=""), stringsAsFactors = F, header = T)
    df$COND <- rep(sprintf('%s', env.unique[i]), nrow(df))
    df.list[[u]] <- df
  }
  ##  binding dataframes of the same condition
  df.plot <- rbindlist(df.list[1:length(files)]) 
  
  ## plots here
  #conditions <- alpha(c("#FF470C", "#1172AB", "#09BA60", "#FF920C"), 0.5)
}

