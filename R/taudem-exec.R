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
  if (!is_taudem_registered()) {
    taudem_path <- Sys.getenv("TAUDEM_PATH")
    Sys.setenv(PATH = paste0(sprintf("%s:", taudem_path), Sys.getenv("PATH")))
  }
}

is_taudem_on_path <- function() {
  nzchar(Sys.which("taudem"))
}

is_taudem_envvar <- function() {
  nzchar(Sys.getenv("TAUDEM_PATH"))
}

can_register_taudem <- function() {
  is_taudem_on_path() || is_taudem_envvar()
}

is_taudem_registered <- function() {
  is_taudem_on_path() || grepl(taudem_path(), Sys.getenv("PATH"))
}

.taudem_path <- function() {
  if (is_taudem_envvar()) {
    return(Sys.getenv("TAUDEM_PATH"))
  }
  if (is_taudem_on_path()) {
    return(Sys.which("taudem"))
  }
  return(NA)
}

taudem_path <- function() {
  if (is.na(.taudem_path())) {
    return(NA)
  }
  if (!fs::dir_exists(.taudem_path())) {
    return(fs::path_home(.taudem_path()))
  }
  .taudem_path()
}
