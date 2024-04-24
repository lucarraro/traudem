#' Call TauDEM
#'
#' @details You can use this function to call more TauDEM methods
#' than the ones with dedicated wrappers in this package.
#' Please refer to the relative TauDEM function documentation for the syntax used to specify optional arguments.
#' See also examples.
#'
#' @param ... These dots are for future extensions and must be empty.
#' As a consequence, all following arguments must be fully named (see examples).
#' @param n_processes Number of processes for `mpiexec`. If `NULL` TauDEM is called without mpiexec.
#' @param program TauDEM command (character). See examples.
#' @param args Character vector of arguments. See examples.
#' @param quiet If `FALSE` output from TauDEM CLI is suppressed.
#'
#' @return `TRUE` if the call was successful, `FALSE` otherwise.
#' @export
#'
#' @examplesIf interactive() && traudem::can_register_taudem()
#' test_dir <- withr::local_tempdir()
#' dir.create(test_dir)
#' file.copy(
#'    system.file("test-data", "DEM.tif", package = "traudem"),
#'    file.path(test_dir, "DEM.tif")
#'  )
#'  # Default name for output file, only input command and input filename.
#' taudem_exec("pitremove", file.path(test_dir, "DEM.tif"))
#'
#' # syntax for user-attributed output file name
#' taudem_exec(
#'   "pitremove",
#'   c(
#'     "-z", file.path(test_dir, "DEM.tif"),
#'     "-fel", file.path(test_dir,"filled_pits.tif")
#'   )
#' )
taudem_exec <- function(program, args, ..., n_processes = getOption("traudem.n_processes", 1), quiet = getOption("traudem.quiet", FALSE)) {
  rlang::check_dots_empty()
  if (!can_register_taudem()) {
    rlang::abort(
      message = c(
        x = "Can't find TauDEM",
        i = "Refer to ?traudem::taudem_sitrep"
      )
    )
  }
  register_taudem()

  if (grepl("[^ -~]", getwd())){
    rlang::abort("The working directory contain(s) non-ASCII characters,
                 which are not supported by MPI.")
  }

  if (!is.null(n_processes)) {
    cmd <- "mpiexec"
    args <- c("-n", n_processes, program, args)
  } else {
    cmd <- program
  }

  std_out <- withr::local_tempfile()
  std_err <- withr::local_tempfile()
  res <- try(
    sys::exec_wait(
      cmd = cmd,
      args = args,
      std_out = std_out,
      std_err = std_err
    )
  )
  if (inherits(res, "try-error")) {
    print(res)
    return(FALSE)
  } else {
    if (!quiet) {
      purrr::walk(readLines(std_out), cli::cat_line)
      purrr::walk(readLines(std_err), cli::cat_line, col = "red")
    }
    return(TRUE)
  }
}

register_taudem <- function() {
  if (!is_taudem_registered()) {
    sep <- if (on_windows()) {
      ";"
    } else {
      ":"
    }
    Sys.setenv(PATH = paste0(sprintf("%s%s", taudem_path(), sep), Sys.getenv("PATH")))
  }
}

is_taudem_on_path <- function() {
  nzchar(Sys.which("pitremove"))
}

is_taudem_envvar <- function() {
  nzchar(Sys.getenv("TAUDEM_PATH"))
}


#' @rdname taudem_sitrep
#'
#' @return For `can_register_taudem()`: A logical scalar.
#' @export
#'
#' @examples
#' can_register_taudem()
can_register_taudem <- function() {
  is_taudem_on_path() || is_taudem_envvar()
}

is_taudem_registered <- function() {
  if (is_taudem_on_path()) {
    return(TRUE)
  }
  if (!is.na(taudem_path())) {
    return(grepl(taudem_path(), Sys.getenv("PATH")))
  }
  return(FALSE)
}

.taudem_path <- function() {
  if (is_taudem_envvar()) {
    return(Sys.getenv("TAUDEM_PATH"))
  }
  if (is_taudem_on_path()) {
    return(dirname(Sys.which("pitremove")))
  }
  return(NA)
}

taudem_path <- function() {
  if (is.na(.taudem_path())) {
    return(NA)
  }
  if (!dir.exists(.taudem_path())) {
    return(path.expand(file.path("~", .taudem_path())))
  }
  .taudem_path()
}
