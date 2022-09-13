cli_success <- function(...) {
  if (!nzchar(Sys.getenv("TAUDEM_QUIET"))) {
    cli::cli_alert_success(...)
  }
}
