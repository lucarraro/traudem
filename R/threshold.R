#' Stream Definition By Threshold
#'
#' @details See <https://hydrology.usu.edu/taudem/taudem5/help53/StreamDefinitionByThreshold.html>
#'
#' @param input_area_grid File name for grid to be thresholded.
#' @param output_stream_raster_grid File name for stream raster grid.
#' @param mask_file File name for grid used to mask the output stream raster, or general thresholded grid.
#' @param threshold_parameter Threshold parameter.
#' @inheritParams taudem_exec
#'
#' @return Path to output file (invisibly).
#' @export
#'
#' @examplesIf interactive() && traudem::can_register_taudem()
#' test_dir <- withr::local_tempdir()
#' dir.create(test_dir)
#' file.copy(
#'    system.file("test-data", "DEM.tif", package = "traudem"),
#'    file.path(test_dir, "DEM.tif")
#'  )
#' filled_pit <- taudem_pitremove(file.path(test_dir, "DEM.tif"))
#' outputs <- taudem_d8flowdir(filled_pit)
#' outputs
#' contributing_area_grid <- taudem_aread8(outputs$output_d8flowdir_grid)
#' contributing_area_grid
#' thresholded <- taudem_threshold(contributing_area_grid)
#' thresholded
taudem_threshold <- function(input_area_grid,
                            output_stream_raster_grid = NULL,
                            mask_file = NULL,
                            threshold_parameter = 100.0,
                            n_processes = getOption("traudem.n_processes", 1),
                            quiet = getOption("traudem.quiet", FALSE)) {

  if (!file.exists(input_area_grid)) {
    rlang::abort(sprintf("Can't find file %s (input_area_grid)", input_area_grid))
  }

  if (is.null(output_stream_raster_grid)) {
    output_stream_raster_grid_file <- sprintf(
      "%sthresholded",
      tools::file_path_sans_ext(input_area_grid)
    )
    output_stream_raster_grid <- sprintf("%s.tif", output_stream_raster_grid_file)
  }

  if (!is.null(mask_file) && !file.exists(mask_file)) {
    rlang::abort(sprintf("Can't find file %s (mask_file)", mask_file))
  }

  args <- c(
    "-ssa", input_area_grid,
    "-src", output_stream_raster_grid,
    "-thresh", threshold_parameter
  )

  if (!is.null(mask_file)) {
    args <- c(args, "-mask", mask_file)
  }

  taudem_exec(
    n_processes = n_processes,
    program = "threshold", args = args,
    quiet = quiet
  )

  if (!file.exists(output_stream_raster_grid)) {
    rlang::abort("TauDEM error, see messages above.")
  }

  return(invisible(output_stream_raster_grid))
}
