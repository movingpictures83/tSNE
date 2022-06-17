library(ggplot2)
library(ggrepel)
library(cowplot)
library(plspm)
library(Rtsne)

dyn.load(paste("RPluMA", .Platform$dynlib.ext, sep=""))
source("RPluMA.R")

input <- function(inputfile) {
  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1];
    pfix = prefix()
  if (length(pfix) != 0) {
     pfix <- paste(pfix, "/", sep="")
  }

mydata <- read.csv(paste(pfix, parameters["csvfile", 2], sep="/"), check.names=FALSE)
mydata <- as.data.frame(mydata)
numeric_vars <- readLines(paste(pfix, parameters["features", 2], sep="/"))
mydata_num <<- mydata[, numeric_vars]
mydata_num$classification <<- "normal"

parameters_cats <<- read.table(paste(pfix, parameters["categories", 2], sep="/"), as.is=T);
cats <- c()
for (i in 1:nrow(parameters_cats)) {
   cat_samples <- readLines(paste(pfix, parameters_cats[i,2], sep="/"))
   cats <- c(cats, cat_samples)
   mydata_num$classification[match(cat_samples, rownames(mydata_num))] <<- parameters_cats[i,1]
}

mydata_num_sub <<- match(
  cats,
  rownames(mydata_num)
)

mydata_num$label <<- ""
mydata_num$label[mydata_num_sub] <<- rownames(mydata_num)[mydata_num_sub]

#thecols <<- readLines(paste(pfix, parameters["columns", 2], sep="/"))
}

run <- function() {}

output <- function(outputfile) {
tsne_data_num <- Rtsne(mydata_num[, 1:as.integer(parameters["variables", 2])],
  pca = FALSE, perplexity = as.integer(parameters["perplexity", 2]),
  theta = as.numeric(parameters["theta", 2])
)

tsne_data_num <- data.frame(
  TSNE1 = tsne_data_num$Y[, 1],
  TSNE2 = tsne_data_num$Y[, 2],
  label = mydata_num$label,
  classification = mydata_num$classification
)

yy <<- ggplot(tsne_data_num, aes(
  x = TSNE1, y = TSNE2,
  label = label, col = classification
)) +
  geom_point()
	
	write.csv(yy$label, paste(outputfile, "csv", sep="."))
ggsave(outputfile)
}
