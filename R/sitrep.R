#' TauDEM situation report
#'
#' Checks installation of TauDEM and provides useful hints.
#'
#' @return None
#' @export
#'
#' @section TauDEM installation and registration:
#'
#' Once you have installed TauDEM add an environment variable
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
#' Sys.setenv(TAUDEM_PATH='/usr/local/taudem')
#' ```
#'
#' @examples
#' \dontrun{
#' taudem_sitrep()
#' }
taudem_sitrep <- function() {
  taudem_path <- Sys.getenv("TAUDEM_PATH")

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
  mpi_version_ok <- try(sys::exec_wait(
    "mpiexec",
    "--version",
    std_out = mpi_version_res
  ),
    silent = TRUE
  )
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

  # Environment variable ---------
  if (!nzchar(taudem_path)) {
    rlang::abort(
      message = c(
        x = "Can't find `TAUDEM_PATH` environment variable",
        i = "Add `TAUDEM_PATH` environment variable pointing to TauDEM executables. See vignette('taudem-installation')."
      )
    )
  } else {
    cli_success(sprintf("Found `TAUDEM_PATH` environment variable (%s).", taudem_path))
  }

  # Folder with executables ------------
  if (!fs::dir_exists(taudem_path)) {
    rlang::abort(
      message = c(
        x = sprintf("Can't find directory `%s` (TauDEM executables)", taudem_path),
        i = "Fix `TAUDEM_PATH` environment variable pointing to TauDEM executables. See vignette('taudem-installation')."
      )
    )
  } else {
    cli_success(sprintf("Found TauDEM executables directory (%s).", taudem_path))
  }

  # Algorithms in executables folder -----
  missing_algos <- taudem_official_list()[!(tolower(taudem_official_list()) %in% taudem_algorithms())]
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
  has_internet <- !is.null(curl::nslookup(host = "r-project.org", error = FALSE))
  if (!has_internet) {
    return()
  }
  cli::cli_alert_info("Testing TauDEM on an example file...")
  download_dir <- withr::local_tempdir()
  curl::curl_download(
    "https://github.com/dtarb/TauDEM-Test-Data/blob/master/ReferenceResult/Base/MED_01_01.tif?raw=true",
    file.path(download_dir, "MED_01_01.tif")
  )
  cli::cli_rule(left = "TauDEM output")
  taudem_try <- withr::with_dir(
    download_dir, {
      exec_taudem(
          "mpiexec",
          c("pitremove", "MED_01_01.tif")
     )
    }
  )
  cli::cli_rule(left = "End of TauDEM output")
  if (!inherits(taudem_try, "try-error")) {
    cli::cli_alert_success("Was able to launch a TauDEM example!")
    cli::cli_alert_warning("Make sure you see no serious error message above.")
  }
}