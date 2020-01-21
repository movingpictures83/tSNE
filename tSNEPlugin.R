# Clear R workspace
#rm(list=ls(all=TRUE))
#library(ggbiplot)
library(tsne)

input <- function(inputfile) {
  parameters <<- read.table(inputfile, as.is=T);
  rownames(parameters) <<- parameters[,1]
  group <<- c()
  #legend <<- c()
  doGroups <<- "false";
  data1 <<- c()
  data2 <<- c()
  data1 <<- read.csv(toString(parameters["input1",2]), header=T, row.names=1)
  for (i in 1:nrow(data1)) {
     group <<- rbind(group, "A - Healthy")
     #legend <<- rbind(legend,1)
  }
  if (is.na(parameters["input2", 2])) {
     data_t <<- data.frame(data1);
  }
  else {
     data2 <<- read.csv(toString(parameters["input2",2]), header=T, row.names=1)
     for (i in 1:nrow(data2)) {
        group <<- rbind(group, "B - Disease")
        doGroups <<- "true";
        #legend <<- rbind(legend,1)
     }
  }
  data_t <<- data.frame(rbind(data1, data2))
  names_t <<- rownames(data_t)#c()
}


run <- function() {
#######
# tSNE#
#######
data.tsne <<- tsne(data_t)

   
}

output <- function(outputfile) {
   #plot(data.pca, type="lines", file=toString(parameters["varianceplot",2]))
   #write.csv(data.pca$x, toString(parameters["plotdata",2]))
   #write.csv(data.pca$rotation, toString(parameters["rotationdata",2]))
   #plot(data.pca, type="lines", file=paste(outputfile, ".variance.pdf", sep=""))
   write.csv(data.tsne, file=outputfile)
   #write.csv(data.pca$rotation, file=paste(outputfile, ".rotation.csv", sep=""))

   #dpi=600
   #pdf(file=paste(outputfile, ".graph.pdf", sep=""))
   #if (doGroups == "true") {
   #g <- ggbiplot(data.pca, obs.scale = 1, var.scale = 1,
   #            ellipse = TRUE, ellipse.prob = 0.80, groups=group,
   #            labels = names_t, 
   #            circle = FALSE, var.axes=FALSE, alpha=0)
   # g <- g + geom_point(aes(shape=groups,colour=groups),size = 4)
   # g <- g + theme(legend.direction = 'horizontal', 
   #             legend.position = 'top')
   # g <- g + scale_color_manual(name='Class', values=c('#9900ff','#0000ff','#009933', '#000000', '#ff0000'))
   # g <- g + scale_shape(name='Class')
   #} 
   #else {
   #g <- ggbiplot(data.pca)
   #   b <- data.pca$rotation[2,"PC1"] / data.pca$rotation[1,"PC1"]
   #   #plot(0,b);
   #   a <- as.numeric(data.pca$center[2]) - (b*as.numeric(data.pca$center[1]))
   #   g <- g + geom_abline(slope=a,intercept=b,col="red");
#
#      b2 <- data.pca$rotation[1,"PC2"] / data.pca$rotation[2,"PC2"]
#      #plot(0,b2);
#      a2 <- as.numeric(data.pca$center[2]) - (b2*as.numeric(data.pca$center[1]))
#      g <- g + geom_abline(slope=a2,intercept=b2,col="blue")
#      print(b);
#      print(a);
#      print(b2);
#      print(a2);
#   }
#   ggsave(filename=paste(outputfile, ".graph.pdf", sep=""), plot=g, device="pdf");
   #dev.off();
}
