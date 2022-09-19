test_that("info", {
  if (tolower(Sys.info()[["sysname"]]) != "windows") {
    register_taudem()
  }
  expect_true(nzchar(Sys.which("pitremove")))
})

test_that("taudem_sitrep() works - problems", {
  withr::local_envvar(TAUDEM_QUIET = "quiet")

  withr::local_envvar(TAUDEM_PATH = "")
  expect_snapshot_error(taudem_sitrep())

  withr::local_envvar(TAUDEM_PATH = "blop")
  expect_snapshot_error(taudem_sitrep())

  withr::local_envvar(TAUDEM_PATH = "..")
  expect_snapshot_error(taudem_sitrep())
})

test_that("taudem_sitrep() works - all well", {
  skip_on_cran()
  expect_snapshot(
    taudem_sitrep(),
    transform = function(x) {
      x <- gsub("[0-9]", "", x)
      x <- gsub("Found TauDEM path \\(.*\\).", "Found TauDEM path", x)
      x <- gsub("Found .* \\(MPI\\).", "Found MPI (MPI).", x)
      x <- gsub("Found TauDEM executables directory \\(.*\\).", "Found TauDEM executables directory.", x)
      x
    }
  )

})

