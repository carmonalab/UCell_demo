## Gene signature enrichment using UCell

In this repo we host code and scripts to run [UCell](https://github.com/carmonalab/UCell) in different settings.

* `UCell_vignette_Seurat.Rmd`, `UCell_vignette_matrix.Rmd` and `UCell_vignette_TILstates.Rmd` can be used to reproduce the vignettes (in .html) hosted on github.io:

   + [Signature enrichment analysis with UCell](https://carmonalab.github.io/UCell_demo/UCell_matrix_vignette.html)
   + [Using UCell with Seurat objects](https://carmonalab.github.io/UCell_demo/UCell_Seurat_vignette.html)
   + [Using UCell and Seurat to identify different T cell subtypes/states in human tumors](https://carmonalab.github.io/UCell_demo/UCell_vignette_TILstates.html)

* `UCell_figures4paper.Rmd` contains the code to the reproduce the figures of the [accompanying manuscript](https://doi.org/10.1101/2021.04.13.439670)

* `UCell_benchmarks.small.machines.Rmd` has tips to simulate machines with smaller memory, to benchmark the method with different computational resources.

* `wrapper_benchmark_UCell.R` (which in turn runs `run_benchmark_UCell.R`) can be used to evaluate running time and peak memory for UCell or AUCell, with datasets of different size


More information at the UCell [Bioconductor page](https://bioconductor.org/packages/release/bioc/html/UCell.html) and [GitHub repo](https://github.com/carmonalab/UCell)
