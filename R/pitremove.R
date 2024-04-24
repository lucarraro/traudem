#' Pit Remove
#'
#' @details See <https://hydrology.usu.edu/taudem/taudem5/help53/PitRemove.html>
#'
#' @param input_elevation_grid Input elevation grid file.
#' @param output_elevation_grid Output elevation grid file.
#' @param only_4way_neighbors Whether to consider only 4 way neighbors.
#' @inheritParams taudem_exec
#' @param depmask Depression mask file (optional).
#'
#' @return Path to output file (invisibly).
#' @export
#'
#' @examplesIf interactive() && traudem::can_register_taudem()
#' test_dir <- withr::local_tempdir()
#' dir.create(test_dir)
#'  file.copy(
#'    system.file("test-data", "DEM.tif", package = "traudem"),
#'    file.path(test_dir, "DEM.tif")
#'  )
#' output <- taudem_pitremove(file.path(test_dir, "DEM.tif"))
#' output
taudem_pitremove <- function(input_elevation_grid,
                             output_elevation_grid = NULL,
                             only_4way_neighbors = FALSE,
                             n_processes = getOption("traudem.n_processes", 1),
                             depmask = NULL,
                             quiet = getOption("traudem.quiet", FALSE)) {
  if (!file.exists(input_elevation_grid)) {
    rlang::abort(sprintf("Can't find file %s (input_elevation_grid)", input_elevation_grid))
  }

  if (is.null(output_elevation_grid)) {
    output_elevation_grid_file <- sprintf(
      "%sfel",
      tools::file_path_sans_ext(input_elevation_grid)
    )
    output_elevation_grid <- sprintf("%s.tif", output_elevation_grid_file)
  }

  if (!is.null(depmask) && !file.exists(depmask)) {
    rlang::abort(sprintf("Can't find file %s (depmask)", depmask))
  }

  args <- c(
    "-z", input_elevation_grid,
    "-fel", output_elevation_grid
  )
  if (only_4way_neighbors) {
    args <- c(args, "-4way")
  }
  if (!is.null(depmask)) {
    args <- c(args, "-depmask", depmask)
  }

  taudem_exec(
    n_processes = n_processes,
    program = "pitremove", args = args,
    quiet = quiet
  )

  if (!file.exists(output_elevation_grid)) {
    rlang::abort("TauDEM error, see messages above.")
  }

  return(invisible(output_elevation_grid))
}
