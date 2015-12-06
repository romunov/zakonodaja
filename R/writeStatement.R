#' Write statement of candidate to a file.
#'
#' For a given candidate, the function will read all the statements and output them to a file, one statement per line.
#'
#' @param x Character. Name of the candidate in form "SURNAME NAME". To see the list of candidates, see
#' \link[zakonodaja:listAllCandidates]{listAllCandidates}
#'
#' @return Function side-effects are a file written to disk, returns statements as a list.
#'
#' @author Roman Lustrik (roman.lustrik@@biolitika.si)
#'
#' @export
writeStatement <- function(x) {
    posl <- fromJSON(readLines(sprintf("http://zakonodajni-monitor.si/api/izjave/avtor/en/%s/true", x)))

    posl.text <- sapply(posl[[1]], FUN = "[[", "text")
    sapply(posl.text, write, sep = "\n", file = file(sprintf("izjava_%s.txt", x), encoding = "UTF-8", open = "w"), append = TRUE)
    posl
}
