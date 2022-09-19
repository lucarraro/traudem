# Windows CI
setup_os <- function() {
  is_ci <- nzchar(Sys.getenv("CI"))
  is_windows <- (tolower(Sys.info()[["sysname"]]) == "windows")
  if (is_ci && is_windows) {
    Sys.setenv(
      PATH = paste0(
        "C:\\Program Files\\Microsoft MPI\\bin;",
        "C:\\Program Files\\GDAL;",
        "C:\\taudem;",
        Sys.getenv("PATH")
      )
    )
  }
  if (is_ci && !is_windows) {
    Sys.setenv(TAUDEM_PATH="TauDEM/bin")
  }
}
setup_os()
