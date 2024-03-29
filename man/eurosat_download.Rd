% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/eurosat.R
\name{eurosat_download}
\alias{eurosat_download}
\title{Download EuroSAT MS data.}
\usage{
eurosat_download()
}
\value{
\link[data.table:data.table]{data.table::data.table} containing the index of EuroSAT files.
}
\description{
This function downloads, extract and index all
EuroSAT Dataset (MS). After use it, check the function
\link{eurosat_index} to get the complete file index.

To change where the data is stored, please, the env variable
\code{EUROSAT_DATA_DIR} to specify it.

Also, do change the URL of the data downloaded, you can use
the \code{EUROSAT_DATA_URL} env variable. Of course, if you
change to a data with no EuroSAT MS structure, the code will
break.
}
\note{
You only need to call this function once. After this, the data
downloaded will be cached in your system. Then, you can access
the data using the function \link{eurosat_index}.

To download the file, maybe is required to ignore SSL validation. For
this case, you can use the following code:

\if{html}{\out{<div class="sourceCode r">}}\preformatted{base::options(download.file.method="curl", download.file.extra="-k -L")
}\if{html}{\out{</div>}}
}
\references{
Eurosat: A novel dataset and deep learning benchmark for land use and land
cover classification. Patrick Helber, Benjamin Bischke, Andreas Dengel, Damian
Borth. IEEE Journal of Selected Topics in Applied Earth Observations and
Remote Sensing, 2019.
}
\seealso{
\link{eurosat_index} to access the files index as \code{data.frame}.
}
\author{
Felipe Carlos, \email{efelipecarlos@gmail.com}
}
