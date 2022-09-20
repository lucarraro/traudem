# Windows CI
setup_os <- function() {
  if (is_ci() && on_windows()) {
    Sys.setenv(
      PATH = paste0(
        "C:\\Program Files\\Microsoft MPI\\bin;",
        "C:\\Program Files\\GDAL;",
        "C:\\taudem;",
        Sys.getenv("PATH")
      )
    )
  }
  if (is_ci() && !on_windows()) {
    Sys.setenv(TAUDEM_PATH="TauDEM/bin")
  }
}
setup_os()
