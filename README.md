
<!-- README.md is generated from README.Rmd. Please edit that file -->

# traudem

<!-- badges: start -->
<!-- badges: end -->

The goal of traudem is to wrap the [TauDEM
CLI](https://hydrology.usu.edu/taudem/taudem5/index.html) from R.

## Installation

Refer to
[`vignette("taudem-installation", package = "traudem")`](https://lucarraro.github.io/traudem/articles/taudem-installation.html).
In particular after installing the TauDEM CLI and dependencies as well
as the R package, please run `traudem::taudem_sitrep()`.

``` r
traudem::taudem_sitrep()
#> ✔ Found GDAL version 3.0.4.
#> ✔ Found mpiexec (OpenRTE) 4.0.3 (MPI).
#> ✔ Found TauDEM path (/usr/local/taudem).
#> ✔ Found TauDEM executables directory (/usr/local/taudem).
#> ✔ Found all TauDEM executables.
#> ℹ Testing TauDEM on an example file (please wait a bit)...
#> ── TauDEM output ───────────────────────────────────────────────────────────────
#> PitRemove version 5.3.9
#> Input file DEM.tif has projected coordinate system.
#> Nodata value input to create partition from file: nan
#> Nodata value recast to float used in partition raster: nan
#> Processes: 1
#> Header read time: 0.006746
#> Data read time: 0.001771
#> Compute time: 0.019569
#> Write time: 0.002272
#> Total time: 0.030358
#> This run may take on the order of 1 minutes to complete.
#> This estimate is very approximate. 
#> Run time is highly uncertain as it depends on the complexity of the input data 
#> and speed and memory of the computer. This estimate is based on our testing on 
#> a dual quad core Dell Xeon E5405 2.0GHz PC with 16GB RAM.
#> ── End of TauDEM output ────────────────────────────────────────────────────────
#> ✔ Was able to launch a TauDEM example!
#> ! Make sure you see no serious error message above.
```

You can install the development version of traudem from R-universe:

``` r
# Enable repository from lucarraro
options(
  repos = c(
    lucarraro = 'https://lucarraro.r-universe.dev',
    CRAN = 'https://cloud.r-project.org'
  )
)
# Download and install traudem in R
install.packages('traudem')
```

Or from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("lucarraro/traudem")
```

## Example

This is how you would use traudem to launch [TauDEM’s
PitRemove](https://hydrology.usu.edu/taudem/taudem5/help53/PitRemove.html):

``` r
library(traudem)
test_dir <- withr::local_tempdir()
fs::file_copy(
  system.file("test-data", "DEM.tif", package = "traudem"),
  file.path(test_dir, "DEM.tif")
)
output <- taudem_pitremove(file.path(test_dir, "DEM.tif"))
#> PitRemove version 5.3.9
#> Input file /tmp/RtmpE4euyO/file30dadaad4b1/DEM.tif has projected coordinate system.
#> Nodata value input to create partition from file: nan
#> Nodata value recast to float used in partition raster: nan
#> Processes: 1
#> Header read time: 0.007956
#> Data read time: 0.002180
#> Compute time: 0.021669
#> Write time: 0.001902
#> Total time: 0.033708
#> This run may take on the order of 1 minutes to complete.
#> This estimate is very approximate. 
#> Run time is highly uncertain as it depends on the complexity of the input data 
#> and speed and memory of the computer. This estimate is based on our testing on 
#> a dual quad core Dell Xeon E5405 2.0GHz PC with 16GB RAM.
output
#> [1] "/tmp/RtmpE4euyO/file30dadaad4b1/DEMfel.tif"
```

We ran the example above in a temporary directory that `withr`
automatically deletes. If you want to automatically get rid of some of
the intermediary files created by TauDEM in one of your pipelines, you
might be interested in `withr::local_tempfile()`.

If you wanted to run this same code without seeing the messages from
TauDEM you can either use the `quiet` argument:

``` r
test_dir <- withr::local_tempdir()
fs::file_copy(
  system.file("test-data", "DEM.tif", package = "traudem"),
  file.path(test_dir, "DEM.tif")
)
output <- taudem_pitremove(file.path(test_dir, "DEM.tif"), quiet = TRUE)
output
#> [1] "/tmp/RtmpE4euyO/file30da6c305b40/DEMfel.tif"
```

Or set the `traudem.quiet` option (`options(traudem.quiet = TRUE)` or
for just the session, `withr::local_options(traudem.quiet = TRUE)`):

``` r
withr::local_options(traudem.quiet = TRUE)
test_dir <- withr::local_tempdir()
fs::file_copy(
  system.file("test-data", "DEM.tif", package = "traudem"),
  file.path(test_dir, "DEM.tif")
)
output <- taudem_pitremove(file.path(test_dir, "DEM.tif"))
output
#> [1] "/tmp/RtmpE4euyO/file30da4666aed3/DEMfel.tif"
```

## Can traudem run all TauDEM methods?

Yes! Some TauDEM methods have dedicated wrappers like
`taudem_pitremove()`, with argument names that we strived to make
informative. For other methods, you can use `taudem_exec()` and provide
the arguments as TauDEM CLI would expect them. You could make a PR to
this repository to add more dedicated wrappers.
