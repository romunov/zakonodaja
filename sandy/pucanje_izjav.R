library(RTextTools)
library(tm)

learn.proc <- readLines("./data/izjave_proc.txt", encoding = "UTF-8")
learn.vseb <- readLines("./data/izjave_vsebina.txt", encoding = "UTF-8")
learn <- rbind(data.frame(izjava = learn.proc, is_proc = 1),
      data.frame(izjava = learn.vseb, is_proc = 0)
)

dt.learn <- create_matrix(learn$izjava)
ct.learn <- create_container(matrix = dt.learn, labels = learn$is_proc, testSize = 1:nrow(learn), virgin = FALSE)

mdl <- train_model(ct.learn, algorithm = "SVM", kernel = "linear", cost = 1)

# uvozi podatke
h <- readLines("./data/izjava_HAINZ PRIMOZ.txt", encoding = "UTF-8")

# error je v create_matrix, ki ga popraviš na sledeč način: (glej SO odgovor Erica)
# http://stackoverflow.com/questions/32513513/rtexttools-create-matrix-got-an-error
dt.h <- create_matrix(as.list(h), originalMatrix = dt.learn)
ct.h <- create_container(dt.h, labels = rep(0, length(h)), testSize = 1:length(h), virgin = FALSE)

out <- classify_model(ct.h, model = mdl)
out$col <- ifelse(out$SVM_LABEL == 1, "#00FF00", "#FF0000")

#parsanje html-ja
f <- "final_hainz.html"
cat("<table>", file = f)
for(i in 1:length(h)) {
    cat(sprintf('<tr style="color: %s"><td>%s</td></tr>', out[i, "col"], h[i]), file = f, append = TRUE)
}
cat("</table>", file = "final_hainz.html", append = TRUE)
