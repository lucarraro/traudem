test_that("taudem_aread8() works", {
  test_dir <- withr::local_tempdir()
  file.copy(
    system.file("test-data", "MED_01_01.tif", package = "traudem"),
    file.path(test_dir, "MED_01_01.tif")
  )
  expect_snapshot({
    output <- taudem_pitremove(file.path(test_dir, "MED_01_01.tif"))
    outputs <- taudem_d8flowdir(output)
    contributing_area_grid <- taudem_aread8(outputs$output_d8flowdir_grid)
    contributing_area_grid2 <- taudem_aread8(outputs$output_d8flowdir_grid, check_edge_contamination = FALSE)
  },
    transform = function(x) {
      x <- gsub("[0-9]", "", x)
      x <- gsub(
        "Input file .* has projected coordinate system.",
        "Input file blop.tif has projected coordinate system.",
        x
      )
      x
    })
  expect_true(file.exists(contributing_area_grid))
  expect_true(file.exists(contributing_area_grid2))
})
