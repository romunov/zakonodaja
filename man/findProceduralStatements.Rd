% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/findProceduralStatements.R
\name{findProceduralStatements}
\alias{findProceduralStatements}
\title{Find procedural statements}
\usage{
findProceduralStatements(train_proc, train_actual, full_data, html_file, ...)
}
\arguments{
\item{train_actual}{A text document where each row represents non-procedural statement from candidate(s)
Encoding of the file should be UTF-8.}

\item{full_data}{A dataset where each line represents data from candidate(s) to be classified as
procedural or non-procedural statement. Encoding should be UTF-8.}

\item{...}{Arguments passed to \link[RTextTools:train_model]{train_model}}

\item{train_data}{A text document where each row represents procedural statement from candidate(s). Encoding of
the file should be UTF-8.}
}
\value{
An HTML file with each statement colored according to which group the model predicted it. Green
color means non-procedural, red means procedural (and should possibly be removed).
}
\description{
Some statements may hold little value and should be removed. This function will find these statements. TODO: remove
the statements as well.
}
\details{
You currently need the custom create_matrix.R because version from GitHub messes things up in create_container.
}
\examples{
\dontrun{
library(tm)
out <- findProceduralStatements(train_proc = "./data/izjave_proc.txt",
                         train_actual = "./data/izjave_vsebina.txt",
                         full_data = "./data/izjava_HAINZ PRIMOZ.txt",
                         html_file = "rezultat.html")

}
}

