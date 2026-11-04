args <- commandArgs(TRUE); .HERE <- normalizePath(dirname(sub('--file=', '', grep('--file=', commandArgs(FALSE), value = TRUE)))); script <- normalizePath(args[1]); out <- args[2]; .OUT <- out
setwd(dirname(script)); suppressMessages(capture.output(source(script)))
B <- read.csv(file.path(.HERE, 'bank500.csv'), stringsAsFactors = FALSE)
t0 <- Sys.time()
res <- t(sapply(seq_len(nrow(B)), function(i) {
  o <- NULL; capture.output(o <- suppressWarnings(FIND(B$text[i], go = FALSE)))
  ok <- strsplit(B$tags[i], " ")[[1]]; rk <- match(TRUE, o %in% ok)
  c(top = if (is.null(o)) NA else o[1], rank = ifelse(is.na(rk), 9, rk))
}))
B$top <- res[, "top"]; B$rank <- as.integer(res[, "rank"])
cat(sprintf("secs per question: %.2f\n", as.numeric(Sys.time() - t0, units = "secs") / nrow(B)))
for (f in c("dev", "test", "all")) { s <- if (f == "all") B else B[B$fold == f, ]
  cat(sprintf("%-4s n=%3d  top1 %.1f%%  top2 %.1f%%  top4 %.1f%%\n", f, nrow(s), 100*mean(s$rank==1), 100*mean(s$rank<=2), 100*mean(s$rank<=4))) }
k <- sub(" .*", "", B$kind); agg <- aggregate(cbind(top1 = B$rank == 1, top2 = B$rank <= 2) ~ k, B, mean)
agg$n <- as.vector(table(k)[agg$k]); agg <- agg[order(agg$top2), ]; print(head(agg, 25), row.names = FALSE)
write.csv(B, .OUT, row.names = FALSE)
