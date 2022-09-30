test_that("taudem_aread8() works", {
  skip_on_cran()
  test_dir <- withr::local_tempdir()
  file.copy(
    system.file("test-data", "DEM.tif", package = "traudem"),
    file.path(test_dir, "DEM.tif")
  )
  expect_snapshot({
    output <- taudem_pitremove(file.path(test_dir, "DEM.tif"))
    outputs <- taudem_d8flowdir(output)
    contributing_area_grid <- taudem_aread8(outputs$output_d8flowdir_grid)
    thresholded <- taudem_threshold(contributing_area_grid)
  },
    transform = taudem_transform)
  expect_true(file.exists(thresholded))
})
