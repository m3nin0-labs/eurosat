#
# Copyright (C) 2023 EuroSAT Package.
#
# EuroSAT Package is free software; you can redistribute it and/or modify it
# under the terms of the MIT License; see LICENSE file for more details.
#

#' List files in a EuroSAT data zip.
#' @noRd
#'
#' @author Felipe Carlos, \email{efelipecarlos@gmail.com}
#'
#' @param zipfile Zipfile path.
#'
#' @return Array containing all files in the zipfile.
#'
.eurosat_zip_list <- function(zipfile) {
  utils::unzip(zipfile = zipfile, list = TRUE)
}

#' Extract files from EuroSAT data zip.
#' @noRd
#'
#' @author Felipe Carlos, \email{efelipecarlos@gmail.com}
#'
#' @param zipfile Zipfile path.
#' @param output_dir Directory where the extracted content will be saved.
#'
#' @return Array containing all files in the zipfile.
#'
.eurosat_zip_extract <- function(zipfile, output_dir) {
  base_extracted_dir <- output_dir / .eurosat_zip_list(zipfile)[1, 1]

  if (!.fs_check_dir(base_extracted_dir)) {
    utils::unzip(zipfile = zipfile, exdir = output_dir)
  }

  base_extracted_dir
}

#' Generate file index.
#' @noRd
#'
#' @author Felipe Carlos, \email{efelipecarlos@gmail.com}
#'
#' @description This functions iterates over all files available in EuroSAT
#'              folder and creates an index of it. It file is associated
#'              with a ``class`` which represents the type of content
#'              available in the image. The ``class`` is defined based on
#'              the folder where the file is. For example, files available
#'              in the folder `AnnualCrop` will be classified as ``AnnualCrop``.
#'
#' @param zipfile Zipfile path.
#' @param output_dir Directory where the extracted content will be saved.
#'
#' @return Array containing all files in the zipfile.
.eurosat_generate_index <- function(eurosat_base_data_dir) {
  # listing all classes available
  file_classes <-
    as.character(base::lapply(fs::dir_ls(eurosat_base_data_dir), function(x) {
      fs::path_file(x)
    }))

  file_index <- base::lapply(file_classes, function(row) {
    file_class_dir <- eurosat_base_data_dir / row

    file_class_data_files <- fs::dir_ls(file_class_dir)

    file_class_data_files <- as.data.frame(file_class_data_files)
    file_class_data_files["class"] <- row


    colnames(file_class_data_files) <- c("file", "class")
    rownames(file_class_data_files) <- 1:nrow(file_class_data_files)

    file_class_data_files
  })

  data.table::as.data.table(do.call(rbind, file_index))
}


#' Download EuroSAT MS data.
#'
#' @author Felipe Carlos, \email{efelipecarlos@gmail.com}
#'
#' @description
#' This function downloads, extract and index all
#' EuroSAT Dataset (MS). After use it, check the function
#' [eurosat::eurosat_index] to get the complete file index.
#'
#' To change where the data is stored, please, the env variable
#' ``EUROSAT_DATA_DIR`` to specify it.
#'
#' Also, do change the URL of the data downloaded, you can use
#' the ``EUROSAT_DATA_URL`` env variable. Of course, if you
#' change to a data with no EuroSAT MS structure, the code will
#' break.
#'
#' @references
#' Eurosat: A novel dataset and deep learning benchmark for land use and land
#' cover classification. Patrick Helber, Benjamin Bischke, Andreas Dengel, Damian
#' Borth. IEEE Journal of Selected Topics in Applied Earth Observations and
#' Remote Sensing, 2019.
#'
#' @note You only need to call this function once. After this, the data
#'       downloaded will be cached in your system. Then, you can access
#'       the data using the function [eurosat::eurosat_index].
#'
#' @note To download the file, maybe is required to ignore SSL validation. For
#' this case, you can use the following code:
#'
#' ```r
#' base::options(download.file.method="curl", download.file.extra="-k -L")
#' ````
#'
#' @seealso [eurosat::eurosat_index] to access the files index as ``data.frame``.
#'
#' @export
#'
#' @return [data.table::data.table] containing the index of EuroSAT files.
eurosat_download <- function() {
  # creating output directory
  eurosat_data_dir <- .fs_create_dir(.get_eurosat_data_dir())

  # downloading output file
  eurosat_output_file <-
    eurosat_data_dir / fs::path_file(.get_eurosat_data_url())

  if (!.fs_check_file(eurosat_output_file)) {
    eurosat_data_url <- .get_eurosat_data_url()

    utils::download.file(eurosat_data_url, eurosat_output_file)
  }

  # extracting files
  eurosat_tif_dir <-
    .eurosat_zip_extract(eurosat_output_file, eurosat_data_dir)

  # generating file index
  eurosat_data_index <- .eurosat_generate_index(eurosat_tif_dir)

  # saving data index
  eurosat_data_index_file <-  eurosat_data_dir / "index.csv"
  utils::write.csv2(eurosat_data_index, eurosat_data_index_file, row.names = FALSE)

  eurosat_data_index
}


#' Load EuroSAT MS data index.
#'
#' @author Felipe Carlos, \email{efelipecarlos@gmail.com}
#'
#' @description
#' This function loads the index of EuroSAT MS data files. To use
#' this function it is required to have all EuroSAT data downloaded.
#'
#' @references
#' Eurosat: A novel dataset and deep learning benchmark for land use and land
#' cover classification. Patrick Helber, Benjamin Bischke, Andreas Dengel, Damian
#' Borth. IEEE Journal of Selected Topics in Applied Earth Observations and
#' Remote Sensing, 2019.
#'
#' @note Make sure you have executed [eurosat::eurosat_download] before run this
#' function.
#'
#' @seealso [eurosat::eurosat_download] to download EuroSAT (MS) data.
#'
#' @export
#'
#' @return [data.table::data.table] containing the index of EuroSAT files.
eurosat_index <- function() {
  eurosat_data_dir <- .get_eurosat_data_dir() / "index.csv"

  data.table::as.data.table(utils::read.csv(eurosat_data_dir, sep = ';'))
}
