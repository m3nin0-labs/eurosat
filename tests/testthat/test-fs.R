#
# Copyright (C) 2023 EuroSAT Package.
#
# EuroSAT Package is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.
#

test_that("(Internal) Create directory", {
  tmpdir <- fs::path(tempdir())
  tmpdir_test <- tmpdir / "test"

  .fs_create_dir(tmpdir_test)

  expect_true(fs::dir_exists(tmpdir_test))
})

test_that("(Internal) Check if a directory exists", {
  tmpdir <- tempdir()

  fs::dir_create(tmpdir)

  expect_true(.fs_check_dir(tmpdir))
})

test_that("(Internal) Check if a file exists", {
  tmpfile <- tempfile()

  fs::file_create(tmpfile)

  expect_true(.fs_check_file(tmpfile))
})
