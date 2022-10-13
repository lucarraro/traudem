
<!-- README.md is generated from README.Rmd. Please edit that file -->

# traudem

<!-- badges: start -->
<!-- badges: end -->

The goal of traudem is to wrap the [TauDEM
CLI](https://hydrology.usu.edu/taudem/taudem5/index.html) from R.

## Scope of traudem

### What this package does

-   It provides a guide to installation of TauDEM and its dependencies
    GDAL and MPI depending on your operating system.
-   It checks that TauDEM and its dependencies are correctly installed
    and included to the PATH.
-   It provides wrapper commands that allow calling TauDEM methods from
    R.

### What this package does not

-   It does not provide an automatic installation of TauDEM and its
    dependencies. Please refer to the `vignette("taudem-installation")`
    for instructions on this.
-   It does not provide extensive documentation on the functioning of
    TauDEM commands. Please refer to the [original TauDEM
    documentation](https://hydrology.usu.edu/taudem/taudem5/index.html)
    for that.

### Can traudem run all TauDEM methods?

Yes! Some TauDEM methods have dedicated wrappers like
`taudem_pitremove()`, with argument names that we strived to make
informative. For other methods, you can use `taudem_exec()` and provide
the arguments as TauDEM CLI would expect them. You could make a PR to
this repository to add more dedicated wrappers.

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
#> Header read time: 0.004954
#> Data read time: 0.001717
#> Compute time: 0.021168
#> Write time: 0.002009
#> Total time: 0.029847
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

## Simple example

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
#> Input file /tmp/RtmpbCqswi/file76692b8de111/DEM.tif has projected coordinate system.
#> Nodata value input to create partition from file: nan
#> Nodata value recast to float used in partition raster: nan
#> Processes: 1
#> Header read time: 0.009736
#> Data read time: 0.002343
#> Compute time: 0.023287
#> Write time: 0.001966
#> Total time: 0.037332
#> This run may take on the order of 1 minutes to complete.
#> This estimate is very approximate. 
#> Run time is highly uncertain as it depends on the complexity of the input data 
#> and speed and memory of the computer. This estimate is based on our testing on 
#> a dual quad core Dell Xeon E5405 2.0GHz PC with 16GB RAM.
output
#> [1] "/tmp/RtmpbCqswi/file76692b8de111/DEMfel.tif"
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
#> [1] "/tmp/RtmpbCqswi/file7669638dda6c/DEMfel.tif"
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
#> [1] "/tmp/RtmpbCqswi/file76695855c446/DEMfel.tif"
```
