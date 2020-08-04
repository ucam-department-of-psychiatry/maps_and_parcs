plotGoF <- function(mapfile, plotdir){
  
  outfile <- strsplit(mapfile,'map2map_')[[1]][2]
  outfile <- strsplit(outfile,'.csv')[[1]][1]
  outfile <- paste(plotdir,'/',outfile,'.png',sep="")
  
  df <- read.csv(mapfile, header = TRUE)

  df2 <- melt(df, id.vars = "label2", measure.vars = "Gof")

  require(ggridges)
  require(ggplot2)
  figure <- ggplot(data=df, aes(y=label2,x=Gof,fill=label2)) +
    geom_density_ridges(alpha = 0.5) +
    scale_fill_viridis(discrete = TRUE) 

  png(file = outfile)
    plot(figure)
  dev.off()

}