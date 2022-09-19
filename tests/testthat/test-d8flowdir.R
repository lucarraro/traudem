test_that("taudem_d8flowdir() works", {
  test_dir <- withr::local_tempdir()
  file.copy(
    system.file("test-data", "MED_01_01.tif", package = "traudem"),
    file.path(test_dir, "MED_01_01.tif")
  )
  expect_snapshot({
    output <- taudem_pitremove(file.path(test_dir, "MED_01_01.tif"))
    outputs <- taudem_d8flowdir(output)
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
  expect_true(file.exists(outputs$output_d8flowdir_grid))
  expect_true(file.exists(outputs$output_d8slopes_grid))
})
