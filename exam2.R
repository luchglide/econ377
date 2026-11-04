# =======================================================================
# BEFORE YOU START: DO THESE 3 THINGS ONCE (with internet)
# =======================================================================
#  1. Install the 2 packages. Paste this in the Console, press Enter:
#        install.packages(c("wooldridge", "rstudioapi"))
#     (asked "install from sources?" -> type no.  "personal library?" -> yes)
#
#  2. Check it worked. Paste this in the Console:
#        library(wooldridge); nrow(wage1)
#     It should print  [1] 526
#
#  3. Point R at this folder: Session -> Set Working Directory ->
#     To Source File Location. Then run the whole file: Cmd+Shift+Enter
#     (Windows: Ctrl+Shift+Enter). The SETUP CHECK box it prints should say
#     OK / OK / found.
#
#  What the 2 packages do:
#    wooldridge = the course datasets (wage1, ceosal1, ...). If it won't
#                 install, the script uses the copies in data/ instead.
#    rstudioapi = lets FIND() jump your cursor to the right block.
#                 Optional: without it FIND() just prints the line number.
#  Do steps 1-3 at home AND on the lab PC before the exam starts.
# =======================================================================

# =======================================================================
# ECN 377 - EXAM II SCRIPT (Wed Nov 11). Round every answer to hundredths.
# Built from EVERY question on PS8-PS11 and Quizzes 7-10 (the exam is drawn from
# them, like Exam I was drawn from PS1-PS7), plus D21-D22 t-tests.
# =======================================================================
# SETUP (before the exam; internet is off once it starts):
#   1. Pull this repo, open it as an RStudio project (so data/ is found).
#   2. Run the WHOLE file once: Ctrl+Shift+Enter (Mac: Cmd+Shift+Enter).
#      Every block prints its default answer; each comment says what it should be.
#
# DURING THE EXAM, for each question:
#   1. FIND IT. In the Console type FIND("") with words from the question, e.g.
#        FIND("log percent falls")      FIND("dollars log predicted")
#        FIND("residual row")           FIND("sd sample variance n")
#      It lists the matching block tags, best first. (Or Ctrl+F the tag.)
#   2. Each block starts with LOOKS LIKE: (a real question of that type).
#      Check it matches.
#   3. Change ONLY the lines marked  # <-- CHANGE.
#   4. Highlight the block, Ctrl+Enter, copy the ">>> ANSWER" line.
#
# ORDER ON THE EXAM: Part 1 real data first (fast points), then Part 2,
# then Part 3 multiple choice. Never leave a blank. Stuck > 3 min: move on.
# SIGN RULE: "falls/decreases/drops" -> NEGATIVE change. Keep minus signs.
# PREDICTION keeps the intercept. CHANGE drops it.
# =======================================================================
# PART 1 - REAL DATA (wooldridge)               PART 2 - NUMBERS IN THE QUESTION
#                                                [S1]-[S7] SOLVERS: type what's given, NA the rest;
#                                                  they print EVERY related answer (twist-proof)
#  [D0] n, mean, sd, cor of columns              [U1] x rescaled -> new slope
#  [D1] simple lm: slope, prediction, change,    [U2] y rescaled -> new slope/intercept
#       R^2, residual of a row, SST/SSE/SSR      [U3] log(y) model, y rescaled -> intercept
#  [D2] rescale a column, rerun (units)          [L1] log-level  %dy = 100*b*dx
#  [D3] log-level % change from data             [L2] log-log    %dy = b*%dx
#  [D4] level-log change from data               [L3] level-log  dy = b/100*%dx
#  [D5] log-log % change from data               [L4] log-level MLR % (several x's)
#  [D6] sigma-hat, SST_x, se by hand             [M1] MLR prediction (keep intercept)
#  [D7] MLR: coef, prediction, change            [M2] MLR change (drop intercept)
#  [D8] log(y) MLR: % change, $ prediction exp() [M3] ybar from the line and the means
#  [D9] prediction at the means = mean(y)        [O1] residual of observation i (small data)
#  [D10] OVB in data: simple, multiple, delta    [O2] missing residual
#  [D11] perfect collinearity -> NA              [O3] sum of x*uhat (always 0)
#  [D12] t-stat + one-sided test from data       [O4] SSR from SSE and R^2
#  [D13] REG(): everything at once               [O5] SST from n and S^2
#                                                ** NEW WORDING? [S1]-[S7] any-input solvers **
#                                                [V1] Var(b1) = sigma^2/SST
# PART 3 - MULTIPLE CHOICE                       [V2] sd/se from sigma, n, S_X (or S_X^2)
#  [K1]-[K16] answers keyed to the question      [V3] sd from sigma and raw x values
#  wording (assumptions, OVB stories, units,     [V4] sigma^2-hat = SSR/(n-k-1)
#  log interpretation, Var direction,            [V5] se from SSR, n, SST_x
#  collinearity, t-tests ...)                    [V6] sd when sample is k times as large
#                                                [V7] MLR Var with Rj^2 (VIF)
#                                                [B1] OVB formula (3.23), solve for any
#                                                [B2] Bias = beta2 * delta1
#                                                [B3] direction of bias (sign table)
#                                                [P1] sd(aX+b) from E[X], E[X^2]
#                                                [P2] Var(aX+bY)
#                                                [P3] Cor from a joint probability table
#                                                [T1] t-stat, critical values, decisions
#                                                [T2] decision from given t and c, or p
#                                                [T3] confidence interval   [T4] F-stat
# =======================================================================

# START HERE: HOW TO GET TO THE RIGHT BLOCK IN 10 SECONDS ######################
#  Way 1 (fastest): run this whole file once (Cmd/Ctrl+Shift+Enter), then in the
#        Console type FIND("a few words from the question"). It lists the best
#        blocks and JUMPS your cursor to the top one. Not it? Type GO("S2") etc.
#  Way 2: open RStudio's outline (Cmd/Ctrl+Shift+O, or the list icon at the top
#        right of this script). Every block is listed there by tag. Click to jump.
#  Way 3: Cmd/Ctrl+F the tag, e.g. [S1].
#
#  OR decide by eye with this map:
#   Does it say "Data:" and name a dataset?        -> PART 1, [D0]-[D13]
#        n / mean / cor of columns ............ [D0]   simple lm anything ... [D1]
#        log in lm(...) ............ [D3] [D4] [D5]   several x's .......... [D7]
#        log(y) + several x's / "in dollars" .. [D8]   sigma-hat, se ........ [D6]
#        leave a variable out / delta ........ [D10]   t-statistic, test .. [D12]
#   Is it a concept / "which statement" question?   -> PART 3, [K1]-[K17]
#   Otherwise numbers are given. What do they talk about?
#        SST, SSE, SSR, R^2 ................... [S1]   sd/se/Var of b1 ...... [S2]
#        "measured in ... instead", x1000 ..... [S3]   log / percent ........ [S4]
#        E[X], Var(aX+bY), probability table .. [S5]   x = ( ), y = ( ) .... [S6]
#        an equation y-hat = ... .............. [S7]   formula 3.23, bias ... [B1]-[B3]
#        t = , critical value, p-value ........ [T1] [T2]
################################################################################

rm(list = ls())

# STEP 0: SETUP CHECK (installs what's missing, then reports) ##################
# What this script needs:
#   1. wooldridge  - the course datasets. If it can't install, the CSV copies in
#                    data/ are used instead, so the script still works.
#   2. rstudioapi  - lets FIND() / GO() move your cursor to a block. Optional:
#                    without it, they print the line number instead.
#   3. The data/ folder next to this script (comes with the econ377 repo).
# HOW: run this file once WHILE YOU HAVE INTERNET (at home the night before, AND
#   on the lab PC before the exam starts). Missing packages install automatically.
#   With no internet it just skips the install and uses data/.
# If wooldridge won't install (older R), run this once in the Console:
#   install.packages("https://cloud.r-project.org/src/contrib/Archive/wooldridge/wooldridge_1.4-3.tar.gz", repos = NULL, type = "source")
# If data/ isn't found: Session -> Set Working Directory -> To Source File Location.
for (pkg in c("wooldridge", "rstudioapi")) {
  if (!requireNamespace(pkg, quietly = TRUE))
    suppressWarnings(try(install.packages(pkg, repos = "https://cloud.r-project.org", quiet = TRUE), silent = TRUE))
}
cat("\n---- SETUP CHECK ----\n")
cat(sprintf("  wooldridge package : %s\n", if (requireNamespace("wooldridge", quietly = TRUE)) "OK" else "not installed -> using data/ CSV copies"))
cat(sprintf("  rstudioapi package : %s\n", if (requireNamespace("rstudioapi", quietly = TRUE)) "OK (FIND jumps to blocks)" else "not installed -> FIND prints line numbers"))
cat(sprintf("  data/ folder       : %s\n", if (dir.exists("data")) "found" else
  "NOT FOUND -> Session > Set Working Directory > To Source File Location, then rerun"))
if (!requireNamespace("wooldridge", quietly = TRUE) && !dir.exists("data"))
  cat("  !! No datasets available: fix the working directory (above) or install wooldridge.\n")
cat("---------------------\n")
ans  <- function(label, x) cat(sprintf(">>> ANSWER %-38s %s\n", label, format(round(unname(x), 2), nsmall = 2)))
ans4 <- function(label, x) cat(sprintf(">>> ANSWER %-38s %s\n", label, format(round(unname(x), 4), nsmall = 4)))
pick <- function(label, x) cat(sprintf(">>> PICK   %-38s %s\n", label, x))
info <- function(label, x) cat(sprintf("    %-45s %s\n", label, x))
get_data <- function(name) {
  if (requireNamespace("wooldridge", quietly = TRUE)) {
    e <- new.env(); data(list = name, package = "wooldridge", envir = e); get(name, e)
  } else read.csv(file.path("data", paste0(name, ".csv")))
}
## Loads every dataset the course has used (all have offline copies in data/).
for (d in c("wage1", "wage2", "ceosal1", "ceosal2", "bwght", "gpa1", "gpa2", "vote1", "campus", "rdchem",
            "mlb1", "meap93", "hprice1", "k401k", "discrim", "attend", "crime1", "sleep75", "lawsch85", "jtrain"))
  assign(d, get_data(d))
## Any other dataset: name <- get_data("name")  (needs the wooldridge package if no CSV)

## ---- FIND(): type words from the question, get the block tag -----------------
CATALOG <- list(
  c("S1",  "SOLVER sums of squares: any of SST, SSE, SSR, R^2, n + S_y^2", "sst sse ssr r2 r-squared explained unexplained fraction total sum squares residual sample variance n observations"),
  c("S2",  "SOLVER Var/sd/se of the slope from any mix of sigma, SSR, n, SST_x, x, S_X", "variance sd se standard error standard deviation sigma ssr sst_x sample variance x n observations var(b1 vif"),
  c("S3",  "SOLVER units: rescale y and/or x in any of the 4 log models", "units measured instead multiplied divided 1000 100 dollars thousands percent decimal new slope intercept log-log log-level level-log"),
  c("S4",  "SOLVER logs: prints the answer for all 4 log models + percent vs points", "log log-log log-level level-log percent units elasticity percentage points rises falls about"),
  c("S5",  "SOLVER probability: E[X], Var, sd(aX+b), Var(aX+bY), tables, Cor", "e[x] e[x^2] expected var(x) var(y) cov(x,y) sd(ax+b) joint distribution probability table cor(x,y) takes values with probabilities"),
  c("S6",  "SOLVER small sample: type x and y, get slope, intercept, residuals, R^2, cor ...", "sample x= y= regress by hand slope intercept residual observation predict sum sample standard deviation covariance correlation"),
  c("S7",  "SOLVER equation: prediction, change, ybar, % change, exp() for logged y", "yhat equation predicted value change rises falls sample mean ybar means intercept percent dollars"),
  c("D0",  "Data: n, mean, sd, correlation of columns", "data how many sample n rows mean average correlation cor sd standard deviation columns"),
  c("D1",  "Data, simple lm: slope, prediction, change, R^2, residual of row, SSE/SSR/SST", "data run lm regress ols slope predicted prediction change rises from to r-squared percentage variation explained residual row sse ssr sst explained sum of squares"),
  c("D2",  "Data: measure y or x in other units, new slope", "data units measured instead dollars thousands slope rescale percent decimal"),
  c("D3",  "Data: log-level, % change in y", "data log-level log percent change rises points"),
  c("D4",  "Data: level-log, change in y units", "data level-log log sales rise percent thousand dollars"),
  c("D5",  "Data: log-log, % change (elasticity)", "data log-log log percent elasticity rises"),
  c("D6",  "Data: sigma-hat, SST_x, standard error by hand", "data sigma standard error regression sst_x total sum squares explanatory se hand"),
  c("D7",  "Data, multiple regression: coefficient, predicted value, change holding fixed", "data multiple educ exper tenure predicted hourly wage worker years holding fixed change coefficient"),
  c("D8",  "Data, log(y) multiple regression: % change or predicted $ with exp()", "data log multiple percent predicted dollars exp hourly wage holding fixed"),
  c("D9",  "Data: predicted y at the means = mean of y", "data means mean predicted at sample means same why"),
  c("D10", "Data: omitted-variable bias, simple vs multiple, delta1, b2*delta1", "data omitted left out simple multiple delta slope regress on compute b2 bias add cigs faminc"),
  c("D11", "Data: perfect collinearity, R reports NA", "data na reports coefficient total exact linear function collinearity"),
  c("D12", "Data: t-statistic, one-sided/two-sided test", "data t statistic test reject h0 null positive significant critical"),
  c("D13", "Data: REG() prints everything for one regression", "data regression everything all report"),
  c("U1",  "x multiplied/divided by c: new slope", "x divided multiplied 1000 100 new slope percent decimal units"),
  c("U2",  "y multiplied by c: new slope/intercept", "y multiplied 1000 dollars cents new slope intercept units"),
  c("U3",  "log(y) model, y rescaled: new intercept", "log intercept new measured dollars thousands log(1000)"),
  c("L1",  "log-level: %dy = 100*b*dx", "log-level log percent change rises falls by about months year"),
  c("L2",  "log-log: %dy = b*%dx (elasticity)", "log-log log percent elasticity rises falls"),
  c("L3",  "level-log: dy = (b/100)*%dx", "level-log log units how many percent rises"),
  c("L4",  "log-level multiple regression: % change with several x's", "log multiple percent x1 x2 rises falls both"),
  c("M1",  "multiple regression prediction (keep intercept)", "multiple predicted value yhat at x1 x2 plug"),
  c("M2",  "multiple regression change (drop intercept)", "multiple change rises falls by how much x1 x2 intercept"),
  c("M3",  "ybar from the fitted line and the means", "sample mean ybar means intercept slope passes through point"),
  c("O1",  "OLS residual of one observation (small sample)", "sample residual observation third fourth regress by hand"),
  c("O2",  "missing residual (residuals sum to 0)", "residuals one more missing fifth sixth"),
  c("O3",  "sum of x_i * uhat_i (always 0)", "sum x residuals compute property"),
  c("O4",  "SSR from SSE and R^2", "explained sum squares sse r2 r-squared find ssr residuals"),
  c("O5",  "SST from n and sample variance", "total sum squares sst sample variance n observations"),
  c("V1",  "Var(b1) = sigma^2 / SST_x", "variance error variance sst var theorem 2.2"),
  c("V2",  "sd/se of b1 from sigma (or sigma-hat), n, S_X or S_X^2", "sd se standard error standard deviation sample variance x n observations sigma"),
  c("V3",  "sd of b1 from sigma and raw x values", "sd standard deviation x values sigma five"),
  c("V4",  "sigma^2-hat = SSR / (n-k-1)", "estimate error variance sigma2 ssr n observations"),
  c("V5",  "se(b1) from SSR, n, SST_x", "standard error se ssr sst_x n observations"),
  c("V6",  "sd(b1) when the sample is k times as large", "times as large sample sd spread same way"),
  c("V7",  "multiple regression Var(bj) with Rj^2 / VIF", "variance inflation vif multicollinearity rj2 r-squared other"),
  c("B1",  "OVB formula (3.23): solve for any piece", "formula 3.23 simple multiple slope delta b1tilde b1hat b2hat b2 find coefficient"),
  c("B2",  "Bias = beta2 * delta1 (or expected simple slope)", "bias beta2 delta1 omit e[b1tilde] expected value of the simple slope true beta1"),
  c("B3",  "direction of omitted-variable bias (sign table)", "biased upward downward overstates understates omitted direction sign"),
  c("P1",  "sd(aX+b) from E[X] and E[X^2]", "e[x] e[x^2] standard deviation 3x"),
  c("P2",  "Var(aX+bY) with a covariance", "var(x) var(y) cov(x,y) var(2x"),
  c("P3",  "correlation from a joint probability table", "joint distribution p(x=x cor(x,y) table probability"),
  c("T1",  "t-statistic, critical values, p-values, decisions", "t statistic se estimate reject critical value alpha df h0 h1 one-sided two-sided p-value"),
  c("T2",  "decision from a given t and c, or a p-value", "given t critical value reject fail p-value alpha"),
  c("T3",  "confidence interval", "confidence interval ci 95 lower upper"),
  c("T4",  "F-statistic", "f statistic joint restricted unrestricted"),
  c("K1",  "MC: which candidate line is OLS (sum u, sum |u|, sum u^2)", "candidate lines four ols line sum residuals absolute squared"),
  c("K2",  "MC: zero conditional mean / MLR.4 holds or fails (something in U moves with x)", "part of u zero conditional mean e[u assumption fails holds endogenous exogenous tend to"),
  c("K3",  "MC: which variable causes omitted-variable bias", "most likely contribute omitted-variable bias ability family income id random"),
  c("K4",  "MC: what unbiased means", "unbiased theorem 2.1 e[b1 averaged many samples researchers"),
  c("K5",  "MC: x has no variation (SLR.3)", "every worker exactly same value goes wrong no variation"),
  c("K6",  "MC: heteroskedasticity (spread grows with x)", "spread grows heteroskedasticity homoskedasticity slr5 mlr5"),
  c("K7",  "MC: what makes Var / se of b1 larger or smaller", "makes var larger smaller se spread out bunched sample error variance correlated other regressors"),
  c("K8",  "MC: what happens to b0, b1, R^2 when units change", "multiplied measured instead happens slope intercept r2 divided units cents months"),
  c("K9",  "MC: what does the slope mean in a log model", "what does mean 1% rise associated log elasticity interpretation"),
  c("K10", "MC: properties always true after OLS", "always true residuals average sample means covariance select all properties"),
  c("K11", "MC: perfect collinearity / MLR.3 violations", "perfect collinearity mlr3 violate cannot estimate dollars cents exact total"),
  c("K12", "MC: what makes MLR.4 fail", "mlr4 fail endogenous left out functional form"),
  c("K13", "MC: why not add every variable", "add every variable why not too many"),
  c("K14", "MC: reading simple vs multiple slopes", "simple multiple slope reading holding fixed riding along"),
  c("K15", "MC: when omitting x2 causes no bias", "no bias when omitting uncorrelated no effect"),
  c("K16", "MC: assumptions (BLUE, Gauss-Markov), t-test and p-value concepts", "blue gauss-markov best linear unbiased assumptions mlr1 mlr5 normality p-value meaning significant"),
  c("K17", "MC: OVB stories (ability, land, motivation, income, tutoring...)", "story scenario omitted overstates understates direction")
)
EXAM2_PATH <- tryCatch(if (requireNamespace("rstudioapi", quietly = TRUE) && rstudioapi::isAvailable())
  rstudioapi::getSourceEditorContext()$path else "", error = function(e) "")
if (!nzchar(EXAM2_PATH) || !file.exists(EXAM2_PATH)) EXAM2_PATH <- "exam2.R"
GO <- function(tag) {
  tag <- toupper(gsub("[][ ]", "", tag))
  if (!file.exists(EXAM2_PATH)) { cat("Ctrl+F [", tag, "] in the script.\n", sep = ""); return(invisible()) }
  n <- grep(paste0("^## \\[", tag, "\\]"), readLines(EXAM2_PATH, warn = FALSE))[1]
  if (is.na(n)) { cat("No block [", tag, "].\n", sep = ""); return(invisible()) }
  ok <- tryCatch({ rstudioapi::navigateToFile(EXAM2_PATH, line = n, column = 1); TRUE }, error = function(e) FALSE)
  cat(sprintf("  [%s] is at line %d%s\n", tag, n, if (ok) " -> cursor moved there" else " (Cmd/Ctrl+F the tag)"))
  invisible(n)
}
FIND <- function(words) {
  stop <- c("the","of","in","by","a","an","and","to","is","what","does","when","how","are","at","on",
            "for","with","its","that","this","be","as","or","if","about","run","use","give","round","hundredths",
            "regression","regress","find","value","values","x","y","which","statement","correct","what","happens")
  w <- unique(tolower(strsplit(gsub("[?.:;()\"']", " ", words), "[ ,]+")[[1]]))
  w <- w[nchar(w) > 1 & !(w %in% stop)]
  txt <- sapply(CATALOG, function(e) tolower(paste(e[1], e[2], e[3])))
  hit <- sapply(w, function(x) grepl(x, txt, fixed = TRUE))
  if (!length(w)) { cat("Type a few words from the question.\n"); return(invisible()) }
  hit <- matrix(hit, nrow = length(txt))
  idf <- log((length(txt) + 1) / (colSums(hit) + 0.5))      # rare words count more
  sc <- as.vector(hit %*% pmax(idf, 0))
  if ("data" %in% w) sc <- sc * ifelse(grepl("^D", sapply(CATALOG, `[`, 1)), 1.6, 1)   # "Data:" question -> real-data blocks first
  o <- order(-sc); o <- o[sc[o] > 0][1:min(5, sum(sc > 0))]
  if (!length(o) || is.na(o[1])) { cat("No match. Try other words from the question.\n"); return(invisible()) }
  for (i in o) cat(sprintf("  [%s]  %-72s\n", CATALOG[[i]][1], CATALOG[[i]][2]))
  GO(CATALOG[[o[1]]][1])
  if (length(o) > 1) cat(sprintf("  Not it? GO(\"%s\")\n", CATALOG[[o[2]]][1]))
}

## ---- STATS(), REG(), OVB(), FTEST(): one-call reports --------------------------
STATS <- function(data, vars) {
  cat(sprintf("\n--- STATS: dataset has n = %d rows ---\n", nrow(data)))
  for (v in vars) { x <- data[[v]]
    cat(sprintf(">>> ANSWER %-14s n=%d  mean=%.2f  sd=%.2f  var=%.2f\n", v, sum(!is.na(x)),
                mean(x, na.rm = TRUE), sd(x, na.rm = TRUE), var(x, na.rm = TRUE))) }
  if (length(vars) > 1) { cat("    correlation matrix:\n"); print(round(cor(data[vars], use = "complete.obs"), 4)) }
}
REG <- function(formula, data, at = NULL, from = NULL, to = NULL, row = NULL,
                test = NULL, h0 = 0, alpha = 0.05, level = 0.95) {
  fit <- lm(formula, data = data); s <- summary(fit); ct <- coef(s)
  n <- nobs(fit); df <- fit$df.residual; k <- length(coef(fit)) - 1
  yname <- deparse(formula[[2]]); logy <- grepl("^log\\(", yname)
  ci <- confint(fit, level = level)
  cat(sprintf("\n===== REG: %s   (n = %d, k = %d, df = n-k-1 = %d) =====\n", deparse(formula), n, k, df))
  tab <- cbind(estimate = ct[, 1], se = ct[, 2], t = ct[, 3], p = ct[, 4], ci)
  colnames(tab)[5:6] <- paste0(c("CI_low_", "CI_high_"), level * 100); print(round(tab, 4))
  yv <- model.response(model.frame(fit)); SSR <- sum(resid(fit)^2); SST <- sum((yv - mean(yv))^2)
  ans("R^2", s$r.squared); ans("R^2 in percent", 100 * s$r.squared); ans("adjusted R^2", s$adj.r.squared)
  ans("SST (total)", SST); ans("SSE (EXPLAINED)", SST - SSR); ans("SSR (RESIDUAL)", SSR)
  ans("sigma-hat = sqrt(SSR/(n-k-1))", s$sigma)
  vars <- all.vars(formula)[-1]
  base <- lapply(model.frame(lm(reformulate(vars, yname), data = data))[vars], mean)
  pred <- function(vals) { nd <- base; nd[names(vals)] <- vals; predict(fit, as.data.frame(nd)) }
  if (!is.null(at)) { miss <- setdiff(vars, names(at))
    if (length(miss)) info("WARNING: set to their mean:", paste(miss, collapse = ", "))
    p <- pred(at); ans(paste0("prediction of ", yname), p); if (logy) ans("prediction in levels = exp(above)", exp(p)) }
  if (!is.null(from) && !is.null(to)) { dd <- pred(to) - pred(from); ans(paste0("change in ", yname), dd)
    if (logy) { ans("% change in y (approx 100*change)", 100 * dd); ans("% change in y (exact)", 100 * (exp(dd) - 1)) } }
  if (!is.null(row)) { r <- as.character(row); ans(paste0("row ", row, " actual"), yv[r])
    ans(paste0("row ", row, " fitted"), fitted(fit)[r]); ans(paste0("row ", row, " residual"), resid(fit)[r]) }
  if (!is.null(test)) { b <- ct[test, 1]; se <- ct[test, 2]; t <- (b - h0) / se
    c2 <- qt(1 - alpha / 2, df); c1 <- qt(1 - alpha, df)
    cat(sprintf("--- t-test on %s:  H0: b = %g,  alpha = %g ---\n", test, h0, alpha))
    ans("t = (b - h0)/se", t); ans("critical c two-sided", c2); ans("critical c one-sided", c1)
    ans("p-value two-sided", 2 * pt(-abs(t), df)); ans("p-value one-sided H1: b > h0", pt(t, df, lower.tail = FALSE))
    pick("H1: b != h0", ifelse(abs(t) > c2, "REJECT H0", "fail to reject H0"))
    pick("H1: b >  h0", ifelse(t > c1, "REJECT H0", "fail to reject H0"))
    pick("H1: b <  h0", ifelse(t < -c1, "REJECT H0", "fail to reject H0")) }
  invisible(fit)
}
FTEST <- function(unrestricted, restricted, data, alpha = 0.05) {
  dat <- data[complete.cases(data[all.vars(unrestricted)]), ]
  fu <- lm(unrestricted, data = dat); fr <- lm(restricted, data = dat)
  SSRu <- sum(resid(fu)^2); SSRr <- sum(resid(fr)^2); q <- fr$df.residual - fu$df.residual; dfu <- fu$df.residual
  Fs <- ((SSRr - SSRu) / q) / (SSRu / dfu); cF <- qf(1 - alpha, q, dfu)
  ans("F-statistic", Fs); ans("critical value c", cF); ans("p-value", pf(Fs, q, dfu, lower.tail = FALSE))
  pick("decision", ifelse(Fs > cF, "REJECT H0 (jointly significant)", "fail to reject H0"))
}

# PART 1 - REAL DATA ########################################################
cat("\n#################### PART 1 - REAL DATA ####################\n")

## ======================================================================
## [D0] n, mean, sd, correlation of columns ----
## LOOKS LIKE: "Data: ceosal1. How many CEOs are in the sample?" / "sample mean of roe?"
##   / "sample correlation between salary and roe?"          (Exam I Q29-Q31)
## A correlation NEVER comes from lm(). It must be between -1 and 1.
## DEFAULTS -> 209, 17.18, 0.11
d0_data <- ceosal1                                          # <-- CHANGE dataset
ans("[D0] n = nrow(data)", nrow(d0_data))
ans("[D0] mean(data$x)", mean(d0_data$roe))                 # <-- CHANGE column
ans("[D0] sd(data$x)", sd(d0_data$roe))                     # <-- CHANGE column
ans("[D0] cor(data$x, data$y)", cor(d0_data$salary, d0_data$roe))   # <-- CHANGE columns

## ======================================================================
## [D1] simple regression: slope, prediction, change, R^2, residual of a row ----
## LOOKS LIKE: "Data: wage1. Run reg <- lm(wage ~ tenure). What is the OLS slope? /
##   predicted wage at 10 years of tenure? / change from 3 to 16 years? / % of
##   variation explained? / residual of the worker in row 12?"  (Exam I, PS8 #11, Q7 #11)
## DEFAULTS -> slope 0.18 | pred 6.76 | change 2.31 | R^2% 12.03 | row 12 resid 3.14
d1_reg <- lm(wage ~ tenure, data = wage1)                   # <-- CHANGE y ~ x, data
d1_b <- d1_reg$coefficients
ans("[D1] slope b[2]", d1_b[2])
ans("[D1] intercept b[1]", d1_b[1])
ans("[D1] prediction b[1] + b[2]*x", d1_b[1] + d1_b[2] * 10)             # <-- CHANGE x
ans("[D1] change b[2]*(new - old)", d1_b[2] * (16 - 3))                   # <-- CHANGE new, old
ans("[D1] R^2 percent", 100 * summary(d1_reg)$r.squared)
ans("[D1] residual of row i", d1_reg$residuals[12])                      # <-- CHANGE row
d1_y <- model.response(model.frame(d1_reg))
ans("[D1] SSE (explained)", sum((d1_reg$fitted.values - mean(d1_y))^2))
ans("[D1] SSR (residual)", sum(d1_reg$residuals^2))
ans("[D1] SST (total)", sum((d1_y - mean(d1_y))^2))

## ======================================================================
## [D2] measure y (or x) in other units, rerun -> new slope ----
## LOOKS LIKE: "Data: ceosal1. Run lm(salary ~ sales). If salary is measured in dollars
##   instead of thousands of dollars, what is the OLS slope?"  (PS8 #16)
## y times c -> slope times c.  x times c -> slope divided by c.  R^2 never changes.
## DEFAULT -> 15.47
d2_data <- ceosal1                                          # <-- CHANGE dataset
d2_data$ynew <- d2_data$salary * 1000                       # <-- CHANGE column and factor (or leave y alone)
d2_data$xnew <- d2_data$sales * 1                           # <-- CHANGE column and factor (1 = unchanged)
ans("[D2] new slope", coef(lm(ynew ~ xnew, data = d2_data))[2])

## ======================================================================
## [D3] log-level from data: % change in y = 100 * b * dx ----
## LOOKS LIKE: "Data: wage1. Run lm(log(wage) ~ exper). By about what percent does
##   predicted wage change with 10 more years of experience?"  (PS8 #21, PS9 #6, Q8 #6)
## DEFAULT -> 4.36   (ceosal1 log(salary) ~ roe, roe +5 -> 6.93; +7 -> 9.70)
d3_reg <- lm(log(wage) ~ exper, data = wage1)               # <-- CHANGE log(y) ~ x, data
d3_dx <- 10                                                 # <-- CHANGE change in x (falls = negative)
ans("[D3] % change in y", 100 * d3_reg$coefficients[2] * d3_dx)

## ======================================================================
## [D4] level-log from data: change in y = (b/100) * %dx ----
## LOOKS LIKE: "Data: ceosal1. Run lm(salary ~ log(sales)). By about how many thousand
##   dollars does predicted salary change when sales rise by 10%?"  (PS9 #7)
## DEFAULT -> 26.29
d4_reg <- lm(salary ~ log(sales), data = ceosal1)           # <-- CHANGE y ~ log(x), data
d4_pctx <- 10                                               # <-- CHANGE % change in x
ans("[D4] change in y (units of y)", d4_reg$coefficients[2] / 100 * d4_pctx)

## ======================================================================
## [D5] log-log from data: % change in y = b * %dx (elasticity) ----
## LOOKS LIKE: "Data: bwght. Run the log-log regression of log(bwght) on log(faminc).
##   By about what percent does birth weight change when income rises by 15%?" (Q9 #3, PS10 #3)
## DEFAULT -> 0.31   (20% -> 0.41)
d5_reg <- lm(log(bwght) ~ log(faminc), data = bwght)        # <-- CHANGE log(y) ~ log(x), data
d5_pctx <- 15                                               # <-- CHANGE % change in x
ans("[D5] % change in y", d5_reg$coefficients[2] * d5_pctx)

## ======================================================================
## [D6] sigma-hat, SST_x, standard error by hand ----
## LOOKS LIKE: "Data: wage1. Run lm(wage ~ educ). What is sigma-hat?" / "SST_X for educ?"
##   / "Compute se(b1) by hand from sigma-hat and SST_X"  (PS9 #18-19, PS10 #10)
## DEFAULTS -> sigma-hat 3.38 | SST_x 4025.43 | se 0.05
d6_reg <- lm(wage ~ educ, data = wage1)                     # <-- CHANGE y ~ x, data
d6_x <- wage1$educ                                          # <-- CHANGE the x column
d6_sig <- sqrt(sum(d6_reg$residuals^2) / d6_reg$df.residual)
d6_SST <- sum((d6_x - mean(d6_x))^2)
ans("[D6] sigma-hat = sqrt(SSR/(n-2))", d6_sig)
ans("[D6] sigma^2-hat", d6_sig^2)
ans("[D6] SST_x = sum((x - mean)^2)", d6_SST)
ans("[D6] se(b1) = sigma-hat/sqrt(SST_x)", d6_sig / sqrt(d6_SST))
ans("[D6] check: R's Std. Error", summary(d6_reg)$coefficients[2, 2])

## ======================================================================
## [D7] multiple regression: coefficient, predicted value, change holding others fixed ----
## LOOKS LIKE: "Data: wage1. Regress wage on educ, exper and tenure. Predicted hourly
##   wage of a worker with 16 educ, 5 exper, 2 tenure?" / "change when exper rises by
##   10, holding educ and tenure fixed?"   (Q9 #10-11, PS10 #14-15)
## DEFAULTS -> pred 7.16 | change 0.22
d7_reg <- lm(wage ~ educ + exper + tenure, data = wage1)    # <-- CHANGE y ~ x1 + x2 + x3, data
d7_b <- d7_reg$coefficients
print(round(d7_b, 4))
d7_at <- c(16, 5, 2)                                        # <-- CHANGE x VALUES, same order as formula
d7_dx <- c(0, 10, 0)                                        # <-- CHANGE x CHANGES (fixed = 0)
ans("[D7] predicted y (keeps intercept)", d7_b[1] + sum(d7_b[-1] * d7_at))
ans("[D7] change in y (no intercept)", sum(d7_b[-1] * d7_dx))

## ======================================================================
## [D8] log(y) multiple regression: % change, or predicted DOLLARS with exp() ----
## LOOKS LIKE: "Run lm(log(wage) ~ educ + exper + tenure). By about what percent does
##   wage change when exper rises 2 and tenure rises 1?" / "predicted hourly wage, in
##   dollars, at 12 educ, 10 exper, 3 tenure?"   (PS11 #2-3, PS10 #16-17)
## "in dollars" + log(y) -> exp().  DEFAULTS -> 3.03% | $4.46
d8_reg <- lm(log(wage) ~ educ + exper + tenure, data = wage1)   # <-- CHANGE
d8_b <- d8_reg$coefficients
d8_dx <- c(0, 2, 1)                                         # <-- CHANGE x CHANGES (fixed = 0)
d8_at <- c(12, 10, 3)                                       # <-- CHANGE x VALUES
ans("[D8] % change in y = 100*sum(b*dx)", 100 * sum(d8_b[-1] * d8_dx))
ans("[D8] predicted log(y) (NOT dollars)", d8_b[1] + sum(d8_b[-1] * d8_at))
ans("[D8] predicted y in $ = exp(...)", exp(d8_b[1] + sum(d8_b[-1] * d8_at)))

## ======================================================================
## [D9] predicted y at the sample means = mean of y ----
## LOOKS LIKE: "Run lm(colGPA ~ ACT + hsGPA). Compute predicted colGPA at ACT = mean(ACT)
##   and hsGPA = mean(hsGPA). Why is it the same as mean(colGPA)?"   (PS11 #5)
## DEFAULT -> 3.06 (OLS passes through the point of means)
d9_reg <- lm(colGPA ~ ACT + hsGPA, data = gpa1)             # <-- CHANGE
d9_b <- d9_reg$coefficients
ans("[D9] prediction at the means", d9_b[1] + d9_b[2] * mean(gpa1$ACT) + d9_b[3] * mean(gpa1$hsGPA))  # <-- CHANGE columns
ans("[D9] mean of y (same)", mean(gpa1$colGPA))             # <-- CHANGE column

## ======================================================================
## [D10] omitted-variable bias in data ----
## LOOKS LIKE: "Data: bwght. lm(bwght ~ cigs) slope?" / "add faminc: slope on cigs?"
##   / "regress faminc on cigs for delta1, compute b2*delta1"   (PS11 #12-14, PS10 #21)
## Order matters: simple = y ~ x1; multiple = y ~ x1 + x2 (left-out x2 SECOND); aux = x2 ~ x1
## DEFAULTS -> simple -0.51 | multiple -0.46 | b2 0.09 | delta1 -0.54 | b2*delta1 -0.05
d10_simple <- lm(bwght ~ cigs, data = bwght)                # <-- CHANGE y ~ x1
d10_multi  <- lm(bwght ~ cigs + faminc, data = bwght)       # <-- CHANGE y ~ x1 + x2
d10_aux    <- lm(faminc ~ cigs, data = bwght)               # <-- CHANGE x2 ~ x1
ans("[D10] simple slope on x1 (b1-tilde)", d10_simple$coefficients[2])
ans("[D10] multiple slope on x1 (b1-hat)", d10_multi$coefficients[2])
ans("[D10] b2-hat (x2 in multiple)", d10_multi$coefficients[3])
ans("[D10] delta1 (slope of x2 on x1)", d10_aux$coefficients[2])
ans("[D10] b2-hat * delta1", d10_multi$coefficients[3] * d10_aux$coefficients[2])
ans("[D10] check: simple - multiple", d10_simple$coefficients[2] - d10_multi$coefficients[2])

## ======================================================================
## [D11] perfect collinearity: R reports NA ----
## LOOKS LIKE: "vote1: totexpend <- expendA + expendB; lm(voteA ~ expendA + expendB +
##   totexpend). What does R report for totexpend?"   (PS11 #8)
## ANSWER: NA - R drops it because it's an exact linear function of the others (MLR.3 fails).
d11_v <- vote1; d11_v$totexpend <- d11_v$expendA + d11_v$expendB
print(coef(lm(voteA ~ expendA + expendB + totexpend, data = d11_v)))
pick("[D11] coefficient on the exact combination", "NA (dropped: perfect collinearity)")

## ======================================================================
## [D12] t-statistic and test from data (D21-D22) ----
## LOOKS LIKE: "Run lm(log(wage) ~ educ + exper + tenure). Test H0: b_exper = 0 vs
##   H1: b_exper > 0 at 5%."   (Example 4.1)
## DEFAULTS -> t 2.39 | c(one-sided 5%) 1.65 -> reject
d12_reg <- lm(log(wage) ~ educ + exper + tenure, data = wage1)   # <-- CHANGE
d12_var <- "exper"                                          # <-- CHANGE variable name (in quotes)
d12_h0 <- 0; d12_alpha <- 0.05                              # <-- CHANGE null value, alpha
d12_s <- summary(d12_reg)$coefficients
d12_t <- (d12_s[d12_var, "Estimate"] - d12_h0) / d12_s[d12_var, "Std. Error"]
d12_df <- d12_reg$df.residual
ans4("[D12] estimate", d12_s[d12_var, "Estimate"]); ans4("[D12] se", d12_s[d12_var, "Std. Error"])
ans("[D12] t = (b - h0)/se", d12_t); ans("[D12] df = n-k-1", d12_df)
ans("[D12] c one-sided = qt(1-a, df)", qt(1 - d12_alpha, d12_df))
ans("[D12] c two-sided = qt(1-a/2, df)", qt(1 - d12_alpha / 2, d12_df))
ans("[D12] p-value two-sided", 2 * pt(-abs(d12_t), d12_df))
pick("[D12] H1: b >  h0", ifelse(d12_t > qt(1 - d12_alpha, d12_df), "REJECT H0", "fail to reject"))
pick("[D12] H1: b <  h0", ifelse(d12_t < -qt(1 - d12_alpha, d12_df), "REJECT H0", "fail to reject"))
pick("[D12] H1: b != h0", ifelse(abs(d12_t) > qt(1 - d12_alpha / 2, d12_df), "REJECT H0", "fail to reject"))

## ======================================================================
## [D13] REG(): everything for one regression at once (coefs, se, t, p, CI, R^2, ----
##   SST/SSE/SSR, sigma-hat, prediction, change, residual of a row, t-test)
REG(log(wage) ~ educ + exper + tenure, data = wage1,          # <-- CHANGE formula, data
    at = list(educ = 16, exper = 4, tenure = 2),              # <-- CHANGE (or delete)
    from = list(educ = 12), to = list(educ = 13),             # <-- CHANGE (or delete)
    row = 2, test = "exper")                                  # <-- CHANGE (or delete)

# PART 2 - NUMBERS IN THE QUESTION ##########################################
cat("\n#################### PART 2 - NUMBERS IN THE QUESTION ####################\n")

## ######################################################################
## UNIVERSAL SOLVERS [S1]-[S7]: USE THESE WHEN THE QUESTION IS WORDED NEW
## Type EVERY number the question gives; leave the rest NA. Each solver
## fills in everything it can and prints ALL related answers, so a flipped
## direction or a merged step still lands on a printed line.
## TRIAGE every question (20 seconds):
##   1. ASKED: what number do they want? (sd? SSR? % change? residual?)
##   2. GIVEN: list the numbers they hand you.
##   3. CONNECT: FIND() or pick the solver that links given -> asked.
##   4. CHECK: correlation in [-1, 1]? % vs units? dollars from log(y) need exp()?
## ######################################################################

## ======================================================================
## [S1] SUMS-OF-SQUARES SOLVER: any of SST, SSE, SSR, R^2, n + S_y^2 ----
## LOOKS LIKE: "SSE = 135, R^2 = 0.18. Find SSR." / "SST = 241, SSR = 113. Find SSE."
##   / "n = 44, S_y^2 = 7. Find SST." / "What fraction is UNEXPLAINED?"   (Exam I Q24-25, PS6, PS8 #9-10)
## SSE = EXPLAINED, SSR = RESIDUAL (unexplained). DEFAULT (Exam I Q25) -> SSR 615.00
s1_SST <- NA; s1_SSE <- 135; s1_SSR <- NA; s1_R2 <- 0.18     # <-- CHANGE: given numbers, NA otherwise
s1_n <- NA; s1_S2y <- NA                                     # <-- CHANGE: n and sample variance of y, if given
for (s1_i in 1:4) {
  if (is.na(s1_SST) && !is.na(s1_n) && !is.na(s1_S2y)) s1_SST <- (s1_n - 1) * s1_S2y
  if (is.na(s1_SST) && !is.na(s1_SSE) && !is.na(s1_SSR)) s1_SST <- s1_SSE + s1_SSR
  if (is.na(s1_SST) && !is.na(s1_SSE) && !is.na(s1_R2))  s1_SST <- s1_SSE / s1_R2
  if (is.na(s1_SST) && !is.na(s1_SSR) && !is.na(s1_R2))  s1_SST <- s1_SSR / (1 - s1_R2)
  if (is.na(s1_SSE) && !is.na(s1_SST) && !is.na(s1_SSR)) s1_SSE <- s1_SST - s1_SSR
  if (is.na(s1_SSE) && !is.na(s1_SST) && !is.na(s1_R2))  s1_SSE <- s1_R2 * s1_SST
  if (is.na(s1_SSR) && !is.na(s1_SST) && !is.na(s1_SSE)) s1_SSR <- s1_SST - s1_SSE
  if (is.na(s1_R2)  && !is.na(s1_SST) && !is.na(s1_SSE)) s1_R2  <- s1_SSE / s1_SST
}
ans("[S1] SST (total)", s1_SST); ans("[S1] SSE (EXPLAINED)", s1_SSE); ans("[S1] SSR (RESIDUAL)", s1_SSR)
ans("[S1] R^2 (explained share)", s1_R2); ans("[S1] R^2 in percent", 100 * s1_R2)
ans("[S1] 1 - R^2 (UNEXPLAINED share)", 1 - s1_R2)
if (!is.na(s1_n)) ans("[S1] sample variance of y = SST/(n-1)", s1_SST / (s1_n - 1))

## ======================================================================
## [S2] VARIANCE / SD / SE SOLVER for the OLS slope ----
## Takes any mix of: sigma or sigma^2 (or SSR + n), and SST_x or raw x or S_X or S_X^2.
## LOOKS LIKE: "sigma = 20, n = 6, S_X^2 = 2: sd(b1)?" / "SSR = 437, n = 13, SST_X = 12: se?"
##   / "sigma-hat = 9.4, n = 23, S_X = 0.7: se?" / "sigma^2 = 66, SST = 53: Var?"   (PS9, PS10, Q8, Q9)
## DEFAULT (PS9 #16) -> se 1.82
s2_sigma  <- NA       # <-- CHANGE error sd (sigma or sigma-hat), if given
s2_sigma2 <- NA       # <-- CHANGE error variance (sigma^2 or sigma^2-hat), if given
s2_SSR <- 437         # <-- CHANGE SSR, if given (then sigma-hat^2 = SSR/(n-k-1))
s2_n   <- 13          # <-- CHANGE n
s2_k   <- 1           # <-- CHANGE number of slopes (1 = simple regression)
s2_SSTx <- 12         # <-- CHANGE SST_X, if given
s2_x   <- NULL        # <-- CHANGE OR raw x values, e.g. c(3,4,7,8,9)
s2_SX  <- NA          # <-- CHANGE OR sample SD of X (gets squared)
s2_SX2 <- NA          # <-- CHANGE OR sample VARIANCE of X
s2_Rj2 <- 0           # <-- CHANGE MLR only: R^2 of xj on the other x's
if (!is.null(s2_x)) { s2_SSTx <- sum((s2_x - mean(s2_x))^2); if (is.na(s2_n)) s2_n <- length(s2_x) }
if (is.na(s2_SSTx) && !is.na(s2_SX2)) s2_SSTx <- (s2_n - 1) * s2_SX2
if (is.na(s2_SSTx) && !is.na(s2_SX))  s2_SSTx <- (s2_n - 1) * s2_SX^2
if (is.na(s2_sigma2) && !is.na(s2_sigma)) s2_sigma2 <- s2_sigma^2
if (is.na(s2_sigma2) && !is.na(s2_SSR))   s2_sigma2 <- s2_SSR / (s2_n - s2_k - 1)
ans("[S2] df = n - k - 1", s2_n - s2_k - 1)
ans("[S2] sigma^2 (or sigma^2-hat)", s2_sigma2); ans("[S2] sigma (or sigma-hat)", sqrt(s2_sigma2))
ans("[S2] SST_X", s2_SSTx); ans("[S2] VIF = 1/(1-Rj^2)", 1 / (1 - s2_Rj2))
ans("[S2] Var(b1)", s2_sigma2 / (s2_SSTx * (1 - s2_Rj2)))
ans("[S2] sd(b1) = se(b1)", sqrt(s2_sigma2 / (s2_SSTx * (1 - s2_Rj2))))
ans("[S2] ...if sample k=2 times as large", sqrt(s2_sigma2 / (s2_SSTx * (1 - s2_Rj2))) / sqrt(2))

## ======================================================================
## [S3] UNITS SOLVER: rescale y and/or x in ANY of the 4 models -> new b0, b1 ----
## LOOKS LIKE: "slope 0.58; x divided by 1,000: new slope?" / "y times 1,000" /
##   "log(salary) = 3.36 + 0.44 log(sales); salary in dollars: new intercept?"  (PS8 #13-16, PS9 #1,#3, Q8 #1-2)
## R^2 NEVER changes. DEFAULT (PS9 #3) -> b0 10.27, b1 0.44
s3_model <- "log-log"   # <-- CHANGE "level-level", "log-level" (log y), "level-log" (log x), "log-log"
s3_b0 <- 3.36           # <-- CHANGE intercept (0 if not given)
s3_b1 <- 0.44           # <-- CHANGE slope
s3_cy <- 1000           # <-- CHANGE what y is MULTIPLIED by (1 = unchanged; $000s -> $: 1000)
s3_cx <- 1              # <-- CHANGE what x is MULTIPLIED by (divided by 1000 -> 1/1000)
s3_new <- switch(s3_model,
  "level-level" = c(s3_cy * s3_b0, s3_cy * s3_b1 / s3_cx),
  "log-level"   = c(s3_b0 + log(s3_cy), s3_b1 / s3_cx),
  "level-log"   = c(s3_cy * (s3_b0 - s3_b1 * log(s3_cx)), s3_cy * s3_b1),
  "log-log"     = c(s3_b0 + log(s3_cy) - s3_b1 * log(s3_cx), s3_b1))
ans("[S3] new intercept", s3_new[1]); ans("[S3] new slope", s3_new[2])
pick("[S3] what changed", paste(ifelse(abs(s3_new[1] - s3_b0) > 1e-9, "intercept CHANGES", "intercept same"),
                                ifelse(abs(s3_new[2] - s3_b1) > 1e-9, "slope CHANGES", "slope same"), "R^2 same", sep = "; "))

## ======================================================================
## [S4] LOG / PERCENT READER: prints the answer for ALL 4 models at once, so you only ----
## have to know WHERE the log is. Plus percent vs percentage points.
## LOOKS LIKE: any "by about what percent / how many units" question with logs (Table 2.3)
## DEFAULTS (b = 0.083): 0.08 | 8.30% | 0.01 units | 0.83%
s4_b <- 0.083           # <-- CHANGE slope
s4_dx <- 1              # <-- CHANGE change in x in UNITS (falls = negative)
s4_pctx <- 10           # <-- CHANGE change in x in PERCENT (falls = negative)
ans("[S4] y ~ x          dy (units)", s4_b * s4_dx)
ans("[S4] log(y) ~ x     %dy (100*b*dx)", 100 * s4_b * s4_dx)
ans("[S4] log(y) ~ x     %dy exact", 100 * (exp(s4_b * s4_dx) - 1))
ans("[S4] y ~ log(x)     dy units (b/100*%dx)", s4_b / 100 * s4_pctx)
ans("[S4] log(y)~log(x)  %dy (b*%dx)", s4_b * s4_pctx)
s4_old <- 5.6; s4_new <- 6.6                                # <-- CHANGE a rate before/after (percent vs points)
ans("[S4] percent change 100*(new-old)/old", 100 * (s4_new - s4_old) / s4_old)
ans("[S4] percentage-POINT change new - old", s4_new - s4_old)

## ======================================================================
## [S5] PROBABILITY SOLVER: moments, transforms, Var of sums, probability tables ----
## LOOKS LIKE: "E[X]=3, E[X^2]=27: sd of 3X-2?" / "Var(X)=8, Var(Y)=6, Cov=-2.9: Var(2X-2Y)?"
##   / "joint distribution below: Cor(X,Y)?" / "Y takes 6, 14, 34 w.p. .5 .3 .2: E[3Y+4]?"  (Exam I Q18-21, PS8 #3-5)
## DEFAULTS (Exam I): sd(3X-2) 12.73 | Var(2X-2Y) 79.20 | Cor -0.43 | E[3Y+4] 46.00
s5_EX <- 3; s5_EX2 <- 27; s5_VarX <- NA                     # <-- CHANGE: E[X] and E[X^2] (or Var(X) directly)
s5_a <- 3; s5_b <- -2                                       # <-- CHANGE: transform aX + b
if (is.na(s5_VarX)) s5_VarX <- s5_EX2 - s5_EX^2
ans("[S5] Var(X)", s5_VarX); ans("[S5] sd(X)", sqrt(s5_VarX))
ans("[S5] E[aX+b]", s5_a * s5_EX + s5_b); ans("[S5] Var(aX+b) = a^2 Var", s5_a^2 * s5_VarX)
ans("[S5] sd(aX+b) = |a| sd", abs(s5_a) * sqrt(s5_VarX))
s5_vx <- 8; s5_vy <- 6; s5_cov <- -2.9; s5_c1 <- 2; s5_c2 <- -2   # <-- CHANGE: Var(c1 X + c2 Y), minus goes INTO c2
ans("[S5] Var(c1X + c2Y)", s5_c1^2 * s5_vx + s5_c2^2 * s5_vy + 2 * s5_c1 * s5_c2 * s5_cov)
ans("[S5] Cor(X,Y) = Cov/(sdX sdY)", s5_cov / sqrt(s5_vx * s5_vy))
s5_x <- c(1, 4, 5, 6); s5_y <- c(4, 7, 4, 2); s5_p <- c(0.1, 0.4, 0.3, 0.2)   # <-- CHANGE a probability table
s5_EXt <- sum(s5_x * s5_p); s5_EYt <- sum(s5_y * s5_p)
s5_Vx <- sum(s5_x^2 * s5_p) - s5_EXt^2; s5_Vy <- sum(s5_y^2 * s5_p) - s5_EYt^2
s5_C <- sum(s5_x * s5_y * s5_p) - s5_EXt * s5_EYt
ans("[S5] table E[X]", s5_EXt); ans("[S5] table E[Y]", s5_EYt); ans("[S5] table E[XY]", sum(s5_x * s5_y * s5_p))
ans("[S5] table Var(X)", s5_Vx); ans("[S5] table Var(Y)", s5_Vy)
ans("[S5] table Cov(X,Y)", s5_C); ans("[S5] table Cor(X,Y)", s5_C / sqrt(s5_Vx * s5_Vy))
s5_v <- c(6, 14, 34); s5_pv <- c(0.5, 0.3, 0.2); s5_A <- 3; s5_B <- 4   # <-- CHANGE one-variable table, E[AY+B]
s5_E <- sum(s5_v * s5_pv)
ans("[S5] one-var E[Y]", s5_E); ans("[S5] one-var Var(Y)", sum(s5_v^2 * s5_pv) - s5_E^2)
ans("[S5] one-var E[AY+B]", s5_A * s5_E + s5_B)

## ======================================================================
## [S6] SMALL-SAMPLE OLS SOLVER: type x and y, get EVERYTHING ----
## LOOKS LIKE: "For x = (...), y = (...): slope? intercept? residual of obs 3? predict at x = 5?
##   sum x*uhat? R^2? sample sd/cov/cor?"   (Exam I Q16-17,22-23,28; PS5-PS6; PS8 #6,#8)
## DEFAULT (Exam I Q23) -> residual of obs 3 = 1.80
s6_x <- c(4, 6, 7, 8, 10)                                   # <-- CHANGE
s6_y <- c(4, 6, 7, 1, 8)                                    # <-- CHANGE
s6_i <- 3; s6_x0 <- 7                                       # <-- CHANGE observation number; x to predict at
s6_reg <- lm(s6_y ~ s6_x); s6_b <- s6_reg$coefficients
ans("[S6] mean x", mean(s6_x)); ans("[S6] mean y", mean(s6_y))
ans("[S6] sd x", sd(s6_x)); ans("[S6] sd y", sd(s6_y)); ans("[S6] var x", var(s6_x))
ans("[S6] cov(x,y)", cov(s6_x, s6_y)); ans("[S6] cor(x,y)", cor(s6_x, s6_y))
ans("[S6] slope b1", s6_b[2]); ans("[S6] intercept b0", s6_b[1])
ans("[S6] prediction at x0", s6_b[1] + s6_b[2] * s6_x0)
ans("[S6] fitted of obs i", s6_reg$fitted.values[s6_i]); ans("[S6] residual of obs i", s6_reg$residuals[s6_i])
ans("[S6] sum of residuals (always 0)", sum(s6_reg$residuals)); ans("[S6] sum x*uhat (always 0)", sum(s6_x * s6_reg$residuals))
ans("[S6] SST", sum((s6_y - mean(s6_y))^2)); ans("[S6] SSR", sum(s6_reg$residuals^2))
ans("[S6] SSE", sum((s6_reg$fitted.values - mean(s6_y))^2)); ans("[S6] R^2", summary(s6_reg)$r.squared)

## ======================================================================
## [S7] LINE SOLVER: given an equation, prints prediction, change, ybar, and log versions ----
## LOOKS LIKE: any "y-hat = b0 + b1 x1 + b2 x2 ..." question: predicted value / change /
##   sample mean of y / % change / predicted $ when y is logged    (Q9 #8-9, PS11 #1, #6)
## DEFAULTS (yhat = 4 + 2.9x1 - 0.6x2): pred at (1,2) 5.70 | change (1,-3) 4.70 | ybar at (5,2) 17.30
s7_b0 <- 4                                                  # <-- CHANGE intercept
s7_b  <- c(2.9, -0.6)                                       # <-- CHANGE slopes (keep signs)
s7_at <- c(1, 2)                                            # <-- CHANGE x VALUES (for a prediction)
s7_dx <- c(1, -3)                                           # <-- CHANGE x CHANGES (falls negative, fixed 0)
s7_xbar <- c(5, 2)                                          # <-- CHANGE x MEANS (for ybar), if given
s7_pred <- s7_b0 + sum(s7_b * s7_at); s7_chg <- sum(s7_b * s7_dx)
ans("[S7] prediction (keeps b0)", s7_pred); ans("[S7] change (no b0)", s7_chg)
ans("[S7] ybar = b0 + sum(b * xbar)", s7_b0 + sum(s7_b * s7_xbar))
ans("[S7] IF y is logged: % change = 100*chg", 100 * s7_chg)
ans("[S7] IF y is logged: prediction in $ = exp", exp(s7_pred))


## ======================================================================
## [U1] x multiplied or divided by c -> new slope ----
## LOOKS LIKE: "The OLS slope is 0.58. Every value of x is divided by 1,000. New slope?"
##   (PS8 #14, Q8 #2)   x DIVIDED by c -> slope TIMES c.  Intercept, R^2 unchanged.
## DEFAULT -> 580.00
u1_b1 <- 0.58                                               # <-- CHANGE slope
u1_c  <- 1/1000                                             # <-- CHANGE what x is MULTIPLIED by (divided by 1000 -> 1/1000)
ans("[U1] new slope = b1 / c", u1_b1 / u1_c)

## ======================================================================
## [U2] y multiplied by c -> new slope (and intercept) times c ----
## LOOKS LIKE: "The OLS slope is 2.48. Every value of y is multiplied by 1,000. New slope?" (PS8 #13)
## DEFAULT -> 2480.00
u2_b1 <- 2.48; u2_b0 <- 0                                   # <-- CHANGE slope (and intercept if asked)
u2_c  <- 1000                                               # <-- CHANGE what y is multiplied by
ans("[U2] new slope = c * b1", u2_c * u2_b1)
ans("[U2] new intercept = c * b0", u2_c * u2_b0)

## ======================================================================
## [U3] log(y) model, y rescaled -> slope same, intercept + log(c) ----
## LOOKS LIKE: "log(salary)-hat = 3.36 + 0.44 log(sales). Salary in dollars instead
##   (times 1000): new intercept?"  (PS9 #3)    DEFAULT -> 10.27
u3_b0 <- 3.36; u3_c <- 1000                                 # <-- CHANGE intercept, multiplier
ans("[U3] new intercept = b0 + log(c)", u3_b0 + log(u3_c))

## ======================================================================
## [L1] LOG-LEVEL (log on LEFT only): %dy = 100 * b1 * dx ----
## LOOKS LIKE: "log(y)-hat = 1.5 + 0.02x. By about what percent does y change when
##   x rises by 2?"  (PS8 #17, Q8 #3, Q9 #2)   DEFAULT -> 4.00
## Units trap (PS9 #2): x in MONTHS, asked per YEAR -> dx = 12.
l1_b1 <- 0.02                                               # <-- CHANGE slope
l1_dx <- 2                                                  # <-- CHANGE change in x (falls = negative)
ans("[L1] % change in y", 100 * l1_b1 * l1_dx)

## ======================================================================
## [L2] LOG-LOG (log on BOTH sides): %dy = b1 * %dx  (elasticity, no 100) ----
## LOOKS LIKE: "log(y)-hat = 3.5 + 1.22 log(x). By about what percent does y change when
##   x rises by 18%?"  (PS8 #18, PS9 #5, Q8 #4)   DEFAULT -> 21.96
l2_b1 <- 1.22                                               # <-- CHANGE slope
l2_pctx <- 18                                               # <-- CHANGE % change in x (falls = negative)
ans("[L2] % change in y", l2_b1 * l2_pctx)

## ======================================================================
## [L3] LEVEL-LOG (log on RIGHT only): dy = (b1/100) * %dx  (UNITS of y) ----
## LOOKS LIKE: "y-hat = 87 + 11.3 log(x). By about how many units does y change when
##   x rises by 13%?"  (PS8 #19, Q8 #5)   DEFAULT -> 1.47
l3_b1 <- 11.3                                               # <-- CHANGE slope
l3_pctx <- 13                                               # <-- CHANGE % change in x
ans("[L3] change in y (units)", l3_b1 / 100 * l3_pctx)

## ======================================================================
## [L4] LOG-LEVEL with several x's: %dy = 100 * (b1*dx1 + b2*dx2 + ...) ----
## LOOKS LIKE: "log(y)-hat = 2.4 + 0.015x1 - 0.037x2. If x1 rises by 3 and x2 rises by 4,
##   about what percent does y change?"  (PS11 #1)   DEFAULT -> -10.30
l4_b  <- c(0.015, -0.037)                                   # <-- CHANGE slopes (keep minus signs, NO intercept)
l4_dx <- c(3, 4)                                            # <-- CHANGE changes (falls = negative)
ans("[L4] % change in y", 100 * sum(l4_b * l4_dx))

## ======================================================================
## [M1] MLR PREDICTION (keep the intercept) ----
## LOOKS LIKE: "y-hat = 5 + 2.9x1 + 2.2x2. Predicted value at x1 = 13 and x2 = 12?" (Q9 #8)
## DEFAULT -> 69.10
m1_b0 <- 5                                                  # <-- CHANGE intercept
m1_b  <- c(2.9, 2.2)                                        # <-- CHANGE slopes (keep signs)
m1_x  <- c(13, 12)                                          # <-- CHANGE x values
ans("[M1] predicted y", m1_b0 + sum(m1_b * m1_x))

## ======================================================================
## [M2] MLR CHANGE (drop the intercept) ----
## LOOKS LIKE: "y-hat = 4 + 0.9x1 - 1.9x2. If x1 rises by 1 and x2 rises by 4, by how
##   much does y-hat change?"  (Q9 #9, Exam I Q14)   DEFAULT -> -6.70
m2_b  <- c(0.9, -1.9)                                       # <-- CHANGE slopes (keep signs)
m2_dx <- c(1, 4)                                            # <-- CHANGE changes (falls = negative, fixed = 0)
ans("[M2] change in y-hat", sum(m2_b * m2_dx))

## ======================================================================
## [M3] ybar from the line and the means (the line passes through the means) ----
## LOOKS LIKE: "y-hat = 3.6 + 0.8x1 - 1.2x2, x1bar = 4.6, x2bar = 2.9. What is ybar?"
##   (PS11 #6, PS8 #12, Exam I Q26)   DEFAULT -> 3.80
m3_b0 <- 3.6                                                # <-- CHANGE intercept
m3_b  <- c(0.8, -1.2)                                       # <-- CHANGE slopes (one per x)
m3_xbar <- c(4.6, 2.9)                                      # <-- CHANGE means of the x's
ans("[M3] ybar", m3_b0 + sum(m3_b * m3_xbar))

## ======================================================================
## [O1] OLS residual of ONE observation (small sample) ----
## LOOKS LIKE: "For x = (1,4,6,7,9), y = (2,1,6,5,3), regress y on x. Find the residual of
##   the third observation."  (PS8 #6, Q7 #7, Exam I Q23)   DEFAULT -> 2.40
o1_x <- c(1, 4, 6, 7, 9)                                    # <-- CHANGE x
o1_y <- c(2, 1, 6, 5, 3)                                    # <-- CHANGE y
o1_i <- 3                                                   # <-- CHANGE which observation
o1_reg <- lm(o1_y ~ o1_x)
ans("[O1] slope", o1_reg$coefficients[2]); ans("[O1] intercept", o1_reg$coefficients[1])
ans("[O1] residual of obs i", o1_reg$residuals[o1_i])

## ======================================================================
## [O2] missing residual (OLS residuals sum to 0) ----
## LOOKS LIKE: "Residuals -1.6, 2.4, -0.2, 0.7, 1.1, and one more. The sixth?" (PS8 #7, Q7 #8)
## DEFAULT -> -2.40
o2_known <- c(-1.6, 2.4, -0.2, 0.7, 1.1)                    # <-- CHANGE the known residuals
ans("[O2] missing residual", -sum(o2_known))

## ======================================================================
## [O3] sum of x_i * uhat_i  -> ALWAYS 0 (type 0) ----
## LOOKS LIKE: "For x = (...), y = (...), compute sum x_i uhat_i."  (PS8 #8, Q7 #3, Exam I Q28)
o3_x <- c(3, 6, 7, 9, 10, 15); o3_y <- c(12, 12, 8, 15, 8, 10)   # (optional check)
ans("[O3] sum(x * uhat)  (always 0)", sum(o3_x * lm(o3_y ~ o3_x)$residuals))

## ======================================================================
## [O4] SSR from SSE and R^2:  SST = SSE/R^2, SSR = SST - SSE ----
## LOOKS LIKE: "SSE = 53 and R^2 = 0.89. Find SSR."  (PS8 #9, Q7 #9)   DEFAULT -> 6.55
o4_SSE <- 53; o4_R2 <- 0.89                                 # <-- CHANGE
ans("[O4] SST = SSE/R^2", o4_SSE / o4_R2)
ans("[O4] SSR = SST - SSE", o4_SSE / o4_R2 - o4_SSE)

## ======================================================================
## [O5] SST from n and the sample variance:  SST = (n-1) * S_y^2 ----
## LOOKS LIKE: "n = 54 observations, sample variance S_y^2 = 20. Find SST." (PS8 #10, Q7 #10)
## DEFAULT -> 1060.00
o5_n <- 54; o5_S2 <- 20                                     # <-- CHANGE
ans("[O5] SST", (o5_n - 1) * o5_S2)

## ======================================================================
## [V1] Var(b1) = sigma^2 / SST_x ----
## LOOKS LIKE: "sigma^2 = 66 and SST_X = 53. Find Var(b1-hat)."  (PS9 #11)   DEFAULT -> 1.25
v1_sigma2 <- 66; v1_SST <- 53                               # <-- CHANGE (given sigma? type its square: 4^2)
ans("[V1] Var(b1)", v1_sigma2 / v1_SST)

## ======================================================================
## [V2] sd(b1) or se(b1) from sigma (or sigma-hat), n, and S_X or S_X^2 ----
## LOOKS LIKE: "sigma = 20, n = 6, sample variance S_X^2 = 2. Find sd(b1-hat)." (PS9 #12)
##   "n = 23, sigma-hat = 9.4, sample SD S_X = 0.7. Find se(b1-hat)." (Q9 #6, PS10 #7)
## SST_X = (n-1)*S_X^2. Given the SD S_X? set v2_is_var <- FALSE (it gets squared).
## DEFAULT -> 6.32   (Q9 #6 numbers -> 2.86)
v2_n <- 6                                                   # <-- CHANGE n
v2_sigma <- 20                                              # <-- CHANGE sigma or sigma-hat
v2_S <- 2                                                   # <-- CHANGE the S_X number given
v2_is_var <- TRUE                                           # <-- CHANGE TRUE if they gave S_X^2 (variance), FALSE if S_X (sd)
v2_SST <- (v2_n - 1) * if (v2_is_var) v2_S else v2_S^2
ans("[V2] SST_X", v2_SST)
ans("[V2] sd/se(b1) = sigma/sqrt(SST)", v2_sigma / sqrt(v2_SST))

## ======================================================================
## [V3] sd(b1) from sigma and the raw x values ----
## LOOKS LIKE: "sigma = 6. The five X values are x = (3,4,7,8,9). Find sd(b1-hat)."
##   (PS9 #14, Q8 #9)   DEFAULT -> 1.16
v3_sigma <- 6                                               # <-- CHANGE
v3_x <- c(3, 4, 7, 8, 9)                                    # <-- CHANGE
ans("[V3] SST_X", sum((v3_x - mean(v3_x))^2))
ans("[V3] sd(b1)", v3_sigma / sqrt(sum((v3_x - mean(v3_x))^2)))

## ======================================================================
## [V4] sigma^2-hat = SSR / (n - k - 1)   (simple regression: k = 1 -> n - 2) ----
## LOOKS LIKE: "Simple regression, n = 14, SSR = 268. Estimate of the error variance?"
##   (PS9 #15, Q8 #10)   DEFAULT -> 22.33
v4_SSR <- 268; v4_n <- 14; v4_k <- 1                        # <-- CHANGE (k = number of slopes)
ans("[V4] sigma^2-hat", v4_SSR / (v4_n - v4_k - 1))
ans("[V4] sigma-hat", sqrt(v4_SSR / (v4_n - v4_k - 1)))

## ======================================================================
## [V5] se(b1) from SSR, n and SST_x ----
## LOOKS LIKE: "n = 13, SSR = 437, SST_X = 12. Find se(b1-hat)."  (PS9 #16, Q8 #11)
## DEFAULT -> 1.82
v5_SSR <- 437; v5_n <- 13; v5_SST <- 12                     # <-- CHANGE
ans("[V5] sigma-hat", sqrt(v5_SSR / (v5_n - 2)))
ans("[V5] se(b1)", sqrt(v5_SSR / (v5_n - 2)) / sqrt(v5_SST))

## ======================================================================
## [V6] sd(b1) when the sample is k times as large: divide by sqrt(k) ----
## LOOKS LIKE: "sd(b1-hat) = 0.34. Sample 6 times as large (SST_X also 6x). New sd?"
##   (Q9 #7, PS10 #9)   DEFAULT -> 0.14     (sigma doubles -> multiply sd by 2)
v6_sd <- 0.34; v6_k <- 6                                    # <-- CHANGE
ans("[V6] new sd = sd/sqrt(k)", v6_sd / sqrt(v6_k))

## ======================================================================
## [V7] multiple regression: Var(bj) = sigma^2 / [SST_j (1 - Rj^2)],  VIF = 1/(1 - Rj^2) ----
v7_sigma2 <- 15; v7_SSTj <- 120; v7_Rj2 <- 0.6              # <-- CHANGE   DEFAULTS -> VIF 2.50, Var 0.31
ans("[V7] VIF", 1 / (1 - v7_Rj2)); ans("[V7] Var(bj)", v7_sigma2 / (v7_SSTj * (1 - v7_Rj2)))
ans("[V7] sd(bj)", sqrt(v7_sigma2 / (v7_SSTj * (1 - v7_Rj2))))

## ======================================================================
## [B1] OVB formula (3.23): b1tilde = b1hat + b2hat * delta1. Put NA on the one asked. ----
## LOOKS LIKE: "Simple regression gives b1tilde = -0.36. Multiple gives b2hat = -1.18,
##   slope of X2 on X1 is delta1 = -0.51. Find b1hat."  (PS11 #11, PS10 #18)  DEFAULT -> -0.96
b1_b1tilde <- -0.36                                         # <-- CHANGE simple slope (NA if asked)
b1_b1hat   <- NA                                            # <-- CHANGE multiple slope on x1 (NA if asked)
b1_b2hat   <- -1.18                                         # <-- CHANGE coef on x2 (NA if asked)
b1_delta1  <- -0.51                                         # <-- CHANGE slope of x2 on x1 (NA if asked)
if (is.na(b1_b1hat))   ans("[B1] b1hat", b1_b1tilde - b1_b2hat * b1_delta1)
if (is.na(b1_b1tilde)) ans("[B1] b1tilde", b1_b1hat + b1_b2hat * b1_delta1)
if (is.na(b1_b2hat))   ans("[B1] b2hat", (b1_b1tilde - b1_b1hat) / b1_delta1)
if (is.na(b1_delta1))  ans("[B1] delta1", (b1_b1tilde - b1_b1hat) / b1_b2hat)

## ======================================================================
## [B2] Bias(b1tilde) = beta2 * delta1 ----
## LOOKS LIKE: "beta2 = -1.17. Omit X2; slope of X2 on X1 is delta1 = -0.26. Bias?"
##   (PS10 #19)   DEFAULT -> 0.30  (positive = biased upward)
b2_beta2 <- -1.17; b2_delta1 <- -0.26                       # <-- CHANGE
ans("[B2] bias = beta2*delta1", b2_beta2 * b2_delta1)

## ======================================================================
## [B3] DIRECTION of bias (Table 3.2): sign(beta2) x sign(corr(x1, x2)) ----
## LOOKS LIKE: "An omitted X2 lowers Y and is negatively correlated with X1. The simple
##   slope is..." / fertilizer & land quality / tutoring & ability  (PS11 #16-18, PS10 #20)
## Same signs -> UPWARD (overstates). Opposite -> DOWNWARD (understates).
b3_b2 <- -1                                                 # <-- CHANGE +1 if omitted x2 RAISES y, -1 if it lowers y
b3_corr <- -1                                               # <-- CHANGE +1 if x2 moves WITH x1, -1 if opposite
pick("[B3] bias", ifelse(b3_b2 * b3_corr > 0, "UPWARD (overstates the effect)", "DOWNWARD (understates the effect)"))

## ======================================================================
## [P1] sd(aX + b) from E[X] and E[X^2]:  Var = E[X^2] - E[X]^2, sd(aX+b) = |a|*sd(X) ----
## LOOKS LIKE: "E[X] = 4 and E[X^2] = 20. Find the sd of 3X - 4."  (PS8 #3, Q7 #4)  DEFAULT -> 6.00
p1_EX <- 4; p1_EX2 <- 20; p1_a <- 3                         # <-- CHANGE (b doesn't matter)
ans("[P1] sd(aX + b)", abs(p1_a) * sqrt(p1_EX2 - p1_EX^2))

## ======================================================================
## [P2] Var(aX + bY) = a^2 VarX + b^2 VarY + 2ab Cov   (the minus sign goes INTO b) ----
## LOOKS LIKE: "Var(X) = 4, Var(Y) = 3, Cov = -1.9. Find Var(2X - 3Y)." (PS8 #4, Q7 #5) DEFAULT -> 65.80
p2_vx <- 4; p2_vy <- 3; p2_cov <- -1.9; p2_a <- 2; p2_b <- -3   # <-- CHANGE
ans("[P2] Var(aX + bY)", p2_a^2 * p2_vx + p2_b^2 * p2_vy + 2 * p2_a * p2_b * p2_cov)

## ======================================================================
## [P3] correlation from a JOINT PROBABILITY table (weight by p; never cor()) ----
## LOOKS LIKE: "X and Y have the joint distribution below. Find Cor(X, Y)." (PS8 #5, Q7 #6)
## DEFAULT -> -0.59
p3_x <- c(1, 5, 7, 8)                                       # <-- CHANGE x column
p3_y <- c(3, 3, 1, 3)                                       # <-- CHANGE y column
p3_p <- c(0.2, 0.3, 0.4, 0.1)                               # <-- CHANGE probability column
p3_EX <- sum(p3_x * p3_p); p3_EY <- sum(p3_y * p3_p)
p3_cov <- sum(p3_x * p3_y * p3_p) - p3_EX * p3_EY
ans("[P3] Cov(X,Y)", p3_cov)
ans("[P3] Cor(X,Y)", p3_cov / sqrt((sum(p3_x^2 * p3_p) - p3_EX^2) * (sum(p3_y^2 * p3_p) - p3_EY^2)))

## ======================================================================
## [T1] t-statistic from an estimate and se; critical values; p-values; decisions ----
## LOOKS LIKE: "b-hat = 0.54, se = 0.05. t?" / "H0: b = 0 vs H1: b > 0 at 5%, df = 522"
## t = (b - h0)/se. One-sided c = qt(1 - a, df). Two-sided c = qt(1 - a/2, df).
## DEFAULT -> t 10.80
t1_b <- 0.54; t1_se <- 0.05; t1_h0 <- 0                     # <-- CHANGE estimate, se, null value
t1_df <- 522; t1_alpha <- 0.05                              # <-- CHANGE df = n - k - 1, alpha
t1_t <- (t1_b - t1_h0) / t1_se
ans("[T1] t", t1_t)
ans("[T1] c one-sided", qt(1 - t1_alpha, t1_df)); ans("[T1] c two-sided", qt(1 - t1_alpha / 2, t1_df))
ans("[T1] p two-sided", 2 * pt(-abs(t1_t), t1_df)); ans("[T1] p one-sided (H1: b > h0)", pt(t1_t, t1_df, lower.tail = FALSE))
pick("[T1] H1: b >  h0 (reject if t > c)", ifelse(t1_t > qt(1 - t1_alpha, t1_df), "REJECT H0", "fail to reject"))
pick("[T1] H1: b <  h0 (reject if t < -c)", ifelse(t1_t < -qt(1 - t1_alpha, t1_df), "REJECT H0", "fail to reject"))
pick("[T1] H1: b != h0 (reject if |t| > c)", ifelse(abs(t1_t) > qt(1 - t1_alpha / 2, t1_df), "REJECT H0", "fail to reject"))

## ======================================================================
## [T2] decision from a GIVEN t and critical value c, or from a p-value ----
## LOOKS LIKE: "H0: b = 0 vs H1: b > 0, c = 1.68. t = 2.4: reject?" / "p = 0.03 at 5%?"
t2_t <- 2.4; t2_c <- 1.68                                   # <-- CHANGE
pick("[T2] H1: b >  0", ifelse(t2_t > t2_c, "REJECT H0", "fail to reject"))
pick("[T2] H1: b <  0", ifelse(t2_t < -t2_c, "REJECT H0", "fail to reject"))
pick("[T2] H1: b != 0", ifelse(abs(t2_t) > t2_c, "REJECT H0", "fail to reject"))
t2_p <- 0.03                                                # <-- CHANGE p-value
for (a in c(0.10, 0.05, 0.01)) pick(sprintf("[T2] p = %g at alpha %g", t2_p, a), ifelse(t2_p < a, "REJECT H0", "fail to reject"))

## [T3] confidence interval: b +/- c*se. a inside -> fail to reject H0: b = a. ----
t3_b <- 0.30; t3_se <- 0.10; t3_c <- 1.96                   # <-- CHANGE   DEFAULT -> [0.10, 0.50]
ans("[T3] CI lower", t3_b - t3_c * t3_se); ans("[T3] CI upper", t3_b + t3_c * t3_se)

## [T4] F = ((SSR_r - SSR_ur)/q) / (SSR_ur/(n-k-1)) ----
t4_SSRr <- 198.311; t4_SSRur <- 183.186; t4_q <- 3; t4_n <- 353; t4_k <- 5   # <-- CHANGE  DEFAULT -> 9.55
ans("[T4] F", ((t4_SSRr - t4_SSRur) / t4_q) / (t4_SSRur / (t4_n - t4_k - 1)))

# PART 3 - MULTIPLE CHOICE ##################################################
cat("\n#################### PART 3 - MULTIPLE CHOICE ####################\n")
## Find the [K] whose LOOKS LIKE matches; the PICK line is the answer to click.

## [K1] "Four candidate lines... sum u, sum |u|, sum u^2. Which is OLS?" (PS8 #2, Q7 #2) ----
pick("[K1] OLS line", "the one with sum(u) = 0 AND the SMALLEST sum(u^2)")
## [K2] "...X is part of U. Workers with more motivation take more training / richer ----
##   districts have smaller classes / more fertilizer on better land. Which is correct?"
pick("[K2] zero conditional mean", "FAILS: the average of U changes with x (something in U is correlated with x)")
## [K3] "Which is most likely to contribute omitted-variable bias?" (PS9 #9, Q8 #7) ----
pick("[K3] OVB candidate", "the one that AFFECTS y AND is RELATED to x (ability; family income). Not IDs/random/weather")
## [K4] "Theorem 2.1 / 1,000 researchers... unbiased means?" (PS9 #8, Q9 #4) ----
pick("[K4] unbiased", "AVERAGED over many samples, b-hat = b (not every sample)")
## [K5] "Every worker has exactly 12 years of education. What goes wrong?" (PS9 #10) ----
pick("[K5] no variation in x", "SLR3 fails: x values all the same, slope can't be computed")
## [K6] "Spread of food spending around the line grows with income." (PS9 #17) ----
pick("[K6] heteroskedasticity", "SLR5 fails: Var formula no longer applies; OLS still UNBIASED")
## [K7] "Which change makes Var(b1-hat) smaller / larger?" (PS9 #13, Q8 #8, Q9 #5) ----
pick("[K7] SMALLER Var", "smaller sigma^2, larger sample, MORE spread-out x (bigger SST_X)")
pick("[K7] LARGER Var", "larger sigma^2, smaller sample, x bunched together. NOT b0 or b1")
## [K8] units questions (PS8 #15, PS9 #1, Q8 #1) ----
pick("[K8] x times 10 (level model)", "slope DIVIDED by 10, intercept same, R^2 same")
pick("[K8] log(y), y in $ not $000s", "b1 does NOT change; only b0 changes (by log(1000))")
pick("[K8] log-log, x times 1000", "b1 does NOT change; only b0 changes")
## [K9] "What does the 0.45 / 20 / 8 mean?" (PS8 #20, Q9 #1, PS10 #1) ----
pick("[K9] log-log  log(y) ~ log(x)", "1% rise in x -> about b% change in y (elasticity)")
pick("[K9] level-log  y ~ log(x)", "1% rise in x -> about b/100 UNITS of y (20 -> 0.20 units)")
pick("[K9] log-level  log(y) ~ x", "1 unit rise in x -> about 100*b % change in y")
## [K10] "After OLS multiple regression, which are always true? Select all" (PS11 #4) ----
pick("[K10] TRUE (3)", "passes through the means; residuals average 0; cov(each Xj, residuals) = 0")
pick("[K10] FALSE", "cov(Y, residuals) = 0; every residual 0 in big samples")
## [K11] "Which violate MLR3 (no perfect collinearity)? Select all" (PS11 #7) ----
pick("[K11] VIOLATE", "more x's than observations; x3 = x1 + x2 exactly; same variable in 2 units")
pick("[K11] FINE", "highly but NOT perfectly correlated x's")
## [K12] "Which makes MLR4 fail / X endogenous?" (PS11 #9) ----
pick("[K12] MLR4 fails", "a variable that affects Y AND is correlated with X1 is left out (or wrong functional form)")
## [K13] "Why not add every variable we can find?" (PS11 #10) ----
pick("[K13] too many variables", "can INCREASE the variance of the estimates and can even violate MLR3")
## [K14] "cigs slope -0.51 simple, -0.46 holding income fixed. Which reading?" (PS11 #15) ----
pick("[K14] simple vs multiple", "-0.46 = smoking's effect holding income fixed; the other -0.05 is income riding along")
## [K15] "When does omitting X2 cause NO bias? Select all" (PS11 #19) ----
pick("[K15] no bias when", "beta2 = 0 (X2 has no effect on Y)  OR  X2 uncorrelated with X1")
## [K16] assumptions and testing ----
pick("[K16] MLR.1-4", "UNBIASED.   MLR.1-5 (Gauss-Markov) -> BLUE.   MLR.6 normal errors -> t-tests exact")
pick("[K16] t-stat", "(b-hat - a)/se: how many se's the estimate is from the null value")
pick("[K16] one-sided >", "reject H0 if t > c;  two-sided: reject if |t| > c")
pick("[K16] p-value", "reject H0 if p < alpha; small p = evidence AGAINST H0")
pick("[K16] high corr (not perfect)", "allowed; just raises Var(bj) (multicollinearity)")

## [K17] SCENARIO BANK: the exam re-tells the same idea with new stories. Match the PATTERN. ----
## OVB direction = sign(omitted affects y) x sign(omitted moves with x). Same -> UP, opposite -> DOWN.
pick("[K17] ability, wage ~ educ", "ability raises wage (+), more able get more educ (+) -> UP")
pick("[K17] land quality, yield ~ fertilizer", "(+) yield, more fertilizer on good land (+) -> UP")
pick("[K17] motivation, wage ~ training", "(+) wage, motivated take more training (+) -> UP")
pick("[K17] family income, score ~ class size", "(+) score, richer -> SMALLER classes (-) -> DOWN")
pick("[K17] prior ability, score ~ tutoring", "(+) score, low-ability take MORE tutoring (-) -> DOWN")
pick("[K17] exper, wage ~ educ (wage1)", "(+) wage, more educ -> less exper (-) -> DOWN (0.54 < 0.64)")
pick("[K17] hsGPA, colGPA ~ ACT (gpa1)", "(+) colGPA, corr with ACT (+) -> UP (0.027 > 0.009)")
pick("[K17] family income, bwght ~ cigs", "(+) bwght, smokers have lower income (-) -> DOWN (more negative)")
pick("[K17] city size, crime ~ police", "correlation, not causation: big cities have more of both")
## ZERO CONDITIONAL MEAN (MLR.4) story: "Z is part of U and Z moves with X" -> FAILS (X endogenous).
## "Z is part of U but unrelated to X" (weather, random ID) -> still holds.
