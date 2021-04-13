## Gene signature enrichment using UCell

In this repo we host code and scripts to run [UCell](https://github.com/carmonalab/UCell) in different settings.

* `UCell_vignette_Seurat.Rmd` and `UCell_vignette_matrix.Rmd` can be used to reproduce the vignettes (in .html) hosted on github.io:

   + [Signature enrichment analysis with UCell](https://carmonalab.github.io/UCell/UCell_matrix_vignette.html)
   + [Using UCell with Seurat objects](https://carmonalab.github.io/UCell/UCell_Seurat_vignette.html)

* `UCell_figures4paper.Rmd` contains the code to the reproduce the figures of the accompanying manuscript (ADD LINK)

* `UCell_benchmarks.small.machines.Rmd` has tips to simulate machines with smaller memory, to benchmark the method with different computational resources.

* `wrapper_benchmark_UCell.R` (which in turn runs `run_benchmark_UCell.R`) can be used to evaluate running time and peak memory for UCell or AUCell, with datasets of different size


More information at the UCell [GitHub repo](https://github.com/carmonalab/UCell)