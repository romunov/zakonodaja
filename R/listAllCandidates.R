#' List all available candidates
#'
#' Function will return names of candidate.s
#'
#' @param x NULL by default, but can be a (path to a) file, in which case the result is written to
#' that file.
#' @param ... Arguments passed to \link[base:writeLines]{writeLines}.
#'
#' @author Roman Lustrik {roman.lustrik@@biolitika.si}
#'
#' @export
#'

listAllCandidates <- function(x = NULL, ...) {
    fsi <- fromJSON(readLines("http://www.zakonodajni-monitor.si/api/poslanci/vsi"))

    out <- sapply(fsi, function(x) x$properties$name)
    if (!is.null(x)) writeLines(out, file = x, ...)
    out
}
