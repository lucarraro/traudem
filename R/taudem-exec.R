exec_taudem <- function(...) {
  register_taudem()
  res <- try(
    sys::exec_wait(
      ...
    )
  )
  if (inherits(res, "try-error")) {
    print(res)
  }
}

register_taudem <- function() {
  PATH <- Sys.getenv("PATH")
  taudem_path <- Sys.getenv("TAUDEM_PATH")
  if (!grepl(taudem_path, PATH)) {
    Sys.setenv(PATH = paste0(sprintf("%s:", taudem_path), Sys.getenv("PATH")))
  }
}
