test_that("info", {
  skip_on_cran()
  if (!on_windows()) {
    register_taudem()
  }
  expect_true(nzchar(Sys.which("pitremove")))
})

test_that("taudem_sitrep() works - problems", {
  skip_on_cran()
  withr::local_envvar(TAUDEM_QUIET = "quiet")

  withr::local_envvar(TAUDEM_PATH = "blop")
  expect_snapshot_error(taudem_sitrep())
})

test_that("taudem_sitrep() works - missing algos", {
  skip_on_cran()
  skip_on_os("windows")
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

