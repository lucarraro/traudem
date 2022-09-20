taudem_transform <- function(x) {
  x <- gsub("Nodata.*", "", x)
  x <- gsub("[0-9]", "", x)
  x <- gsub(
    "Input file .* has projected coordinate system.",
    "Input file blop.tif has projected coordinate system.",
    x
  )
  x <- gsub( "MoveOutletsToStreams","MoveOutletsToStrm", x)
  x <- gsub("Found TauDEM path \\(.*\\).", "Found TauDEM path", x)
  x <- gsub("Found .* \\(MPI\\).", "Found MPI (MPI).", x)
  x <- gsub("Found GDAL.*", "Found GDAL", x)
  x <- gsub("Found TauDEM executables directory \\(.*\\).", "Found TauDEM executables directory.", x)
  x[nzchar(x)]
}
