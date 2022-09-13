#' Pit Remove
#'
#' @details See https://hydrology.usu.edu/taudem/taudem5/help53/PitRemove.html
#'
#' @param input_elevation_grid Input elevation grid file
#' @param output_elevation_grid Output elevation grid file
#' @param only_4way_neighbors Whether to consider only 4 way neighbors
#' @param n_processes Number of processes
#' @param depmask Depression mask file (optional)
#'
#' @return Path to output file (invisibly)
#' @export
#'
#' @examples
#' \dontrun{
#' download_dir <- withr::local_tempdir()
#' curl::curl_download(
#' "https://github.com/dtarb/TauDEM-Test-Data/blob/master/ReferenceResult/Base/MED_01_01.tif?raw=true",
#' file.path(download_dir, "MED_01_01.tif")
#' )
#' output <- taudem_pitremove(file.path(download_dir, "MED_01_01.tif"))
#' output
#' }
taudem_pitremove <- function(input_elevation_grid,
                             output_elevation_grid = NULL,
                             only_4way_neighbors = FALSE,
                             n_processes = getOption("traudem.n_processes", 1),
                             depmask = NULL) {
  if (!fs::file_exists(input_elevation_grid)) {
    rlang::abort(sprintf("Can't find file %s (input_elevation_grid)", input_elevation_grid))
  }
  if (is.null(output_elevation_grid)) {
    output_elevation_grid_file <- sprintf(
      "%sfel",
      fs::path_ext_remove(input_elevation_grid)
    )

    output_elevation_grid <- fs::path_ext_set(output_elevation_grid_file, "tif")
  }

  if (!is.null(depmask) && !fs::file_exists(depmask)) {
    rlang::abort(sprintf("Can't find file %s (depmask)", depmask))
  }

  args <- c(
    "mpiexec", "pitremove",
    "-z", input_elevation_grid,
    "-fel", output_elevation_grid
  )
  if (only_4way_neighbors) {
    args <- c(args, "-4way")
  }
  if (!is.null(depmask)) {
    args <- c(args, "-depmask", depmask)
  }
  exec_taudem(args)
  return(invisible(output_elevation_grid))
}
