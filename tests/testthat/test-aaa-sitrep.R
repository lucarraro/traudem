test_that("info", {
  if (!on_windows()) {
    register_taudem()
  }
  expect_true(nzchar(Sys.which("pitremove")))
})

test_that("taudem_sitrep() works - problems", {
  withr::local_envvar(TAUDEM_QUIET = "quiet")

  withr::local_envvar(TAUDEM_PATH = "blop")
  expect_snapshot_error(taudem_sitrep())

  withr::local_envvar(TAUDEM_PATH = "..")
  expect_snapshot_error(taudem_sitrep())
})

test_that("taudem_sitrep() works - all well", {
  skip_on_cran()
  expect_snapshot(
    taudem_sitrep(),
    transform = taudem_transform
  )

})

