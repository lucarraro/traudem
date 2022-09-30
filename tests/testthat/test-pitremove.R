test_that("taudem_pitremove() works", {
  skip_on_cran()
  test_dir <- withr::local_tempdir()
  file.copy(
    system.file("test-data", "DEM.tif", package = "traudem"),
    file.path(test_dir, "DEM.tif")
  )
  expect_snapshot(
    output <- taudem_pitremove(file.path(test_dir, "DEM.tif")),
    transform = taudem_transform)
  expect_true(file.exists(output))

  rast1 <- terra::rast(file.path(test_dir, "DEM.tif"))
  rast2 <- terra::rast(output)
  expect_lt(max(abs(terra::values(rast1)-terra::values(rast2))), 1e-3)

})

test_that("taudem_pitremove() works without mpiexec", {
  skip_on_cran()
  test_dir <- withr::local_tempdir()
  withr::local_options("traudem.n_processes" = NULL)
  file.copy(
    system.file("test-data", "DEM.tif", package = "traudem"),
    file.path(test_dir, "DEM.tif")
  )
  expect_snapshot(
    output <- taudem_pitremove(file.path(test_dir, "DEM.tif")),
    transform = taudem_transform)
  expect_true(file.exists(output))

})


test_that("taudem_pitremove() works quietly", {
  skip_on_cran()
  test_dir <- withr::local_tempdir()
  withr::local_options("traudem.quiet" = TRUE)
  file.copy(
    system.file("test-data", "DEM.tif", package = "traudem"),
    file.path(test_dir, "DEM.tif")
  )
  expect_snapshot(output <- taudem_pitremove(file.path(test_dir, "DEM.tif")))
  expect_true(file.exists(output))

})

