# FORM() check: for every question in EXAMPLES, pre-fill the boxes the way FORM() does, run the block,
# and count blocks that stop with an error (those show a red box to fix). Run: Rscript form_test.R ../exam2.R
options(ex2.test.file = commandArgs(TRUE)[1]); setwd(dirname(getOption("ex2.test.file"))); invisible(capture.output(source(basename(getOption("ex2.test.file"))))); B <- .ex2_blocks(readLines(basename(getOption("ex2.test.file")))); B <- B[setdiff(names(B), "D13")]
E <- EXAMPLES; res <- data.frame()
for (i in seq_len(nrow(E))) {
  q <- E$text[i]; tag <- E$tag[i]; if (!tag %in% names(B)) next
  b <- B[[tag]]; r <- tryCatch(.qnums(q), error = function(e) { cat("QNUMS FAIL", i, conditionMessage(e), "\n"); NULL }); if (is.null(r)) next
  fv <- tryCatch(.form_values(b, q, r), error = function(e) { cat("FV FAIL", i, tag, conditionMessage(e), "\n"); NULL }); if (is.null(fv)) next
  vals <- list(); bad <- c()
  for (k in seq_along(b$inputs)) { inp <- b$inputs[[k]]; p <- .fld_parse(fv[[k]]$val, .fld_type(inp$name, inp$def), inp$def, inp$desc)
    if (p$ok) vals[[inp$name]] <- p$code else bad <- c(bad, inp$name) }
  out <- if (length(bad)) paste("BAD", paste(bad, collapse = ",")) else paste(.run_block(b, vals), collapse = "\n")
  npf <- sum(vapply(fv, function(f) !is.null(f$pf), TRUE))
  res <- rbind(res, data.frame(i = i, tag = tag, npf = npf, nin = length(b$inputs), err = grepl("ERROR|^BAD", out), bad = paste(bad, collapse = ","), msg = substr(gsub("\n", " ", sub("^.*?(ERROR[^\n]*).*$", "\\1", out)), 1, 90)))
}
cat(sprintf("blocks run: %d   errors: %d   with >=1 prefilled box: %d\n", nrow(res), sum(res$err), sum(res$npf > 0)))
print(table(res$tag[res$err])); print(head(res[res$err, c("i","tag","bad","msg")], 25))
