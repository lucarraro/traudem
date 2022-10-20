#' TauDEM situation report
#'
#' Checks installation of TauDEM and provides useful hints.
#'
#' @return For `taudem_sitrep()`: None.
#' @export
#'
#' @section TauDEM installation and registration:
#'
#' Once you have installed TauDEM, add an environment variable
#' pointing to the correct path.
#' For instance on Ubuntu it could be adding this line in `.Renviron`
#' (see `usethis::edit_r_environ()`)
#' and then re-starting R:
#'
#' ```
#' TAUDEM_PATH='/usr/local/taudem'
#' ```
#'
#' or, for just the session, running this line of R code:
#'
#' ```r
#' Sys.setenv(TAUDEM_PATH = "/usr/local/taudem")
#' ```
#'
#' @examplesIf interactive() && traudem::can_register_taudem()
#' try(taudem_sitrep(), silent = TRUE)
taudem_sitrep <- function() {

  # gdal installed -----
  # not sure which one TauDEM uses by default
  # https://gis.stackexchange.com/questions/246615/different-output-of-gdalinfo-version-and-gdal-config-in-xenial
  gdal_config_res <- withr::local_tempfile()
  gdal_config_ok <- try(sys::exec_wait(
    "gdal-config",
    "--version",
    std_out = gdal_config_res
  ),
    silent = TRUE
  )
  if ((!inherits(gdal_config_ok, "try-error")) && gdal_config_ok == 0) {
    gdal_version <- readLines(gdal_config_res)
    cli_success(sprintf("Found GDAL version %s.", gdal_version))
  } else {
    gdal_info_res <- withr::local_tempfile()
    gdal_info_ok <- try(sys::exec_wait(
      "gdalinfo",
      "--version",
      std_out = gdal_info_res
    ), silent = TRUE)
    if ((!inherits(gdal_info_ok, "try-error")) && gdal_info_ok == 0) {
      gdal_version <- readLines(gdal_info_res)
      cli_success(sprintf("Found GDAL version %s.", gdal_version))
    } else {
      # Warning, not abording, as we could have missed GDAL
      rlang::warn(
        message = c(
          x = "Can't find GDAL via gdal-config nor gdalinfo.",
          i = "Are you sure you installed GDAL? See vignette('taudem-installation')."
        )
      )
    }
  }

  # MPI -----
  mpi_version_res <- withr::local_tempfile()
    mpi_version_ok <- if (on_windows()) {
    try(sys::exec_wait(
      "mpiexec",
      std_out = mpi_version_res
    ),
      silent = TRUE
    )
  } else {
    try(sys::exec_wait(
      "mpiexec",
      "--version",
      std_out = mpi_version_res
    ),
      silent = TRUE
    )
  }
  if ((!inherits(mpi_version_ok, "try-error")) && mpi_version_ok == 0) {
    mpi_version <- readLines(mpi_version_res)[1]
    cli_success(sprintf("Found %s (MPI).", mpi_version))
  } else {
    rlang::abort(
      message = c(
        x = "Can't find MPI",
        i = "Please install MPI. See vignette('taudem-installation')."
      )
    )
  }

  # TauDEM registered ---------
  if (!can_register_taudem()) {
    rlang::abort(
      message = c(
        x = "Can't find TauDEM on PATH nor `TAUDEM_PATH` environment variable",
        i = "Register your TauDEM installation. See vignette('taudem-installation')."
      )
    )
  } else {
    cli_success(sprintf("Found TauDEM path (%s).", cli::col_blue(taudem_path())))
  }

  # Folder with executables ------------
  if (!dir.exists(taudem_path())) {
    rlang::abort(
      message = c(
        x = sprintf("Can't find directory `%s` (TauDEM executables)", cli::col_blue(.taudem_path())),
        i = "Register your TauDEM installation. See vignette('taudem-installation')."
      )
    )
  } else {
    cli_success(sprintf("Found TauDEM executables directory (%s).", cli::col_blue(taudem_path())))
  }

  # Algorithms in executables folder -----
  if (is_taudem_envvar()) {
    missing_algos <- taudem_official_list()[!(tolower(taudem_official_list()) %in% taudem_algorithms())]
  } else {
    register_taudem()
    missing_algos <- taudem_official_list()[!purrr::map_lgl(taudem_official_list(), find_algo)]
  }

  if (length(missing_algos) > 0) {
    rlang::abort(
      message = c(
        x = sprintf("Can't find executables for %s", toString(sprintf("`%s`", missing_algos))),
        i = "Try re-installing TauDEM and write down any problem."
      )
    )
  } else {
    cli_success("Found all TauDEM executables.")
  }


  # Hello world -----
  # TODO: actually distribute test data with package
  # https://github.com/dtarb/TauDEM-Test-Data has no licence!
  # https://github.com/r-lib/testthat/blob/a8b6b16c82bcce6d960add9a3df9b17ef3ccd570/R/skip.R#L120
  cli::cli_alert_info("Testing TauDEM on an example file (please wait a bit)...")
  test_dir <- withr::local_tempdir()
  file.copy(
    system.file("test-data", "DEM.tif", package = "traudem"),
    file.path(test_dir, "DEM.tif")
  )
  cli::cli_rule(left = "TauDEM output")
  taudem_try <- withr::with_dir(
    test_dir, {
      taudem_exec(
          n_processes = NULL,
          program = "pitremove",
          args = "DEM.tif",
          quiet = FALSE
     )
    }
  )
  cli::cli_rule(left = "End of TauDEM output")
  if (!inherits(taudem_try, "try-error") && file.exists(file.path(test_dir, "DEMfel.tif"))) {
    cli::cli_alert_success("Was able to launch a TauDEM example!")
    cli::cli_alert_warning("Double-check above output for serious error messages.")
  } else {
    rlang::abort(
      message = c(
        x = "Couldn't launch a TauDEM example.",
        i = "Please open a bug report in the traudem repository."
      )
    )
  }
}
