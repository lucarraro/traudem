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

release_bullets <- function() {
  c("Update vignette cf https://ropensci.org/blog/2019/12/08/precompute-vignettes/")
}
