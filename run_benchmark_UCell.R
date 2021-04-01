#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

method <- args[1]
size <- as.numeric(args[2])
ram <- args[3]
datapath <- args[4]
#for MA: /Users/mass/Documents/Projects/Cell_clustering/UCell_demo/data/sub

chunk.size <- 1000
force.gc <- FALSE

Sys.setenv("R_MAX_VSIZE" = ram)
print(Sys.getenv("R_MAX_VSIZE"))

#Use these signatures
features <- list()
features$Tcell_CD4 <- c("CD4","CD40LG")
features$Tcell_CD8 <- c("CD8A","CD8B")
features$Tcell_Treg <- c("FOXP3","IL2RA")
features$Tcell_MAIT <- c("KLRB1", "SLC4A10", "NCR3")
features$Tcell_gd <- c("TRDC", "TRGC1", "TRGC2", "TRDV1")
features$Tcell_NK <- c("FGFBP2", "SPON2", "KLRF1", "FCGR3A", "KLRD1", "TRDC")

#Read in data (pre-subset in a different script)
matrix.sub <- sprintf("%s/pbmc.expmat.%s.rds", datapath, size)


this.data <- readRDS(matrix.sub)


if (method == "UCell") {
  library(UCell)
  
  gc1 <- gc(reset = TRUE)
  t <- system.time({
    
    out <- tryCatch({
      scores_UCell <- UCell::ScoreSignatures_UCell(this.data, features = features, chunk.size = chunk.size, force.gc = force.gc)
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
      cells_AUC <- AUCell::AUCell_calcAUC(features, cells_rankings, aucMaxRank=1000)
      scores_AUC <- as.data.frame(t(AUCell::getAUC(cells_AUC)))
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

to.return <- c(time, memPeak)
print(to.return)

