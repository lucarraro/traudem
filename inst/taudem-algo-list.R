destfile <- withr::local_tempfile()
files <- "https://raw.githubusercontent.com/dtarb/TauDEM/Develop/src/CMakeLists.txt" |>
  curl::curl_download(destfile = destfile) |>
  brio::read_lines() |>
  stringr::str_extract_all("[a-zA-Z0-9]*mn.cpp") |>
  purrr::compact() |>
  unlist() |>
  stringr::str_replace_all("mn.cpp", "")
files <- files[files != ""]
files[files == "flowdircondition"] <- "FlowdirCond"
dput(sort(files))
