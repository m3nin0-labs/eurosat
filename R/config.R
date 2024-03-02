#
# Copyright (C) 2023 EuroSAT Package.
#
# EuroSAT Package is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.
#

#' Get EuroSAT data directory.
#' @noRd
#'
#' @author Felipe Carlos, \email{efelipecarlos@gmail.com}
#'
#' @return Path to the EuroSAT data directory.
#'
.get_eurosat_data_dir <- function() {
  fs::path(Sys.getenv("EUROSAT_DATA_DIR", "~/.local/share/eurosat"))
}

#' Get EuroSAT data url
#' @noRd
#'
#' @author Felipe Carlos, \email{efelipecarlos@gmail.com}
#'
#' @return URL to EuroSAT (MS) file.
#'
.get_eurosat_data_url <- function() {
  Sys.getenv("EUROSAT_DATA_URL",
             "https://madm.dfki.de/files/sentinel/EuroSATallBands.zip")
}

#' Get EuroSAT data filename.
#' @noRd
#'
#' @author Felipe Carlos, \email{efelipecarlos@gmail.com}
#'
#' @return EuroSAT (MS) filename.
#'
.get_eurosat_data_file <- function() {
  fs::path_file(.get_eurosat_data_url())
}

#' Get EuroSAT files index path.
#' @noRd
#'
#' @author Felipe Carlos, \email{efelipecarlos@gmail.com}
#'
#' @return Path to EuroSAT files index file (csv format).
#'
.get_eurosat_index_file <- function() {
  .get_eurosat_data_dir() / "index.csv"
}
