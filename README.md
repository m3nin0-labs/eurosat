
<!-- README.md is generated from README.Rmd. Please edit that file -->

# eurosat 🛰️

The EuroSAT dataset is a comprehensive collection aimed at supporting
the development and evaluation of machine learning models in land use
and land cover classification tasks. Published in 2019 in the IEEE
Journal of Selected Topics in Applied Earth Observations and Remote
Sensing, it has become a crucial benchmark for researchers and
practitioners in the field.

This R package simplifies the process of downloading and utilizing the
EuroSAT dataset, offering an easy-to-use interface that allows users to
focus on their analysis rather than data management tasks.

## Installation

You can install the development version of `eurosat` like so:

``` r
# install.packages("devtools")
devtools::install_github("M3nin0/eurosat")
```

## Using eurosat

To download the EuroSAT dataset and create a local index, simply use:

``` r
library(eurosat)

# Download the EuroSAT dataset and create an index
eurosat::eurosat_download()
```

## Accessing the Data

After downloading, you can easily access the dataset through the
provided index, which includes paths to the data files and their
corresponding land use and land cover classes:

``` r
# Load the index into a data.table
index <- eurosat::eurosat_index()

# View the first few rows of the index
head(index)
#>    file      class
#>   <char>     <char>
#> 1: path/to/AnnualCrop_1.tif AnnualCrop
#> 2: path/to/AnnualCrop_10.tif AnnualCrop
#> 3: path/to/AnnualCrop_100.tif AnnualCrop
#> 4: path/to/AnnualCrop_1000.tif AnnualCrop
#> 5: path/to/AnnualCrop_1001.tif AnnualCrop
```

## Extra configurations

Sometimes you might need to disable SSL validation to download the
EuroSAT dataset. This can be done by setting the appropriate download
file method and options:

``` r
options(download.file.method="curl", download.file.extra="-k -L")
```

## References

\[1\] Eurosat: A novel dataset and deep learning benchmark for land use
and land cover classification. Patrick Helber, Benjamin Bischke, Andreas
Dengel, Damian Borth. IEEE Journal of Selected Topics in Applied Earth
Observations and Remote Sensing, 2019.
