#!/usr/bin/env Rscript

#Run performance benchmark and evaluate time and memory consumption
dir <- "/Users/mass/Documents/Projects/Cell_clustering/UCell_demo/"
setwd(dir)
renv::activate()
library(UCell)
library(AUCell)
library(Matrix)

script <- "run_benchmark_UCell.R"

method <- "UCell"  # args[0]
size <- 1000 # args[1]
ram <- "8Gb" # args[2]
datapath <- "/Users/mass/Documents/Projects/Cell_clustering/UCell_demo/data/sub" # args[3]

command <- sprintf("Rscript --vanilla %s %s %s %s %s", script, method, size, ram, datapath)
system(command)
