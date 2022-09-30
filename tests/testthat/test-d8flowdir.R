test_that("taudem_d8flowdir() works", {
  skip_on_cran()
  test_dir <- withr::local_tempdir()
  file.copy(
    system.file("test-data", "DEM.tif", package = "traudem"),
    file.path(test_dir, "DEM.tif")
  )
  expect_snapshot({
    output <- taudem_pitremove(file.path(test_dir, "DEM.tif"))
    outputs <- taudem_d8flowdir(output)
    },
    transform = taudem_transform)
  expect_true(file.exists(outputs$output_d8flowdir_grid))
  expect_true(file.exists(outputs$output_d8slopes_grid))
  p <- terra::rast(outputs$output_d8flowdir_grid)
  sd8 <- terra::rast(outputs$output_d8slopes_grid)

  expect_equal(sum(terra::values(sd8) > 500, na.rm = T), 13)

})
