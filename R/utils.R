cli_success <- function(...) {
  if (!nzchar(Sys.getenv("TAUDEM_QUIET"))) {
    cli::cli_alert_success(...)
  }
}

is_ci <- function() {
  nzchar(Sys.getenv("CI"))
}

on_windows <- function() {
  (tolower(Sys.info()[["sysname"]]) == "windows")
}
