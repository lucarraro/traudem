#' D8 Flow Directions
#'
#' @details See <https://hydrology.usu.edu/taudem/taudem5/help53/D8FlowDirections.html>
#'
#' @param input_elevation_grid Pit filled elevation input data
#' @param output_d8flowdir_grid D8 flow directions output
#' @param output_d8slopes_grid D8 slopes output
#' @inheritParams taudem_aread8
#'
#' @return List with the two output filenames
#' @export
#'
#' @examples
#' \dontrun{
#' test_dir <- withr::local_tempdir()
#'  file.copy(
#'    system.file("test-data", "MED_01_01.tif", package = "traudem"),
#'    file.path(test_dir, "MED_01_01.tif")
#'  )
#' filled_pit <- taudem_pitremove(file.path(test_dir, "MED_01_01.tif"))
#' outputs <- taudem_d8flowdir(filled_pit)
#' outputs
#' }
taudem_d8flowdir <- function(input_elevation_grid,
                              output_d8flowdir_grid = NULL,
                              output_d8slopes_grid = NULL,
                              n_processes = getOption("traudem.n_processes", 1)) {
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
    "d8flowdir",
    "-fel", input_elevation_grid,
    "-p", output_d8flowdir_grid,
    "-sd8", output_d8slopes_grid
  )
  taudem_exec(n_processes = n_processes, args)
  return(invisible(list(
    output_d8flowdir_grid = output_d8flowdir_grid,
    output_d8slopes_grid = output_d8slopes_grid
  )))
}
