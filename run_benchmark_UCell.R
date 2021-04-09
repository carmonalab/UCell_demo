#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

method <- args[1]
size <- as.numeric(args[2])
ram <- args[3]
datapath <- args[4]
outfile <- args[5]
#for MA: /Users/mass/Documents/Projects/Cell_clustering/UCell_demo/data/sub
seed <- as.numeric(args[6])


chunk.size <- 1000
force.gc <- FALSE
size <- formatC(size, format="d")

#Use these signatures
ft <- list()
ft$Tcell_CD4 <- c("CD4","CD40LG")
ft$Tcell_CD8 <- c("CD8A","CD8B")
ft$Tcell_Treg <- c("FOXP3","IL2RA")
ft$Tcell_MAIT <- c("KLRB1", "SLC4A10", "NCR3")
ft$Tcell_gd <- c("TRDC", "TRGC1", "TRGC2", "TRDV1")
ft$Tcell_NK <- c("FGFBP2", "SPON2", "KLRF1", "FCGR3A", "KLRD1", "TRDC")

#Read in data (pre-subset in a different script)
matrix.sub <- sprintf("%s/pbmc.expmat.%s.rds", datapath, size)


this.data <- readRDS(matrix.sub)


#"CD4" %in% rownames(this.data)
#"CD4" %in% rownames(this.data)
#setdiff(unlist(ft), rownames(this.data))



#Initialize results table
results <- data.frame(Method=character(),
                 Size=numeric(), 
                 Machine_RAM=character(), 
                 Seed=numeric(),
                 PeakMemory=numeric(),
                 Time=numeric())

set.seed(seed)

if (method == "UCell") {
  library(UCell)
  
  gc1 <- gc(reset = TRUE)
  t <- system.time({
    
    out <- tryCatch({
      scores_UCell <- UCell::ScoreSignatures_UCell(this.data, features = ft, chunk.size = chunk.size, force.gc = force.gc)
  #    write.table(head(scores_UCell), "aux/UCell.tmp.scores.txt", quote=F)
      1
    },
    error=function(cond) {
      message(cond)
      return(NA)
    })
  })
  gc2 <- gc()
  if (is.na(out)) { #Out of memory
    memPeak <- NA
    time <- NA
  } else {
    memPeak <- sum(gc2[,7]) - sum(gc1[,7])
    time <- t[["elapsed"]]
  }
} else if (method == "AUCell") {
  library(AUCell)
  gc1 <- gc(reset = TRUE)
  t <- system.time({
    
    out <- tryCatch({
      cells_rankings <- AUCell::AUCell_buildRankings(this.data, nCores = 1, plotStats = F)
      cells_AUC <- AUCell::AUCell_calcAUC(ft, cells_rankings, aucMaxRank=1000)
      scores_AUC <- as.data.frame(t(AUCell::getAUC(cells_AUC)))
    #  write.table(head(scores_AUC), "aux/AUCell.tmp.scores.txt", quote=F)
      1
    },
    error=function(cond) {
      message(cond)
      return(NA)
    })
    
  })
  gc2 <- gc()
  if (is.na(out)) { #Out of memory
    memPeak <- NA
    time <- NA
  } else {
    memPeak <- sum(gc2[,7]) - sum(gc1[,7])
    time <- t[["elapsed"]]
  }
}

to.return <- c(method, size, ram, seed, memPeak, time)

write(paste(to.return, collapse = "\t"), outfile, append=TRUE)







