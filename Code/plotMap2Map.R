plotMap2Map <- function (mapfile, plotdir) {
  require(ggalluvial)
  require(ggplot2)
  require(viridis)
  
  df <- read.csv(mapfile, header = T)
  df$annot1_idx <- as.factor((df$annot1_idx))
  df$annot2_idx <- as.factor((df$annot2_idx))
  
  outfile <- strsplit(mapfile,'map2map_')[[1]][2]
  outfile <- strsplit(outfile,'.csv')[[1]][1]
  outfile <- paste(plotdir,'/',outfile,'.pdf',sep="")
  
  figure <- ggplot(data = df,
         aes(axis1 = label1, axis2 = label2)) +
    scale_x_discrete(limits = c("annot1_idx", "annot2_idx"),
                     expand = c(.1, .05)) +
    xlab("Annotation") +
    geom_alluvium(aes(fill = Gof),colour = "black") +
    geom_stratum() +
    geom_text(stat = "stratum", label.strata = TRUE) +
    scale_fill_viridis() +
    theme_minimal()
  
  pdf(file = outfile)
    plot(figure)
  dev.off()
  
}