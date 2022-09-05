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
  if (!nzchar(Sys.getenv("TAUDEM_PATH"))) {
    rlang::abort(
      message = c(
        x = "Can't find `TAUDEM_PATH` environment variable",
        i = "Add `TAUDEM_PATH` environment variable pointing to TauDEM executables. See `?taudem_sitrep`"
      )
    )
  }

  if (!fs::dir_exists(Sys.getenv("TAUDEM_PATH"))) {
    rlang::abort(
      message = c(
        x = sprintf("Can't find directory `%s` (TauDEM executables)", Sys.getenv("TAUDEM_PATH")),
        i = "Fix `TAUDEM_PATH` environment variable pointing to TauDEM executables. See `?taudem_sitrep`"
      )
    )
  }

  # TODO list algorithms

  # TODO run hello world
}
