test_that("multiplication works", {
  skip_on_cran()
  library("shapefiles")
  withr::local_options(traudem.quiet = TRUE)
  test_dir <- withr::local_tempdir()
  file.copy(
    system.file("test-data", "DEM.tif", package = "traudem"),
    file.path(test_dir, "DEM.tif")
  )
  withr::local_dir(test_dir)
  taudem_pitremove(
    input_elevation_grid = "DEM.tif",
    output_elevation_grid = "DEMfel.tif"
  )

  # D8 flow direction ####
  taudem_d8flowdir(
    input_elevation_grid = "DEMfel.tif",
    output_d8flowdir_grid = "DEMp.tif",
    output_d8slopes_grid = "DEMsd8.tif"
  )

  # D8 contributing area ####
  taudem_aread8(
    input_d8flowdir_grid = "DEMp.tif",
    output_contributing_area_grid = "DEMad8.tif"
  )
  tA <- 1000
  taudem_threshold(
    input_area_grid = "DEMad8.tif",
    output_stream_raster_grid = "DEMsrc.tif",
    threshold_parameter = sprintf("%.2f", tA)
  )
  # function to create point shapefile given coordinates ####
  shp.point <- function(x, y, sname = "shape"){
    n <- length(x)
    dd <- data.frame(Id=1:n,X=x,Y=y)
    ddTable <- data.frame(Id=c(1),Name=paste("Outlet",1:n,sep=""))
    ddShapefile <- shapefiles::convert.to.shapefile(dd, ddTable, "Id", 1)
    shapefiles::write.shapefile(ddShapefile, sname, arcgis=T)
  }
  x_outlet <- 20
  y_outlet <- 65
  shp.point(x = x_outlet, y = y_outlet,"ApproxOutlet")
  taudem_moveoutletstostream(
    input_d8flowdir_grid = "DEMp.tif",
    input_stream_raster_grid = "DEMsrc.tif",
    outlet_file = "ApproxOutlet.shp",
    output_moved_outlets_file = "Outlet.shp"
  )
  OUT <- shapefiles::read.shp("Outlet.shp")
  expect_lt(sqrt((x_outlet-OUT$shp[1,"x"])^2+(y_outlet-OUT$shp[1,"y"])^2), 3)

  taudem_aread8(
    input_d8flowdir_grid = "DEMp.tif",
    outlet_file = "Outlet.shp",
    output_contributing_area_grid = "DEMssa.tif"
  )
  ssa <- terra::rast("DEMssa.tif")
  expect_equal(max(terra::values(ssa), na.rm = T), 7286)
})
