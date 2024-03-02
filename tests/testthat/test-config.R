#
# Copyright (C) 2023 EuroSAT Package.
#
# EuroSAT Package is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.
#

test_that("(Internal) Get EuroSat Data Directory (default variables)", {
  expect_equal(.get_eurosat_data_dir(),
               fs::path("~/.local/share/eurosat"))
})

test_that("(Internal) Get EuroSat Data Directory (custom variables)", {
  Sys.setenv("EUROSAT_DATA_DIR" = "/custom/dir")

  expect_equal(.get_eurosat_data_dir(), fs::path("/custom/dir"))
})
