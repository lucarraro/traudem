exec_taudem <- function(...) {
  register_taudem()
  std_out <- withr::local_tempfile()
  std_err <- withr::local_tempfile()
  res <- try(
    sys::exec_wait(
      ...,
      std_out = std_out,
      std_err = std_err
    )
  )
  if (inherits(res, "try-error")) {
    print(res)
  } else {
    purrr::walk(readLines(std_out), cli::cat_line)
    purrr::walk(readLines(std_err), cli::cat_line, col = "red")
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
