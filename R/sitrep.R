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
  # Environment variable ---------
  if (!nzchar(taudem_path)) {
    rlang::abort(
      message = c(
        x = "Can't find `TAUDEM_PATH` environment variable",
        i = "Add `TAUDEM_PATH` environment variable pointing to TauDEM executables. See `?taudem_sitrep`"
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
        i = "Fix `TAUDEM_PATH` environment variable pointing to TauDEM executables. See `?taudem_sitrep`"
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


  # TODO run hello world -----
}
