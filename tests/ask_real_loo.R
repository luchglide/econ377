args <- commandArgs(TRUE); args[1] <- normalizePath(args[1]); setwd(dirname(args[1])); suppressMessages(capture.output(source(args[1])))
E0 <- EXAMPLES; hit1 <- hit2 <- 0; miss <- c()
# acceptable equivalents (same as bank grading): a solver and its specialised block both count
EQ <- list(S1=c("S1","O4","O5"), S2=c("S2","V1","V2","V3","V4","V5","V6"), S3=c("S3","U1","U2","U3","K8"), S4=c("S4","L1","L2","L3","K9"),
  S5=c("S5","P1","P2","P3"), S6=c("S6","O1","O3"), S7=c("S7","M1","M2","M3"), L1=c("L1","S4"), L2=c("L2","S4"), L3=c("L3","S4"), L4=c("L4","S4"),
  K8=c("K8","S3"), K9=c("K9","S4"), V6=c("V6","S2"), M3=c("M3","S7"), B1=c("B1","B2"), B2=c("B2","B1"), B3=c("B3","K17"), K17=c("K17","B3"),
  T1=c("T1","T2"), T2=c("T2","T1"), D1=c("D1","D13"), D7=c("D7","D13"), K2=c("K2","K12"), K12=c("K12","K2"), K7=c("K7","K4"), K4=c("K4","K7"))
for (i in seq_len(nrow(E0))) {
  EXAMPLES <<- E0[-i, ]; if (exists(".ASKIDX", envir = globalenv())) rm(".ASKIDX", envir = globalenv())
  o <- NULL; capture.output(o <- tryCatch(FIND(E0$text[i], go = FALSE), error = function(e) FIND(E0$text[i])))
  ok <- if (!is.null(EQ[[E0$tag[i]]])) EQ[[E0$tag[i]]] else E0$tag[i]
  hit1 <- hit1 + (o[1] %in% ok); hit2 <- hit2 + any(o[1:2] %in% ok)
  if (!any(o[1:2] %in% ok)) miss <- c(miss, sprintf("%3d %-4s -> %-4s %s", i, E0$tag[i], o[1], substr(gsub("\\s+"," ",E0$text[i]), 1, 100)))
}
cat(sprintf("REAL questions leave-one-out: top1 %d/%d  top2 %d/%d\n", hit1, nrow(E0), hit2, nrow(E0))); cat(miss, sep = "\n")
