#' Move Outlets To Streams
#'
#' @details See <https://hydrology.usu.edu/taudem/taudem5/help53/MoveOutletsToStreams.html>
#'
#' @param input_d8flowdir_grid File name for D8 flow direction grid (input).
#' @param input_stream_raster_grid File name for stream raster grid (input).
#' @param output_moved_outlets_file Output OGR file where outlets have been moved.
#' @param om_layer_name layer name in movedoutletsfile (optional).
#' @param max_dist maximum number of grid cells to traverse in moving outlet points (optional).
#' @param outlet_file input outlets file (OGR readable dataset).
#' @param outlet_layer_name OGR layer name if outlets are not the first layer in `outlet_file` (optional).
#' Layer name and layer number should not both be specified.
#' @param outlet_layer_number OGR layer number if outlets are not the first layer in `outlet_file` (optional).
#' Layer name and layer number should not both be specified.
#' @inheritParams taudem_exec
#'
#' @return Path to output file (invisibly).
#' @export
#'
taudem_moveoutletstostream <- function(input_d8flowdir_grid,
                            input_stream_raster_grid,
                            output_moved_outlets_file = NULL,
                            om_layer_name = NULL,
                            max_dist = NULL,
                            outlet_file,
                            outlet_layer_name = NULL,
                            outlet_layer_number = NULL,
                            n_processes = getOption("traudem.n_processes", 1),
                            quiet = getOption("traudem.quiet", FALSE)) {

  if (!file.exists(input_d8flowdir_grid)) {
    rlang::abort(sprintf("Can't find file %s (input_d8flowdir_grid)", input_d8flowdir_grid))
  }

  if (!file.exists(input_stream_raster_grid)) {
    rlang::abort(sprintf("Can't find file %s (input_stream_raster_grid)", input_stream_raster_grid))
  }

  if (!file.exists(outlet_file)) {
    rlang::abort(sprintf("Can't find file %s (outlet_file)", outlet_file))
  }

  if (!is.null(outlet_layer_name) && !is.null(outlet_layer_number)) {
    rlang::abort("outlet_layer_name and outlet_layer_number must not both be specified.")
  }

  if (is.null(output_moved_outlets_file)) {
    output_moved_outlets_file_file <- sprintf(
      "%sthresholded",
      tools::file_path_sans_ext(input_d8flowdir_grid)
    )
    output_moved_outlets_file <- sprintf("%smovedoutlet.shp", output_moved_outlets_file_file)
  }

  program <- if (on_windows()) {
    "moveoutletstostreams"
  } else {
    "moveoutletstostrm"
  }

  args <- c(
    "-p", input_d8flowdir_grid,
    "-src", input_stream_raster_grid,
    "-o", outlet_file,
    "-om", output_moved_outlets_file
  )

  if (!is.null(om_layer_name)) {
    args <- c(args, "-omlyr", om_layer_name)
  }

  if (!is.null(max_dist)) {
    args <- c(args, "-md", max_dist)
  }

  if (!is.null(outlet_layer_name)) {
    args <- c(args, "-lyrname", outlet_layer_name)
  }

  if (!is.null(outlet_layer_number)) {
    args <- c(args, "-lyrno", outlet_layer_number)
  }
  taudem_exec(
    n_processes = n_processes,
    program = program, args = args,
    quiet = quiet
  )

  if (!file.exists(output_moved_outlets_file)) {
    rlang::abort("TauDEM error, see messages above.")
  }

  return(invisible(output_moved_outlets_file))
}
