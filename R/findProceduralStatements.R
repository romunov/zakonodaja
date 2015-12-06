#' Find procedural statements
#'
#' Some statements may hold little value and should be removed. This function will find these statements. TODO: remove
#' the statements as well.
#'
#' You currently need the custom create_matrix.R because version from GitHub messes things up in create_container.
#'
#' @param train_data A text document where each row represents procedural statement from candidate(s). Encoding of
#' the file should be UTF-8.
#' @param train_actual A text document where each row represents non-procedural statement from candidate(s)
#' Encoding of the file should be UTF-8.
#' @param full_data A dataset where each line represents data from candidate(s) to be classified as
#' procedural or non-procedural statement. Encoding should be UTF-8.
#' @param ... Arguments passed to \link[RTextTools:train_model]{train_model}
#'
#' @return An HTML file with each statement colored according to which group the model predicted it. Green
#' color means non-procedural, red means procedural (and should possibly be removed).
#' @examples
#' \dontrun{
#' unzip("./data/data.zip", exdir = "./data")
#' out <- findProceduralStatements(train_proc = "./data/izjave_proc.txt",
#'                          train_actual = "./data/izjave_vsebina.txt",
#'                          full_data = "./data/izjava_HAINZ PRIMOZ.txt",
#'                          html_file = "./sandy/rezultat.html")
#' }
#'
findProceduralStatements <- function(train_proc, train_actual, full_data, html_file, ...) {

    # library(RTextTools)
    learn.proc <- readLines(train_proc, encoding = "UTF-8")
    learn.vseb <- readLines(train_actual, encoding = "UTF-8")
    learn <- rbind(data.frame(statement = learn.proc, is_proc = 1),
                   data.frame(statement = learn.vseb, is_proc = 0)
    )

    dt.learn <- create_matrix(learn$statement)
    ct.learn <- create_container(matrix = dt.learn, labels = learn$is_proc, testSize = 1:nrow(learn), virgin = FALSE)

    mdl <- train_model(ct.learn, algorithm = "SVM", kernel = "linear", cost = 1, ...)

    h <- readLines(full_data, encoding = "UTF-8")

    dt.h <- create_matrix(as.list(h), originalMatrix = dt.learn)
    ct.h <- create_container(dt.h, labels = rep(0, length(h)), testSize = 1:length(h), virgin = FALSE)

    out <- classify_model(ct.h, model = mdl)
    out$col <- ifelse(out$SVM_LABEL == 1, "#FF0000", "#00FF00")

    html_file = file(description = html_file, open = "w+", encoding = "UTF-8")
    cat("<table>", file = html_file)
    for(i in 1:length(h)) {
        cat(sprintf('<tr style="color: %s"><td>%s</td></tr>', out[i, "col"], h[i]), file = html_file, append = TRUE)
    }
    cat("</table>", file = html_file, append = TRUE)

    out
}
