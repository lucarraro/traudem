#' D8 Flow Directions
#'
#' @details See <https://hydrology.usu.edu/taudem/taudem5/help53/D8FlowDirections.html>
#'
#' @param input_elevation_grid Pit filled elevation input data.
#' @param output_d8flowdir_grid D8 flow directions output.
#' @param output_d8slopes_grid D8 slopes output.
#' @inheritParams taudem_exec
#'
#' @return List with the two output filenames.
#' @export
#'
#' @examplesIf interactive() && traudem::can_register_taudem()
#' test_dir <- withr::local_tempdir()
#' dir.create(test_dir)
#'  file.copy(
#'    system.file("test-data", "DEM.tif", package = "traudem"),
#'    file.path(test_dir, "DEM.tif")
#'  )
#' filled_pit <- taudem_pitremove(file.path(test_dir, "DEM.tif"))
#' outputs <- taudem_d8flowdir(filled_pit)
#' outputs
taudem_d8flowdir <- function(input_elevation_grid,
                              output_d8flowdir_grid = NULL,
                              output_d8slopes_grid = NULL,
                              n_processes = getOption("traudem.n_processes", 1),
                              quiet = getOption("traudem.quiet", FALSE)) {
  if (!file.exists(input_elevation_grid)) {
    rlang::abort(sprintf("Can't find file %s (input_elevation_grid)", input_elevation_grid))
  }

  if (is.null(output_d8flowdir_grid)) {
    output_d8flowdir_grid_file <- sprintf(
      "%sd8flowdir",
      tools::file_path_sans_ext(input_elevation_grid)
    )
    output_d8flowdir_grid <- sprintf("%s.tif", output_d8flowdir_grid_file)
  }

  if (is.null(output_d8slopes_grid)) {
    output_d8slopes_grid_file <- sprintf(
      "%sd8slopes",
      tools::file_path_sans_ext(input_elevation_grid)
    )
    output_d8slopes_grid <- sprintf("%s.tif", output_d8slopes_grid_file)
  }

  args <- c(
    "-fel", input_elevation_grid,
    "-p", output_d8flowdir_grid,
    "-sd8", output_d8slopes_grid
  )
  taudem_exec(n_processes = n_processes, program = "d8flowdir", args = args, quiet = quiet)

  output1_exists <- file.exists(output_d8flowdir_grid)
  output2_exists <- file.exists(output_d8slopes_grid)
  if (!all(c(output1_exists, output2_exists))) {
    rlang::abort("TauDEM error, see messages above.")
  }

  return(invisible(list(
    output_d8flowdir_grid = output_d8flowdir_grid,
    output_d8slopes_grid = output_d8slopes_grid
  )))
}
