# Windows CI
setup_windows <- function() {
  is_ci <- nzchar(Sys.getenv("CI"))
  is_windows <- (tolower(Sys.info()[["sysname"]]) == "windows")
  if (is_ci && is_windows) {
    Sys.setenv(
      PATH = paste0(
        "C:\\Program Files\\Microsoft MPI\\Bin:",
        "C:\\Program Files\\GDAL:",
        "C:\\taudem:",
        Sys.getenv("PATH")
      )
    )
  }
}
setup_windows()
