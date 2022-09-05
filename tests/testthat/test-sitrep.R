test_that("taudem_sitrem() works - problems", {
  withr::local_envvar(TAUDEM_QUIET = "quiet")

  withr::local_envvar(TAUDEM_PATH = "")
  expect_snapshot_error(taudem_sitrep())

  withr::local_envvar(TAUDEM_PATH = "blop")
  expect_snapshot_error(taudem_sitrep())

  withr::local_envvar(TAUDEM_PATH = "..")
  expect_snapshot_error(taudem_sitrep())
})

test_that("taudem_sitrem() works - all well", {
  # TODO: do not skip on CI once workflow present
  skip_on_ci()
  skip_on_cran()

  withr::local_envvar(TAUDEM_PATH = "/usr/local/taudem")
  expect_snapshot(taudem_sitrep())

})

