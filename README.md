
<!-- README.md is generated from README.Rmd. Please edit that file -->

# traudem

<!-- badges: start -->
<!-- badges: end -->

The goal of traudem is to wrap the CLI TauDEM from R.

## Installation

Refer to `vignette("traudem-installation", package = "traudem")`. In
particular after installing the TauDEM CLI and dependencies as well as
the R package, please run `traudem::taudem_sitrep()`.

``` r
traudem::taudem_sitrep()
#> ✔ Found GDAL version 3.0.4.
#> ✔ Found mpiexec (OpenRTE) 4.0.3 (MPI).
#> ✔ Found TauDEM path (/usr/local/taudem).
#> ✔ Found TauDEM executables directory (/usr/local/taudem).
#> ✔ Found all TauDEM executables.
#> ℹ Testing TauDEM on an example file...
#> ── TauDEM output ───────────────────────────────────────────────────────────────
#> PitRemove version 5.3.9
#> Input file MED_01_01.tif has projected coordinate system.
#> Nodata value input to create partition from file: -340282299999999994960115009090224128000.000000
#> Nodata value recast to float used in partition raster: -340282306073709652508363335590014353408.000000
#> Processes: 4
#> Header read time: 0.005135
#> Data read time: 0.002699
#> Compute time: 0.063982
#> Write time: 0.007840
#> Total time: 0.079656
#> This run may take on the order of 1 minutes to complete.
#> This estimate is very approximate. 
#> Run time is highly uncertain as it depends on the complexity of the input data 
#> and speed and memory of the computer. This estimate is based on our testing on 
#> a dual quad core Dell Xeon E5405 2.0GHz PC with 16GB RAM.
#> ── End of TauDEM output ────────────────────────────────────────────────────────
#> ✔ Was able to launch a TauDEM example!
#> ! Make sure you see no serious error message above.
```

You can install the development version of traudem from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("cynkra/traudem")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(traudem)
test_dir <- withr::local_tempdir()
fs::file_copy(
  system.file("test-data", "MED_01_01.tif", package = "traudem"),
  file.path(test_dir, "MED_01_01.tif")
)
output <- taudem_pitremove(file.path(test_dir, "MED_01_01.tif"))
#> PitRemove version 5.3.9
#> Input file /tmp/Rtmp32923X/file4bed4c0c5e73/MED_01_01.tif has projected coordinate system.
#> Nodata value input to create partition from file: -340282299999999994960115009090224128000.000000
#> Nodata value recast to float used in partition raster: -340282306073709652508363335590014353408.000000
#> Processes: 1
#> Header read time: 0.008560
#> Data read time: 0.005683
#> Compute time: 0.129115
#> Write time: 0.010529
#> Total time: 0.153886
#> This run may take on the order of 1 minutes to complete.
#> This estimate is very approximate. 
#> Run time is highly uncertain as it depends on the complexity of the input data 
#> and speed and memory of the computer. This estimate is based on our testing on 
#> a dual quad core Dell Xeon E5405 2.0GHz PC with 16GB RAM.
output
#> /tmp/Rtmp32923X/file4bed4c0c5e73/MED_01_01fel.tif
```
