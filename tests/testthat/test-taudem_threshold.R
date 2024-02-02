test_that("taudem_aread8() works", {
  skip_on_cran()
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

  src <- terra::rast("DEMsrc.tif")

  expect_equal(sum(terra::values(src) == 1, na.rm = T), 160)

})
