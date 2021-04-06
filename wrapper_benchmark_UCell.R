#!/usr/bin/env Rscript

#Run performance benchmark and evaluate time and memory consumption
dir <- "/Users/mass/Documents/Projects/Cell_clustering/UCell_demo/"
setwd(dir)
renv::activate()
library(UCell)
library(AUCell)
library(Matrix)

script <- "run_benchmark_UCell.R"

method <- "UCell"  # args[1]
ram <- "8Gb" # args[3]
datapath <- "/Users/mass/Documents/Projects/Cell_clustering/UCell_demo/data/sub" # args[4]
outfile <- sprintf("%s/bench_results/%s.%s.bench.test.txt", dir, method, ram)  # args[5]
#size <- 1000 # args[2]
#seed <- 1 #args[6]

sizes <- c(100, 200, 500, 1000, 2000, 5000, 1e4, 2e4, 5e4, 1e5)
seeds <- c(1,2,3,4,5)

columns <- c("Method", "Size", "Machine_RAM", "Seed", "PeakMemory", "Time")
write(paste(columns, collapse = "\t"), outfile)

for (size in sizes) {
	for (seed in seeds) {

		command <- sprintf("Rscript --vanilla %s %s %s %s %s %s %s", script, method, size, ram, datapath, outfile, seed)

		print("Executing:")
		print(command)		

		system(command)
	}
}