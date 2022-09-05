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
  taudem_path <- Sys.getenv("TAUDEM_PATH")
  if (!is_taudem_registered()) {
    Sys.setenv(PATH = paste0(sprintf("%s:", taudem_path), Sys.getenv("PATH")))
  }
}

is_taudem_on_path <- function() {
  nzchar(Sys.which("taudem"))
}

is_taudem_envvar <- function() {
  nzchar(Sys.getenv("TAUDEM_PATH"))
}

is_taudem_registered <- function() {
  is_taudem_on_path() || is_taudem_envvar()
}

taudem_path <- function() {
  if (is_taudem_on_path()) {
    return(Sys.which("taudem"))
  }
  if (is_taudem_envvar()) {
    return(Sys.getenv("TAUDEM_PATH"))
  }
  return(NA)
}
