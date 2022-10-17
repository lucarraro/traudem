#' D8 Contributing Area
#'
#' @details See <https://hydrology.usu.edu/taudem/taudem5/help53/D8ContributingArea.html>
#'
#' @param input_d8flowdir_grid Input flow directions grid.
#' @param output_contributing_area_grid Output contributing area grid.
#' @param check_edge_contamination Whether to check for edge contamination.
#' @param wg_file Input weight grid (optional).
#' @param outlet_file Input outlets file (OGR readable dataset, optional).
#' @param outlet_layer_name OGR layer name if outlets are not the first layer in `outlet_file` (optional).
#'   Layer name and layer number should not both be specified.
#' @param outlet_layer_number OGR layer number if outlets are not the first layer in `outlet_file` (optional).
#'   Layer name and layer number should not both be specified.
#' @inheritParams taudem_exec
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
#'
#' filled_pit <- taudem_pitremove(file.path(test_dir, "DEM.tif"))
#' outputs <- taudem_d8flowdir(filled_pit)
#' outputs
#' contributing_area_grid <- taudem_aread8(outputs$output_d8flowdir_grid)
#' contributing_area_grid
taudem_aread8 <- function(input_d8flowdir_grid,
                         output_contributing_area_grid = NULL,
                         check_edge_contamination = TRUE,
                         n_processes = getOption("traudem.n_processes", 1),
                         wg_file = NULL,
                         outlet_file = NULL,
                         outlet_layer_name = NULL,
                         outlet_layer_number = NULL,
                         quiet = getOption("traudem.quiet", FALSE)) {
  if (!file.exists(input_d8flowdir_grid)) {
    rlang::abort(sprintf("Can't find file %s (input_d8flowdir_grid)", input_d8flowdir_grid))
  }

  if (is.null(output_contributing_area_grid)) {
    output_contributing_area_grid_file <- sprintf(
      "%sctb",
      tools::file_path_sans_ext(input_d8flowdir_grid)
    )
    output_contributing_area_grid <- sprintf("%s.tif", output_contributing_area_grid_file)
  }

  if (!is.null(wg_file) && !file.exists(wg_file)) {
    rlang::abort(sprintf("Can't find file %s (wg_file)", wg_file))
  }

  if (!is.null(outlet_file) && !file.exists(outlet_file)) {
    rlang::abort(sprintf("Can't find file %s (outlet_file)", outlet_file))
  }

  if (!is.null(outlet_layer_name) && !is.null(outlet_layer_number)) {
    rlang::abort("outlet_layer_name and outlet_layer_number must not both be specified.")
  }

  args <- c(
    "-p", input_d8flowdir_grid,
    "-ad8", output_contributing_area_grid
  )

  if (!check_edge_contamination) {
    args <- c(args, "-nc")
  }

  if (!is.null(wg_file)) {
    args <- c(args, "-wg", wg_file)
  }

  if (!is.null(outlet_file)) {
    args <- c(args, "-o", outlet_file)
  }

  if (!is.null(outlet_layer_name)) {
    args <- c(args, "-lyrname", outlet_layer_name)
  }

  if (!is.null(outlet_layer_number)) {
    args <- c(args, "-lyrno", outlet_layer_number)
  }

  taudem_exec(n_processes = n_processes, program = "aread8", args = args, quiet = quiet)
  if (!file.exists(output_contributing_area_grid)) {
    rlang::abort("TauDEM error, see messages above.")
  }
  return(invisible(output_contributing_area_grid))
}
