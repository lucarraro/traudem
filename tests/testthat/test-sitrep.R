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
  skip_on_cran()

  withr::local_envvar(TAUDEM_PATH = "/usr/local/taudem")
  expect_snapshot(
    taudem_sitrep(),
    transform = function(x) gsub("[0-9]", "", x)
  )

})

