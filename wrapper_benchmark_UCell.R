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
#sizes <- c(100000)   # args[2]
#seeds <- c(1)    #args[6]
sizes <- c(100, 200, 500, 1000, 2000, 5000, 10000, 20000, 50000, 100000)
seeds <- c(1,2,3,4,5)

#RAM must be set before R startup
Sys.setenv("R_MAX_VSIZE" = ram)
print(Sys.getenv("R_MAX_VSIZE"))


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