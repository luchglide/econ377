# =======================================================================
# BEFORE YOU START: DO THESE 3 THINGS ONCE (with internet)
# =======================================================================
#  1. Open setup_rstudio.R (same folder) and press Source. It installs the
#     packages, turns on RStudio's typo checks + rainbow parentheses, and adds
#     "Exam II" (NUMS, ASK) to the Addins menu. Then quit and reopen RStudio.
#     (asked "install from sources?" -> type no.  "personal library?" -> yes)
#     No setup_rstudio.R? Paste this in the Console instead:
#        install.packages(c("wooldridge", "rstudioapi", "datapasta"))
#
#  2. Check it worked. Paste this in the Console:
#        library(wooldridge); nrow(wage1)
#     It should print  [1] 526
#
#  0. Get the files: github.com/luchglide/econ377 -> green Code button ->
#     Download ZIP -> unzip -> open exam2.R from that folder.
#
#  3. Run the whole file: Cmd+Shift+Enter (Windows: Ctrl+Shift+Enter) or the
#     Source button. It finds its own folder, installs anything missing, and
#     prints a SETUP CHECK box: every line should say OK.
#
#  What the 2 packages do:
#    wooldridge = the course datasets (wage1, ceosal1, ...). If it won't
#                 install, the script uses the copies in data/ instead.
#    rstudioapi = lets FIND() jump your cursor to the right block.
#                 Optional: without it FIND() just prints the line number.
#    datapasta  = Addins > "Paste as vector": a copied list becomes c(...).
#
#  COPY THE QUESTION FIRST (Cmd+C / Ctrl+C), then in the Console:
#    ASK()   -> jumps to the right block; you edit the lines marked CHANGE.
#    NUMS()  -> lists every number in the question, labelled, lists as c(...).
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
#   4. RUN THE WHOLE BLOCK: click anywhere inside it and press
#        Mac: Cmd+Option+T      Windows: Ctrl+Alt+T     ("Run Current Section")
#      Never highlight just a few lines: the CHANGE lines must run too.
#      If the output shows the block's DEFAULTS numbers, your edits didn't run.
#   5. Read the ">>> ANSWER" line whose LABEL matches the question's wording.
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
#  Way 1 (fastest): run this whole file once (Cmd/Ctrl+Shift+Enter). Then
#        highlight the WHOLE question in Canvas, Cmd+C (Mac) / Ctrl+C (Windows), type ASK() in the
#        Console. It finds the block and JUMPS your cursor there. ASK() does NOT
#        solve it: you type the question's numbers into the # <-- CHANGE lines.
#        Or paste it inside QUOTES: ASK("...the whole question...")
#        (no quotes = "unexpected input" error). Type ASK in the CONSOLE, not here.
#        SHORTHAND works too: say what they GAVE and what they WANT, e.g.
#          ASK("gave SSE and R2, want SSR")      ASK("data hprice1 log price on log sqrft")
#          ASK("given sigma, n, S_x, want se")   ASK("omitted var raises y, corr with x negative, bias?")
#        Or type a few words yourself: FIND("SSE R2 find SSR"). Not it? GO("S2").
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
# Press Source (Cmd+Shift+S / Ctrl+Shift+S) or Cmd/Ctrl+Shift+Enter. This part:
#   1. points R at this script's folder (so data/ is found), no menu clicks needed
#   2. installs any missing package into a folder you can write to (lab PCs often
#      block the shared one), without asking you any questions
#   3. turns on RStudio's typo checks (yellow mark on a misspelled name)
#   4. prints a SETUP CHECK box. Every line should say OK / found.
# Packages: wooldridge (datasets; data/ CSV copies are used if it can't install),
#   rstudioapi (FIND()/GO() jump to blocks), datapasta (Addins > Paste as vector).
# No internet? It skips the installs and uses data/. Run it once at home AND once
#   on the lab PC before the exam starts, while you still have internet.
.setup <- local({
  here <- tryCatch(dirname(normalizePath(sys.frame(1)$ofile)), error = function(e) "")      # folder of this file
  if (!nzchar(here) && exists(".rs.api.getSourceEditorContext"))
    here <- tryCatch(dirname(get(".rs.api.getSourceEditorContext")()$path), error = function(e) "")
  if (nzchar(here) && dir.exists(here)) setwd(here)
  lib <- path.expand(Sys.getenv("R_LIBS_USER"))                                             # a library we can write to
  if (nzchar(lib)) dir.create(lib, recursive = TRUE, showWarnings = FALSE)
  if (!nzchar(lib) || file.access(lib, 2) != 0) { lib <- file.path(getwd(), "Rlib"); dir.create(lib, showWarnings = FALSE) }
  .libPaths(unique(c(lib, .libPaths())))
  options(repos = c(CRAN = "https://cloud.r-project.org"), install.packages.compile.from.source = "never", timeout = max(60, getOption("timeout")))
  pk <- c("wooldridge", "rstudioapi", "datapasta"); need <- pk[!vapply(pk, requireNamespace, TRUE, quietly = TRUE)]
  online <- length(need) && !inherits(try(suppressWarnings(readLines(url("https://cloud.r-project.org/"), n = 1)), silent = TRUE), "try-error")
  if (online) {
    cat("Installing:", paste(need, collapse = ", "), "(one time, about a minute) ...\n")
    suppressWarnings(try(install.packages(need, lib = lib, quiet = TRUE,
                                          type = if (.Platform$pkgType != "source") "binary" else "source"), silent = TRUE))
    if (!requireNamespace("wooldridge", quietly = TRUE))                                      # older R: the archived version
      suppressWarnings(try(install.packages("https://cloud.r-project.org/src/contrib/Archive/wooldridge/wooldridge_1.4-3.tar.gz",
                                            lib = lib, repos = NULL, type = "source", quiet = TRUE), silent = TRUE)) }
  prefs <- c("show_diagnostics_r", "background_diagnostics", "warn_if_no_such_variable_in_scope",
             "check_arguments_to_r_function_calls", "rainbow_parentheses", "highlight_selected_word")
  rs <- requireNamespace("rstudioapi", quietly = TRUE) && isTRUE(tryCatch(rstudioapi::isAvailable(), error = function(e) FALSE))
  if (rs) for (n in prefs) try(rstudioapi::writeRStudioPreference(n, TRUE), silent = TRUE)
  list(here = here, lib = lib, need = need, online = online, rs = rs)
})
.pk_ok <- function(p) requireNamespace(p, quietly = TRUE)
cat("\n---- SETUP CHECK ----\n")
cat(sprintf("  working folder     : %s\n", if (dir.exists("data")) paste("OK", getwd()) else paste("data/ not here:", getwd())))
cat(sprintf("  wooldridge package : %s\n", if (.pk_ok("wooldridge")) "OK" else if (dir.exists("data")) "not installed -> using data/ CSV copies (fine)" else "NOT installed"))
cat(sprintf("  rstudioapi package : %s\n", if (.pk_ok("rstudioapi")) "OK (FIND jumps to blocks)" else "not installed -> FIND prints line numbers (fine)"))
cat(sprintf("  datapasta package  : %s\n", if (.pk_ok("datapasta")) "OK (Addins > Paste as vector; restart RStudio once to see it)" else "not installed (optional)"))
cat(sprintf("  typo checks        : %s\n", if (.setup$rs) "ON" else "only inside RStudio"))
if (length(.setup$need) && !.setup$online) cat("  (no internet: nothing was installed. That's fine if the lines above say OK or data/.)\n")
if (!.pk_ok("wooldridge") && !dir.exists("data"))
  cat("  !! No datasets: Session > Set Working Directory > To Source File Location, then run again.\n")
cat("  RUN THE WHOLE FILE (Ctrl+Shift+Enter or the Source button), never pieces of it.\n")
cat("---------------------\n")
ans  <- function(label, x) cat(sprintf(">>> ANSWER %-50s -> %s\n", label, format(round(unname(x), 2), nsmall = 2)))
ans4 <- function(label, x) cat(sprintf(">>> ANSWER %-50s -> %s\n", label, format(round(unname(x), 4), nsmall = 4)))
pick <- function(label, x) cat(sprintf(">>> PICK   %-50s -> %s\n", label, x))
fit  <- function(formula, dname) {                                    # lm() with a plain-English check
  d <- get(dname); bad <- setdiff(all.vars(formula), names(d))
  if (length(bad)) stop(sprintf("\n  '%s' is not a column of %s.\n  The formula uses COLUMN names only: y ~ x1 + x2 (e.g. price ~ sqrft + bdrms), never the dataset name.\n  Columns in %s: %s",
                                bad[1], dname, dname, paste(head(names(d), 20), collapse = ", ")), call. = FALSE)
  lm(formula, data = d) }
nx   <- function(v, xn, what) if (length(v) != length(xn)) stop(sprintf("\n  %s needs ONE number per x, in formula order: %s (%d numbers). You typed %d.",
                                what, paste(xn, collapse = ", "), length(xn), length(v)), call. = FALSE)
same_len <- function(a, b, an, bn) if (!all(is.na(b)) && length(a) != length(b))
  info(sprintf("!! WARNING: %d numbers in %s but %d in %s.", length(a), an, length(b), bn), "Typed a comma instead of a decimal point? 0,02 must be 0.02")
blk  <- function(tag, what) cat(sprintf("\n==== [%s] %s ====\n", tag, what))     # heading printed when a block runs
info <- function(label, x) cat(sprintf("    %-45s %s\n", label, x))
part <- function(t) cat(sprintf("  ---- %s ----\n", t))                 # sub-heading inside a block
fx <- function(a, b, v = "X") {                                        # writes aX + b as it would appear in a question
  a_s <- if (a == 1) v else if (a == -1) paste0("-", v) else paste0(format(a), v)
  if (b == 0) a_s else paste0(a_s, if (b > 0) " + " else " - ", format(abs(b))) }
get_data <- function(name) {
  if (requireNamespace("wooldridge", quietly = TRUE)) {
    e <- new.env(); data(list = name, package = "wooldridge", envir = e); get(name, e)
  } else read.csv(file.path("data", paste0(name, ".csv")))
}
## Loads every dataset the course has used (all have offline copies in data/).
for (d in c("wage1", "wage2", "ceosal1", "ceosal2", "bwght", "gpa1", "gpa2", "vote1", "campus", "rdchem",
            "mlb1", "meap93", "hprice1", "k401k", "discrim", "attend", "crime1", "sleep75", "lawsch85", "jtrain",
            "charity", "hprice2", "htv"))
  assign(d, get_data(d))
## Any other dataset: name <- get_data("name")  (needs the wooldridge package if no CSV)

## ---- FIND(): type words from the question, get the block tag -----------------
CATALOG <- list(
  c("S1",  "SOLVER sums of squares: any of SST, SSE, SSR, R^2, n + S_y^2", "sst sse ssr r2 r-squared explained unexplained fraction total sum squares residual sample variance n observations adjusted adj"),
  c("S2",  "SOLVER Var/sd/se of the slope from any mix of sigma, SSR, n, SST_x, x, S_X", "variance sd se standard error standard deviation sigma ssr sst_x sample variance x n observations var(b1 vif"),
  c("S3",  "SOLVER units: rescale y and/or x in any of the 4 log models", "units measured instead multiplied divided 1000 100 dollars thousands percent decimal new slope intercept log-log log-level level-log"),
  c("S4",  "SOLVER logs: prints the answer for all 4 log models + percent vs points", "log log-log log-level level-log percent units elasticity percentage points rises falls about"),
  c("S5",  "SOLVER probability: E[X], Var, sd(aX+b), Var(aX+bY), tables, Cor", "e[x] e[x^2] expected var(x) var(y) cov(x,y) sd(ax+b) joint distribution probability table cor(x,y) takes values with probabilities"),
  c("S6",  "SOLVER small sample: type x and y, get slope, intercept, residuals, R^2, cor ...", "sample x= y= regress by hand slope intercept residual observation predict sum sample standard deviation covariance correlation"),
  c("S7",  "SOLVER equation: prediction, change, ybar, % change, exp() for logged y", "yhat equation predicted value change rises falls sample mean ybar means intercept percent dollars"),
  c("D0",  "Data: n, mean, sd, correlation of columns", "data how many sample n rows mean average correlation cor sd standard deviation columns min max minimum maximum largest smallest median fraction share proportion women dummy covariance variance"),
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
  c("D14", "Data: se of a multiple-regression coefficient by hand (sigma-hat, SST_j, R_j^2)", "data standard error by hand coefficient sigma-hat sst_j r_j^2 r2_j degrees of freedom df residual standard error other independent variables multiple"),
  c("K18", "MC: pieces of se(b_j): x_j, R_j^2 regression, sigma-hat, multicollinearity, NA rows", "x_j r_j^2 which regression gives sigma-hat estimate standard deviation of the error residual standard error matches missing values na grows without bound"),
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
  c("T1",  "t-statistic, critical values, p-values, decisions", "t statistic se estimate reject critical value alpha df h0 h1 one-sided two-sided p-value degrees of freedom df n-k-1 critical value given"),
  c("T2",  "decision from a given t and c, or a p-value", "given t critical value reject fail p-value alpha"),
  c("T3",  "confidence interval", "confidence interval ci 95 lower upper"),
  c("T4",  "F-statistic", "f statistic joint restricted unrestricted"),
  c("K1",  "MC: which candidate line is OLS (sum u, sum |u|, sum u^2)", "candidate lines four ols line sum residuals absolute squared"),
  c("K2",  "MC: zero conditional mean / MLR.4 holds or fails (something in U moves with x)", "part of u zero conditional mean e[u assumption fails holds endogenous exogenous tend to"),
  c("K3",  "MC: which variable causes omitted-variable bias", "most likely contribute omitted-variable bias ability family income id random"),
  c("K4",  "MC: what unbiased means", "unbiased theorem 2.1 e[b1 averaged many samples researchers"),
  c("K5",  "MC: x has no variation (SLR.3)", "every worker exactly same value goes wrong no variation"),
  c("K6",  "MC: heteroskedasticity (spread grows with x)", "spread grows heteroskedasticity homoskedasticity slr5 mlr5 var(u|x) fans out spread variance of the error grows"),
  c("K7",  "MC: what makes Var / se of b1 larger or smaller", "makes var larger smaller se spread out bunched sample error variance correlated other regressors"),
  c("K8",  "MC: what happens to b0, b1, R^2 when units change", "multiplied measured instead happens slope intercept r2 divided units cents months"),
  c("K9",  "MC: what does the slope mean in a log model", "what does mean 1% rise associated log elasticity interpretation constant elasticity constant percentage functional form interpret"),
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
  cat("  Edit the # <-- CHANGE lines, then run the WHOLE block: Cmd+Option+T (Mac) / Ctrl+Alt+T (Win)\n")
  invisible(n)
}
## ---- matcher used by FIND() and ASK(): keywords + similarity to real past questions
##      + "question shape" rules (dataset named? log( where? x = (...) list? sigma? H0?)
.norm <- function(s) {                                   # Greek / Canvas symbols -> words
  s <- paste(s, collapse = " ")
  sub <- list(c("\u2080", "0"), c("\u2081", "1"), c("\u2082", "2"), c("\u2083", "3"), c("\u2c7c", "j"), c("\u2096", "k"))
  for (p in sub) s <- gsub(p[1], p[2], s, fixed = TRUE, useBytes = TRUE)
  s <- gsub("\\(\\s*_([0-9jk])\\s*\\)", " b\\1 ", s)            # Canvas copy: ( _1 ) -> b1
  s <- gsub("\\(\\s*_\\s*\\)\\s*\\^?\\s*2", " sigma^2 ", s)                # Canvas copy: ( _ )^2 -> sigma^2
  rep <- list(c("\u03b2\u0302", " beta hat "), c("\u03b2\u0303", " beta tilde "), c("\u03b4\u0303", " delta tilde "),
           c("\u03c3\u0302", " sigma hat "), c("\u03b2", " beta "), c("\u03b4", " delta "), c("\u03c3", " sigma "),
           c("\u00b2", "^2"), c("\u00fb", " uhat "), c("\u0177", " yhat "), c("\u2212", "-"), c("\u00b7", " * "),
           c("\u2260", " != "), c("\u03a3", " sum "), c("\u0302", " hat "), c("\u0303", " tilde "), c("\u2265", ">="), c("\u2264", "<="))
  for (p in rep) s <- gsub(p[1], p[2], s, fixed = TRUE, useBytes = TRUE)
  s <- gsub("[^ -~]", " ", s, useBytes = TRUE)                  # any other symbol -> space (works in every locale)
  s <- gsub("\\(\\s*\\)", " ", s)
  s <- gsub("(hat|tilde|beta|delta|sigma) ([0-9jk])\\b", "\\1\\2", s)
  tolower(gsub("\\s+", " ", s))
}
.DSNAMES <- local({ nm <- c("wage1", "wage2", "ceosal1", "ceosal2", "bwght", "gpa1", "gpa2", "vote1", "campus", "rdchem",
  "mlb1", "meap93", "hprice1", "k401k", "discrim", "attend", "crime1", "sleep75", "lawsch85", "jtrain", "charity", "hprice2", "htv")
  if (requireNamespace("wooldridge", quietly = TRUE)) { p <- tryCatch(data(package = "wooldridge")$results[, "Item"], error = function(e) c())
    nm <- unique(c(nm, grep("[0-9]", tolower(p), value = TRUE))) }
  nm })
.dataset_in <- function(s) {                                # which wooldridge dataset does the question name?
  for (d in .DSNAMES) {
    if (grepl("[0-9]", d) && grepl(paste0("\\b", d, "\\b"), s)) return(d)
    if (grepl(paste0("(data:?|using|load|data set|dataset|in the)\\s*\\(?", d, "\\b|\\b", d, "\\s+(data|dataset)\\b"), s)) return(d)
  }
  if (grepl("^data:|\\bdata set\\b|\\bdataset\\b|\\blm\\(|wooldridge|^same regression|using the same regression", s)) return("?")
  NA }
.strip_desc <- function(s, d) {                             # drop "salary = CEO pay in $1000s;" definitions
  cols <- tryCatch(tolower(names(get(d, envir = globalenv()))), error = function(e) c())
  s <- gsub("(?<!lm)\\([^()]*=[^()]*\\)", " ", s, perl = TRUE)
  if (length(cols)) s <- gsub(paste0("\\b(", paste(cols, collapse = "|"), ")\\s*=\\s*(?!b0|beta)[a-z=][^;.()]*[;.]?"), " ", s, perl = TRUE)
  sub("^.*variables:", "", s)
}
.rules <- function(raw) {                                   # bonus per tag from the question's shape
  s <- .norm(raw); b <- c(); add <- function(tags, v = 1) for (t in tags) b[t] <<- max(c(b[t], 0), na.rm = TRUE) + v
  has <- function(p) grepl(p, s, perl = TRUE)
  if (has("which regression gives|r\\W{0,3}_\\W{0,2}j\\W{0,4}2? measures|what is \\W{0,3}x\\W{0,3}_\\W{0,2}j|residual standard error.*which of your answers|warning about missing data"))
    return(list(bonus = c(K18 = 2.5), gate = "concept"))
  ds <- .dataset_in(s)
  if (!is.na(ds)) {                                          # ---------- PART III: real data ----------
    q <- if (ds != "?") .strip_desc(s, ds) else s
    h <- function(p) grepl(p, q, perl = TRUE)
    logy <- h("(regress|lm\\(|estimate|of|with)\\s*(the\\s*)?(natural\\s*)?log\\s*(\\(|of\\s)\\s*\\w+\\)?\\s*(~|on|as the dependent|=)|log\\(\\w+\\)\\s*(~|as the dependent|=)|natural log of \\w+ as the dependent|log\\(\\w+\\) as the dependent")
    logx <- h("(~|\\bon\\b|\\+)\\s*[^.?~]*\\blog\\(\\w+\\)|elasticity|\\bon log\\s+\\w+")
    if (h("^(data:?\\s*)?\\w*\\s*log\\s+\\w+\\s+on\\b|\\blog\\s+\\w+\\s+on\\b|\\blog\\(\\w+\\)\\s+on\\b|same percentage effect|constant percentage|log\\(\\w+\\)\\s*=\\s*b\\s?0")) logy <- TRUE
    if (h("log-log|constant[- ]elasticity|elasticity of")) { logy <- TRUE; logx <- TRUE } else if (h("log-level")) { logy <- TRUE; logx <- FALSE } else if (h("level-log")) { logy <- FALSE; logx <- TRUE }
    two  <- h("\\bon \\w+(\\(\\w+\\))?(, \\w+(\\(\\w+\\))?)*,? and \\w+|~\\s*[^)]*\\+|\\w+, \\w+ as regressors|holding \\w+ (fixed|constant)|and \\w+ as regressors|\\bb\\s?2\\b|beta\\s?2|with and without|explained by [^.?]* and |\\w+ and \\w+ explain")
    if (h("\\bna\\b|totexpend|their sum|equals \\w+ \\+ \\w+|= \\w+ \\+ \\w+ and regress|collinear")) add("D11", 1.6)
    else if (h("t[ -]?stat|t ratio|significan|reject|p-value|critical value|h0|null hypothesis|one-sided|two-sided|h1:")) add("D12", 1.6)
    else if (h("\\balone\\b|with and without|leaving out|leave out|delta|3\\.23|when \\w+ is added|slope when|omitted|left out|simple regression slope .* (with|larger|smaller)|regress \\w+ on \\w+\\. what is the slope \\(delta")) add("D10", 1.6)
    else if (h("sst\\W{0,3}_?\\W{0,2}j\\b|\\br\\W{0,3}_\\W{0,2}j|x\\W{0,3}_\\W{0,2}j\\b|\\bdf\\b|degrees of freedom|for the \\w+ coefficient|coefficient by hand|other independent variables") ||
             ((two || h("~[^.?]*\\+")) && h("by hand|standard error of the regression|sigma"))) add(c("D14"), 1.8)
    else if (h("standard error of the regression|sigma|error variance|sst_?x|total variation in|total sum of squares of|se\\(|standard error of the slope|standard error of b|by hand")) add(c("D6"), 1.6)
    else if (h("sample means|their (sample )?means|at the means|averages of .* into|means of .* into|passes through the means|at their (sample )?(means|averages)|at the (sample )?mean of") || grepl("=\\s*mean\\s*\\(", s)) add("D9", 1.6)
    else if (h("instead of|divided by|multipl(y|ied|ying|ication)|in cents|re-express|/\\s*100|/\\s*1000|rescal|in dollars rather|measured in")) add("D2", 1.6)
    else if (logy && logx && two && !h("elasticity|by [0-9.]+\\s*(%|percent(?!age))")) { add("D8", 1.6); add("D5", 0.6) }
    else if (logy && logx) { add("D5", 1.6); if (two) add("D8", 0.8) }
    else if (logy && two) add(c("D8"), 1.6)
    else if (logy) add(c("D3"), 1.6)
    else if (logx && two) { add("D7", 1.6); add("D4", 0.6) }
    else if (logx) add(c("D4"), 1.6)
    else if (two) add(c("D7"), 1.6)
    else if (!h("regress|\\blm\\(|ols|fitted|predicted|slope|residual|r-squared|r\\^2|explained|explain|estimate|sum of squared")) add("D0", 1.6)
    else add("D1", 1.6)
    if (h("adjusted r|everything|all the output")) add("D13", 0.8)
    return(list(bonus = b, gate = "data"))
  }
  logeq <- has("\\b(log|ln)\\s*\\(|\\blog \\w+ on\\b|\\bon log\\b|\\blog y\\b|\\blog x\\b|log-log|log-level|level-log|constant[- ]elasticity|elasticity")
  short <- has("\\bgiven\\b|\\bgave\\b|\\bwant\\b|\\bknow\\b|\\bneed\\b|\\bfind\\b")
  num <- short || grepl("(?<![a-z_^0-9.])-?[0-9]+(\\.[0-9]+)?(?![a-z_])", gsub("(!=|=|<|>)\\s*0(?![.0-9])", " ", s, perl = TRUE), perl = TRUE)
  # >> PART II: numbers in the question
  if (has("residuals?[^.?]*-?[0-9.]+\\s*,\\s*-?[0-9.]+") && has("one more|missing|final|last|\\?\\s*[.,]|, \\?|(sixth|fifth|seventh|last) residual")) add("O2", 1.6)
  if (has("\\bx\\s*=\\s*[\\[(]\\s*-?[0-9]") && has("\\by\\s*=\\s*[\\[(]\\s*-?[0-9]|sample (standard deviation|variance|mean) of x")) add(c("S6"), 1.4)
  pts <- has("\\([0-9.-]+\\s*,\\s*[0-9.-]+\\)\\s*,\\s*\\([0-9.-]+\\s*,\\s*[0-9.-]+\\)") || (has("\\bx\\s*=\\s*[\\[(]\\s*-?[0-9]") && has("\\by\\s*=\\s*[\\[(]\\s*-?[0-9]"))
  if (has("x and y (lists?|values|data|points)|lists? of x|x list|raw x and y")) pts <- TRUE
  if (length(gregexpr("=\\s*[\\[(]\\s*-?[0-9.]+\\s*,", s)[[1]]) >= 2 || has("same (eight|\\w+) (students|observations|data points|people|firms)")) pts <- TRUE
  if (pts) { add("S6", 1.8); num <- TRUE }
  if (has("\\bx\\s*=\\s*[\\[(]|x takes the values|x values") && has("sigma|error (standard deviation|variance)|ssr")) add(c("S2"), 1.6)
  if (has("correlation") && has("covariance|cov\\s*\\(|s_?\\{?xy")) add("S5", 1.8)
  if (has("lies exactly on|all .* on the (ols )?line|perfect(ly)? fit")) add("S1", 1.6)
  if (has("e\\s*[(\\[]\\s*x|e\\s*[(\\[]\\s*y|var\\s*\\(\\s*[xy]\\b\\s*\\)\\s*=\\s*-?[0-9]|cov\\s*\\(\\s*x\\s*,\\s*y\\s*\\)\\s*=\\s*-?[0-9]|probabilit|joint (distribution|probability)|takes (the )?values|sd\\s*\\(\\s*-?[0-9]*\\s*x\\b|deviation of -?[0-9]*x|var\\[")) add(c("S5"), 1.6)
  if (has("\\bvif\\b|inflation|r_?j\\b|r_?j\\^2|regressing x_?[0-9] on (all )?the other|on all other explanatory")) add("V7", 1.8)
  if (has("times (larger|as large)|doubl|quadrupl|tripl|sample size (doubles|is)|sample were")) add(c("V6"), 1.4)
  nnum <- length(gregexpr("=\\s*-?[0-9]*\\.?[0-9]+", s)[[1]]) * grepl("=\\s*-?[0-9]*\\.?[0-9]+", s)
  if (nnum >= 2 && has("delta|tilde|3\\.23|short regression|long regression|omit|leaving out|left out|bias")) add(c("B1", "B2"), 1.6)
  if (has("confidence interval")) add("T3", 1.6)
  ttest <- has("t[ -]?stat|\\bt\\s*=|critical|degrees of freedom|\\bdf\\b|p-value|h0|null|reject|significan|one-sided|two-sided|one-tailed")
  if (num && ttest) add(c("T1", "T2"), 1.7)
  if (has("equals \\w+ \\+ \\w+|= \\w+ \\+ \\w+ (to|and)|their sum|total of the two")) add(c("D11", "K11"), 1.6)
  if (has("sign of the bias|upward or downward|biased which way|(positive|negative)(ly)? correlated|corr\\s*\\([^)]*\\)\\s*[<>]|beta2 (is )?(positive|negative|[<>])")) add("B3", 1.6)
  ssonly <- has("\\bssr\\b") && has("observations|\\bn\\s*=") && !has("\\bsse\\b|\\bsst\\b|r\\^2|r-squared|r2\\b|explained|variance of (y|the dependent)")
  if (num && ssonly) add("S2", 1.8)
  if (num && !ssonly && !pts && has("\\bsse\\b|\\bssr\\b|\\bsst\\b(?!_?x)|r\\^2|r-squared|r2\\b|explained|sum of squares|sample variance of (y|the dependent)") &&
      !has("sigma|se\\s*\\(|sd\\s*\\(|standard error|sst_?x|vif")) add(c("S1"), 1.4)
  if (num && logeq && has("dollars|in levels|predicted (hourly )?(wage|price|salary|y)\\b") && has("=\\s*-?[0-9.]+\\s*[+-]") && !has("percent|%")) add("S7", 1.8)
  if (has("you add|adding|add an?|include an?") && has("no effect on y|irrelevant|has no effect")) add("K13", 2.2)
  if (num && has("tilde|simple[- ]regression slope|short regression") && has("multiple[- ]regression|beta hat|b1hat|long regression") && !has("population|true")) add("B1", 1.2)
  if (num && !logeq && !has("percent|%") && has("x_?1\\b.*x_?2\\b") && has("change|up|down|rises|falls|predict")) add("S7", 1.2)
  if (num && !ttest && !has("correlation") && has("sigma|sst_?x|sst_?[0-9j]|se\\s*\\(|sd\\s*\\(|standard error|standard deviation of the slope|variance of the (ols )?slope|error variance|var\\s*\\(\\s*b|s_?x")) add(c("S2"), 1.2)
  if (has("measured in|instead|divided by|multiplied by|re-measured|in cents|in thousands|decimals?\\b|in months|converted|units"))
    add(if (num && !has("what happens|which (statement|estimates|coefficient)|does .* change|affects")) c("S3") else c("K8"), 1.4)
  if (num && logeq && has("percent|%|how much|by how many|change") && !has("what does .* mean|interpret|in which model"))
    { if (has("x_?2\\b|, x_?[0-9]")) { add("L4", 1.8); add("S4", 1.0) } else add("S4", 1.4) }
  if (num && !logeq && has("by (about )?what percent") && has("x_?2\\b")) add("L4", 1.4)
  if (num && has("percentage[- ]point|from [0-9.]+% to [0-9.]+%|rises from [0-9.]+%|falls from [0-9.]+%")) add("S4", 1.4)
  if (num && !logeq && has("yhat|y-hat|-hat\\s*=|\\bhat\\s*=|=\\s*-?[0-9.]+\\s*[+-]\\s*[0-9.]+\\s*\\*?\\s*[a-z]|y-bar|ybar|mean of y|sample mean of y|intercept\\?")) add(c("S7"), 1.2)
  # >> PART I: concepts / multiple choice
  if (has("part of u|error term|e\\s*\\(\\s*u|zero conditional|exogenous|endogenous|mlr\\.?\\s*4|slr\\.?\\s*4|key assumption")) add(c("K2", "K12"), 1.6)
  if (has("leav(es|ing) out|left out|omit|leave out") && has("bias|overstate|understate|too (high|low)|upward|downward|direction|up or down|likely:|most likely|slope (on \\w+ )?is:|correlated")) add(c("B3", "K17"), 1.4)
  if (has("which (omitted )?(variable|factor).*(bias|left out)|most likely to (cause|contribute)|two conditions|omitted factor")) add("K3", 1.4)
  if (has("theorem 2\\.1|e\\s*\\[\\s*b1\\s*\\]\\s*=|e\\s*\\(\\s*b1\\s*\\)\\s*=")) add("K4", 1.6)
  if (has("unbiased|many (random )?samples|simulation|center of the sampling|e\\s*\\(\\s*b1\\s*\\)\\s*=|beta hat 1\\s*\\)\\s*=|e\\s*\\(\\s*\\(?\\s*b1")) add("K4", 1.2)
  if (has("same (value|number)|does not vary|no variation|everyone in the sample has|all .* have the same")) add("K5", 1.4)
  if (has("heteroskedast|homoskedast|var\\s*\\(\\s*u|spread .* (grows|fans|increases)|fans out|variance of the error grows")) add("K6", 2.0)
  if (!num && !has("which assumption|var\\s*\\(\\s*u") && has("standard error|var\\s*\\(|variance|precise|precision|sd\\s*\\(") && has("increase|reduce|decrease|larger|smaller|which|what happens|more precise|better|doubles")) add("K7", 1.2)
  if ((!num && has("elasticity|functional form|percentage effect|match the model|means:")) || (logeq && has("mean(s)?\\s*[:?]|interpret")) || has("interpret|what does (the )?-?[0-9.]+ ?(\\w+ )?mean|what does (the )?(slope|coefficient|estimate|beta\\w*|b1) .*mean|in which model|which model")) { add("K9", 1.8); if (has("means\\s*:|mean\\?|interpret")) num <- FALSE }
  if (has("constant percentage|functional form implies|elasticity of y with respect")) add("K9", 0.6)
  if (has("always (true|holds)|algebraic propert|residuals sum|pass(es)? through|average of the fitted|true or false: the (sample covariance|average)|not an algebraic")) add("K10", 1.4)
  if (has("perfect(ly)? collinear|exact linear|mlr\\.?\\s*3|(dollars|cents|thousands|years|months) and (its |the )?\\w* ?\\w* in (cents|dollars|thousands|months|years)|in dollars and .*thousands|total ad|total .*spending|more explanatory variables than|observations and [0-9]+ explanatory|squared in the same|high but not perfect")) add("K11", 2.0)
  if (has("irrelevant|every (available )?variable|too many|over-?control")) add("K13", 2.0)
  if (has("holding (\\w+ )?(other )?(\\w+ )?(fixed|constant)(?! in)") && !has("holding everything else fixed|which change makes")) add("K14", 1.0)
  if (has("ceteris paribus|partialling|partial(l)?ing-out|measure\\?|why does the coefficient .* change|controlling for|simple and multiple .* (same|equal)")) add("K14", 1.3)
  if (has("no bias|cause no|not biased|biased or not|uncorrelated with every|no effect on y") && !has("you add|adding|add an?\\b|include an?\\b")) add("K15", 1.9)
  if (!num && has("\\bblue\\b|gauss-markov|normality|mlr\\.?\\s*6|classical linear|t statistic measures|distribution of|p-value (means|is)|small p-value|statistically significant|reject h|when do you reject")) add("K16", 1.4)
  if (has("minimi[sz]e|least squares estimates|candidate lines")) add("K1", 1.6)
  if (has("can cause (the )?ols( estimators?)? (to be )?biased|which (of the following )?(can )?cause.* bias")) add("K12", 3)
  if (has("would you expect|expect the (simple|multiple)") && has("\\bse\\b|standard error|variance")) add("K7", 2.2)
  if (has("add up to (one|1|100)|sum to (one|1|100)|must (one of .* )?be omitted|why must one")) add("K11", 2.4)
  if (has("which regression gives r_?j|r_?j\\^?2? (measures|comes|from)|what is x_?j|sigma hat estimate|what does sigma hat|r_?j\\^?2? gets close to 1|residual standard error|missing (data|values)|\\bna\\b\\)?.*drops")) add("K18", 2.2)
  if (!num && has("r-squared|r\\^2|r2\\b")) add(c("K10", "K13"), 0.8)
  list(bonus = b, gate = if (num) "numbers" else "concept")
}
.tok <- function(s) {
  s <- .norm(s); s <- gsub("\\([^()]*=[^()]*\\)", " ", s)            # drop "(var = definition)" lists
  w <- strsplit(gsub("[^a-z0-9\\^\\-]+", " ", s), " +")[[1]]
  stop <- c("the","of","in","by","a","an","and","to","is","what","does","when","how","are","at","on","for","with",
    "its","that","this","be","as","or","if","about","run","use","give","round","hundredths","regression","regress",
    "find","value","values","which","statement","correct","it","can","you","your","than","from","then","so","into",
    "all","apply","select","each","their","they","there","these","those","one","more","has","have","gives","given")
  w[nchar(w) > 1 & !(w %in% stop) & !grepl("^[0-9.\\-]+$", w)]
}
.ask_index <- function() {
  docs <- c(EXAMPLES$text, sapply(CATALOG, function(e) paste(e[2], e[3])))
  tags <- c(EXAMPLES$tag, sapply(CATALOG, `[`, 1))
  toks <- lapply(docs, .tok); vocab <- unique(unlist(toks))
  df <- sapply(vocab, function(v) sum(vapply(toks, function(t) v %in% t, TRUE)))
  idf <- log((length(docs) + 1) / (df + 1)) + 1
  vec <- lapply(toks, function(t) { tf <- table(t); v <- (1 + log(as.numeric(tf))) * idf[names(tf)]; v / sqrt(sum(v^2)) })
  list(tags = tags, vec = vec, idf = idf)
}
.kw_scores <- function(words) {
  stop <- c("the","of","in","by","a","an","and","to","is","what","does","when","how","are","at","on",
            "for","with","its","that","this","be","as","or","if","about","run","use","give","round","hundredths",
            "regression","regress","find","value","values","x","y","which","statement","correct","happens")
  w <- unique(tolower(strsplit(gsub("[?.:;()\"']", " ", words), "[ ,]+")[[1]])); w <- w[nchar(w) > 1 & !(w %in% stop)]
  txt <- sapply(CATALOG, function(e) tolower(paste(e[1], e[2], e[3])))
  if (!length(w)) return(setNames(rep(0, length(txt)), sapply(CATALOG, `[`, 1)))
  hit <- matrix(sapply(w, function(x) grepl(x, txt, fixed = TRUE)), nrow = length(txt))
  idf <- log((length(txt) + 1) / (colSums(hit) + 0.5)); sc <- as.vector(hit %*% pmax(idf, 0))
  if ("data" %in% w) sc <- sc * ifelse(grepl("^D", sapply(CATALOG, `[`, 1)), 1.6, 1)
  setNames(sc, sapply(CATALOG, `[`, 1))
}
.knn_scores <- function(text) {
  if (!exists(".ASKIDX", envir = globalenv())) assign(".ASKIDX", .ask_index(), envir = globalenv())
  ix <- get(".ASKIDX", envir = globalenv())
  q <- .tok(text); q <- q[q %in% names(ix$idf)]
  if (!length(q)) return(c())
  tf <- table(q); qv <- (1 + log(as.numeric(tf))) * ix$idf[names(tf)]; qv <- qv / sqrt(sum(qv^2))
  sims <- sapply(ix$vec, function(v) sum(v[names(qv)] * qv, na.rm = TRUE))
  tapply(sims, ix$tags, function(s) { s <- sort(s, decreasing = TRUE); s[1] + 0.3 * ifelse(length(s) > 1, s[2], 0) })
}
FIND <- function(words, go = TRUE) {
  words <- paste(words, collapse = " "); nw <- .norm(words)
  a <- .kw_scores(nw); b <- .knn_scores(nw); r <- .rules(words)
  if (!length(b)) b <- setNames(0, names(a)[1])
  tags <- union(names(a), names(b)); A <- a[tags]; B <- b[tags]; A[is.na(A)] <- 0; B[is.na(B)] <- 0
  R <- setNames(rep(0, length(tags)), tags); R[intersect(names(r$bonus), tags)] <- r$bonus[intersect(names(r$bonus), tags)]
  if (max(A) == 0 && max(B) == 0 && max(R) == 0) { cat("No match. Try other words from the question.\n"); return(invisible()) }
  sc <- A / max(A, 1e-9) + B / max(B, 1e-9) + R
  isD <- grepl("^D", tags)
  if (r$gate == "data") sc[!isD] <- sc[!isD] * 0.35
  if (r$gate == "numbers") { sc[isD] <- sc[isD] * 0.5; sc[grepl("^K", tags)] <- sc[grepl("^K", tags)] * 0.8 }
  if (r$gate == "concept") sc[isD | grepl("^[SOVPT]", tags)] <- sc[isD | grepl("^[SOVPT]", tags)] * 0.6
  if (grepl("omit|overstat|understat|bias", nw)) { bt <- tags %in% c("B1","B2","B3","K3","K12","K15","K17"); sc[bt] <- sc[bt] * 1.15 }
  o <- names(sort(sc, decreasing = TRUE))[1:4]
  if (!go) return(invisible(o))
  title <- setNames(sapply(CATALOG, `[`, 2), sapply(CATALOG, `[`, 1))
  for (t in o) cat(sprintf("  [%s]  %-72s\n", t, title[t]))
  GO(o[1])
  cat(sprintf("  Not it? GO(\"%s\")  or  GO(\"%s\")\n", o[2], o[3]))
  invisible(o)
}
## ASK(): copy the WHOLE question (Mac: Cmd+C, Windows: Ctrl+C), then type ASK() in the Console.
ASK <- function(question = NULL) {
  # Two ways:  ASK()                -> reads the question you copied (Mac Cmd+C / Windows Ctrl+C)
  #            ASK("paste it here")  -> uses the text inside the quotes
  if (!is.null(question)) txt <- paste(question, collapse = " ") else
  txt <- tryCatch({
    if (.Platform$OS.type == "windows") paste(utils::readClipboard(), collapse = " ")
    else if (Sys.info()[["sysname"]] == "Darwin") paste(suppressWarnings(system2("pbpaste", stdout = TRUE, stderr = FALSE)), collapse = " ")
    else paste(readLines(pipe("xclip -o -selection clipboard"), warn = FALSE), collapse = " ")
  }, error = function(e) "")
  key <- if (Sys.info()[["sysname"]] == "Darwin") "Cmd+C" else "Ctrl+C"
  clean <- trimws(gsub("\\s+", " ", txt))
  if (length(strsplit(clean, " ")[[1]]) < 3 || nchar(clean) < 12) {
    cat(sprintf("ASK got only: \"%s\" (not a full question)\n", substr(clean, 1, 40)))
    cat(sprintf("Highlight the WHOLE question, press %s, then ASK() again.\n", key))
    cat("Or put it in quotes:  ASK(\"...the question...\")\n"); return(invisible()) }
  cat("Question:", substr(clean, 1, 110), "...\n")
  FIND(txt)
}

## ---- NUMS(): pull the numbers out of the question ---------------------------
## NUMS()  copy the question (Cmd+C / Ctrl+C), type NUMS() -> every number in it, labelled,
##         lists already written as c(...). Copy from there instead of retyping.
.clip_text <- function() tryCatch({
  if (.Platform$OS.type == "windows") paste(utils::readClipboard(), collapse = " ")
  else if (Sys.info()[["sysname"]] == "Darwin") paste(suppressWarnings(system2("pbpaste", stdout = TRUE, stderr = FALSE)), collapse = " ")
  else paste(readLines(pipe("xclip -o -selection clipboard"), warn = FALSE), collapse = " ")
}, error = function(e) "")
.NUM_RE <- "-?(?:\\d+(?:\\.\\d+)?|\\.\\d+)"
.lab_key <- function(l) {                                   # "\(\hat\sigma\)" / "R^2" / "SST_x" -> sigma / r2 / sstx
  l <- tolower(l); l <- gsub("\\\\(mathrm|text|operatorname)", "", l, perl = TRUE)
  l <- gsub("[\\\\{}()\\[\\] ]", "", l, perl = TRUE); l <- gsub("-squared|squared", "^2", l)
  hat <- grepl("hat", l); til <- grepl("tilde", l); l <- gsub("hat|tilde", "", l)
  l <- gsub("[_^]", "", l)
  l <- sub("^sigma2$", "sigma2", l); l <- sub("^(var|variance)\\(?u\\)?$", "sigma2", l)
  if (grepl("^beta[0-9]$", l)) l <- paste0("b", substring(l, 5), if (til) "tilde" else if (hat) "hat" else "")
  if (grepl("^delta[0-9]?$", l)) l <- "delta1"
  sub("^s?st([xj0-9])$", "sst\\1", l)
}
.lab_show <- function(l) .lab_show0(gsub("\\\\(hat|tilde)\\s*\\\\?([a-z]+)", "\\2-\\1", l, perl = TRUE))
.lab_show0 <- function(l) gsub("[\\\\{}]", "", gsub("\\\\(mathrm|text|operatorname)\\{([^}]*)\\}", "\\2", l, perl = TRUE), perl = TRUE)
.asciify <- function(s) {                                   # Canvas symbols -> LaTeX-style ASCII (any locale)
  s <- paste(s, collapse = " ")
  rp <- list(c("\u03c3\u0302", "\\hat\\sigma"), c("\u03b2\u0302", "\\hat\\beta"), c("\u03b2\u0303", "\\tilde\\beta"),
             c("\u03b4\u0303", "\\tilde\\delta"), c("\u03c3", "\\sigma"), c("\u03b2", "\\beta"), c("\u03b4", "\\delta"),
             c("\u00b2", "^2"), c("\u2080", "_0"), c("\u2081", "_1"), c("\u2082", "_2"), c("\u2083", "_3"), c("\u2c7c", "_j"),
             c("\u2212", "-"), c("\u0177", "yhat"), c("\u00fb", "uhat"), c("\u00b7", "*"), c("\u0302", ""), c("\u0303", ""))
  for (p in rp) s <- gsub(p[1], p[2], s, fixed = TRUE, useBytes = TRUE)
  gsub("[^ -~]", " ", s, useBytes = TRUE)
}
.qnums <- function(txt) {                                   # numbers in a question, labelled where possible
  s <- gsub("\\s+", " ", .asciify(txt))
  lists <- list(); lab <- data.frame(label = character(), key = character(), value = character(), stringsAsFactors = FALSE)
  lre <- paste0("([A-Za-z\\\\_^{}]+)\\s*\\)?\\s*=\\s*\\\\?\\(?\\s*\\\\?[\\[(]\\s*(", .NUM_RE, "(?:\\s*,\\s*", .NUM_RE, "){2,})\\s*\\\\?[\\])]")
  m <- gregexpr(lre, s, perl = TRUE)[[1]]
  if (m[1] > 0) { for (i in seq_along(m)) { hit <- substr(s, m[i], m[i] + attr(m, "match.length")[i] - 1)
      g <- regmatches(hit, regexec(lre, hit, perl = TRUE))[[1]]
      lists[[length(lists) + 1]] <- list(label = .lab_show(g[2]), key = .lab_key(g[2]), values = gsub("\\s*,\\s*", ", ", g[3])) }
    s <- gsub(lre, " [list] ", s, perl = TRUE) }
  s <- gsub("(\\d{1,3}),(\\d{3})(?![\\d,])", "\\1\\2", s, perl = TRUE)   # 1,050 -> 1050 (outside lists)
  sre <- paste0("([A-Za-z\\\\][A-Za-z0-9\\\\_^{}]*(?:\\s*[_^]\\s*\\{?\\w+\\}?)?)\\s*\\\\?\\)?\\s*(?:=|\\bis\\b|\\bequals\\b)\\s*\\\\?\\(?\\s*(", .NUM_RE, ")(%?)")
  m <- gregexpr(sre, s, perl = TRUE)[[1]]
  if (m[1] > 0) for (i in seq_along(m)) { hit <- substr(s, m[i], m[i] + attr(m, "match.length")[i] - 1)
    g <- regmatches(hit, regexec(sre, hit, perl = TRUE))[[1]]
    if (tolower(g[2]) %in% c("and", "of", "the", "that", "it", "which", "this", "slope", "value", "hat", "yhat", "y-hat")) next
    lab[nrow(lab) + 1, ] <- c(.lab_show(g[2]), .lab_key(g[2]), paste0(g[3], g[4])) }
  g <- regmatches(s, regexec(paste0("\\bfrom\\s+\\$?(", .NUM_RE, "%?)\\s+to\\s+\\$?(", .NUM_RE, "%?)"), s, perl = TRUE))[[1]]
  if (length(g)) { lab[nrow(lab) + 1, ] <- c("from", "from", g[2]); lab[nrow(lab) + 1, ] <- c("to", "to", g[3]) }
  for (p in list(c("(\\d+) observations", "n"), c("sample of (\\d+)", "n"), c("\\bn\\s*=\\s*(\\d+)", "n"))) {
    g <- regmatches(s, regexec(p[1], s, perl = TRUE))[[1]]
    if (length(g) && !(p[2] %in% lab$key)) lab[nrow(lab) + 1, ] <- c("n", p[2], g[2]) }
  eq <- NULL                                                # "y-hat = 4 + 2.9 x1 - 0.6 x2" -> b0 and slopes
  ere <- paste0("=\\s*(", .NUM_RE, ")((?:\\s*[-+]\\s*", "(?:\\d+(?:\\.\\d+)?|\\.\\d+)", "\\s*\\\\?,?\\s*\\*?\\s*(?:log\\s*\\(?\\s*)?[A-Za-z][\\w]*\\)?)+)")
  g <- regmatches(s, regexec(ere, s, perl = TRUE))[[1]]
  if (length(g)) { tm <- regmatches(g[3], gregexpr("[-+]\\s*(?:\\d+(?:\\.\\d+)?|\\.\\d+)", g[3], perl = TRUE))[[1]]
    eq <- list(b0 = g[2], b = paste(gsub("\\s|\\+", "", tm), collapse = ", ")) }
  allnum <- regmatches(s, gregexpr(paste0("(?<![\\w.^_])", .NUM_RE, "%?"), s, perl = TRUE))[[1]]
  list(lab = lab, lists = lists, eq = eq, all = allnum)
}
NUMS <- function(question = NULL) {
  q <- if (is.null(question)) .clip_text() else paste(question, collapse = " ")
  if (nchar(trimws(q)) < 5) { cat("Nothing on the clipboard. Copy the question first, or NUMS(\"...\").\n"); return(invisible()) }
  r <- .qnums(q)
  cat("Numbers in the question (copy these, don't retype):\n")
  for (i in seq_len(nrow(r$lab))) cat(sprintf("  %-12s = %s%s\n", r$lab$label[i], r$lab$value[i],
      if (grepl("%", r$lab$value[i])) "   <- a percent: check if the box wants 0.xx or xx" else ""))
  for (l in r$lists) cat(sprintf("  %-12s = c(%s)\n", l$label, l$values))
  if (!is.null(r$eq)) cat(sprintf("  equation:    intercept = %s   slopes = c(%s)\n", r$eq$b0, r$eq$b))
  if (length(r$all)) cat("  every number:", paste(r$all, collapse = "  "), "\n")
  if (!nrow(r$lab) && !length(r$lists) && !length(r$all)) cat("  (none)\n")
  invisible(r)
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
  nm <- function(v, what) {                       # at = 10 / c(14, 10, 5) also work: matched to x's in formula order
    if (is.null(v) || !is.null(names(v))) return(v)
    if (length(v) != length(vars)) stop(sprintf("REG: %s needs one number per x (%s), e.g. %s = list(%s = 10)",
                                               what, paste(vars, collapse = ", "), what, vars[1]), call. = FALSE)
    v <- setNames(as.list(v), vars); info(paste0(what, " used:"), paste(vars, unlist(v), sep = " = ", collapse = ", ")); v }
  at <- nm(at, "at"); from <- nm(from, "from"); to <- nm(to, "to")
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
## Every block below works the same way:
##   1. Change ONLY the lines that end in  # <-- CHANGE   (names go in "quotes").
##   2. Run the WHOLE block: click inside it, Cmd+Option+T (Mac) / Ctrl+Alt+T (Windows).
##   3. Read the >>> ANSWER line whose label matches the question's wording.
##   If you see the block's DEFAULTS numbers, your changes didn't run.

## ======================================================================
## [D0] DATA SUMMARY: n, mean, sd, variance, correlation, min, max, counts ----
## LOOKS LIKE: "Data: ceosal1. How many CEOs are in the sample?" / "sample mean of roe?"
##   / "sample correlation between salary and roe?" / "what share of wage1 is female?"  (Exam I Q29-31)
## A correlation NEVER comes from lm() and is always between -1 and 1.
## A 0/1 column (female, smoker): its MEAN is the SHARE that are 1 (0.48 -> 48% women).
## GROUP mean ("average wage of women"): d0_x <- "wage", d0_by <- "female", d0_val <- 1
## COUNT or PERCENT equal to a value ("how many have ceoten = 0?" / "% with gift = 0"): d0_by <- that column, d0_val <- the value
##   = mean(wage1$wage[wage1$female == 1])   (study guide, section 0)
## DEFAULTS: n 209 | mean of roe 17.18 | sd of roe 8.52 | correlation 0.11
# >> YOUR NUMBERS: change these lines
d0_data <- "ceosal1"     # <-- CHANGE  dataset name, in quotes
d0_x    <- "roe"         # <-- CHANGE  the column the question is about
d0_y    <- "salary"      # <-- CHANGE  a second column (only for correlation / covariance)
d0_cut  <- 20            # <-- CHANGE  only for "how many have <column> above ___?"
d0_by   <- "salary"      # <-- CHANGE  GROUP mean: the column that defines the group (e.g. "female")
d0_val  <- NA            # <-- CHANGE  ... and its value (e.g. 1). NA = no group question
# >> ANSWERS: nothing to change below
blk("D0", sprintf("summary of %s in %s", d0_x, d0_data))
d0_df <- get(d0_data); d0_v <- d0_df[[d0_x]]; d0_w <- d0_df[[d0_y]]
ans(sprintf("n = number of rows in %s", d0_data), nrow(d0_df))
ans(sprintf("mean of %s", d0_x), mean(d0_v, na.rm = TRUE))
ans(sprintf("sd of %s", d0_x), sd(d0_v, na.rm = TRUE))
ans(sprintf("variance of %s", d0_x), var(d0_v, na.rm = TRUE))
ans(sprintf("min of %s", d0_x), min(d0_v, na.rm = TRUE)); ans(sprintf("max of %s", d0_x), max(d0_v, na.rm = TRUE))
ans(sprintf("median of %s", d0_x), median(d0_v, na.rm = TRUE))
ans(sprintf("how many rows with %s > %g", d0_x, d0_cut), sum(d0_v > d0_cut, na.rm = TRUE))
ans(sprintf("correlation of %s and %s", d0_y, d0_x), cor(d0_w, d0_v, use = "complete.obs"))
ans(sprintf("covariance of %s and %s", d0_y, d0_x), cov(d0_w, d0_v, use = "complete.obs"))
if (!is.na(d0_val)) { d0_g <- d0_df[[d0_by]] == d0_val
  ans(sprintf("GROUP mean of %s where %s == %g", d0_x, d0_by, d0_val), mean(d0_v[d0_g], na.rm = TRUE))
  ans(sprintf("GROUP sd of %s where %s == %g", d0_x, d0_by, d0_val), sd(d0_v[d0_g], na.rm = TRUE))
  ans(sprintf("how many rows with %s == %g", d0_by, d0_val), sum(d0_g, na.rm = TRUE))
  ans(sprintf("PERCENT of rows with %s == %g", d0_by, d0_val), 100 * mean(d0_g, na.rm = TRUE)) }

## ======================================================================
## [D1] SIMPLE REGRESSION ON DATA: slope, prediction, change, R^2, residual, SSE/SSR/SST ----
## LOOKS LIKE: "Data: wage1. Regress wage on tenure. What is the OLS slope? / predicted wage
##   at 10 years of tenure? / change from 3 to 16 years? / % of variation explained? /
##   residual of the worker in row 12?"   (Exam I Q32-38, PS8 #11)
## PREDICTION = a level ("has 10 years"): keeps the intercept.
## CHANGE = "rises by" / "from 3 to 16": no intercept. "Rises by 13" = from 0 to 13.
## "FALLS by 300" = from 300 to 0 (NOT from -300 to 0, which is a rise).
## DEFAULTS: slope 0.18 | prediction 6.76 | change 2.31 | R^2 12.03% | row 12 residual 3.14
# >> YOUR NUMBERS: change these lines
d1_data    <- "wage1"          # <-- CHANGE  dataset name, in quotes
d1_formula <- wage ~ tenure    # <-- CHANGE  y ~ x  (formula only: no lm(), no dataset name)
d1_at      <- 10               # <-- CHANGE  prediction: "predicted y when x = ___"
d1_from    <- 3                # <-- CHANGE  change: x goes FROM ___ ...
d1_to      <- 16               # <-- CHANGE  ... TO ___
d1_row     <- 12               # <-- CHANGE  residual of row number ___
# >> ANSWERS: nothing to change below
d1_reg <- fit(d1_formula, d1_data); d1_b <- coef(d1_reg)
d1_yn <- all.vars(d1_formula)[1]; d1_xn <- all.vars(d1_formula)[2]
blk("D1", sprintf("%s regressed on %s (%s)", d1_yn, d1_xn, d1_data))
ans4(sprintf("slope on %s", d1_xn), d1_b[2]); ans4("intercept", d1_b[1])
ans(sprintf("predicted %s at %s = %g", d1_yn, d1_xn, d1_at), d1_b[1] + d1_b[2] * d1_at)
ans(sprintf("change in %s when %s goes %g -> %g", d1_yn, d1_xn, d1_from, d1_to), d1_b[2] * (d1_to - d1_from))
ans("R^2 (share explained)", summary(d1_reg)$r.squared); ans("R^2 in percent", 100 * summary(d1_reg)$r.squared)
if (!is.na(d1_row)) {
  ans(sprintf("row %d: actual %s", d1_row, d1_yn), model.response(model.frame(d1_reg))[d1_row])
  ans(sprintf("row %d: fitted (predicted) %s", d1_row, d1_yn), fitted(d1_reg)[d1_row])
  ans(sprintf("row %d: residual = actual - fitted", d1_row), resid(d1_reg)[d1_row]) }
d1_y <- model.response(model.frame(d1_reg))
ans("SSE (EXPLAINED sum of squares)", sum((fitted(d1_reg) - mean(d1_y))^2))
ans("SSR (RESIDUAL sum of squares)", sum(resid(d1_reg)^2))
ans("SST (TOTAL sum of squares)", sum((d1_y - mean(d1_y))^2))
ans("n (observations used)", nobs(d1_reg))

## ======================================================================
## [D2] DATA, CHANGE UNITS: measure y or x in other units, rerun -> new slope ----
## LOOKS LIKE: "Data: ceosal1. Run lm(salary ~ sales). If salary is measured in dollars
##   instead of thousands of dollars, what is the OLS slope?"   (PS8 #16)
## Thousands -> dollars: x 1000.  Percent -> decimal: x 1/100.  Years -> months: x 12.
## y times c -> slope times c.  x times c -> slope divided by c.  R^2 never changes.
## DEFAULT: new slope 15.47
# >> YOUR NUMBERS: change these lines
d2_data   <- "ceosal1"   # <-- CHANGE  dataset name, in quotes
d2_y      <- "salary"    # <-- CHANGE  y column
d2_x      <- "sales"     # <-- CHANGE  x column
d2_ytimes <- 1000        # <-- CHANGE  what y is MULTIPLIED by (1 = y unchanged)
d2_xtimes <- 1           # <-- CHANGE  what x is MULTIPLIED by (1 = x unchanged; divided by 100 -> 1/100)
# >> ANSWERS: nothing to change below
blk("D2", sprintf("%s on %s (%s), y x %g, x x %g", d2_y, d2_x, d2_data, d2_ytimes, d2_xtimes))
d2_df <- get(d2_data)
d2_old <- coef(lm(d2_df[[d2_y]] ~ d2_df[[d2_x]]))
d2_new <- coef(lm(I(d2_df[[d2_y]] * d2_ytimes) ~ I(d2_df[[d2_x]] * d2_xtimes)))
ans4("ORIGINAL slope", d2_old[2]); ans4("NEW slope (after rescaling)", d2_new[2])
ans4("ORIGINAL intercept", d2_old[1]); ans4("NEW intercept", d2_new[1])
pick("R^2", "unchanged (rescaling never changes R^2)")

## ======================================================================
## [D3] DATA, LOG-LEVEL: lm(log(y) ~ x) -> % change in y = 100 x slope x change in x ----
## LOOKS LIKE: "Data: wage1. Run lm(log(wage) ~ exper). By about what percent does
##   predicted wage change with 10 more years of experience?"   (PS8 #21, PS9 #6)
## DEFAULT: 4.36%
# >> YOUR NUMBERS: change these lines
d3_data    <- "wage1"              # <-- CHANGE  dataset name, in quotes
d3_formula <- log(wage) ~ exper    # <-- CHANGE  log(y) ~ x  (formula only: no lm(), no dataset name)
d3_dx      <- 10                   # <-- CHANGE  change in x, in x's units (falls = negative)
# >> ANSWERS: nothing to change below
d3_reg <- fit(d3_formula, d3_data); d3_b <- coef(d3_reg)[2]
d3_yn <- all.vars(d3_formula)[1]; d3_xn <- all.vars(d3_formula)[2]
blk("D3", sprintf("log(%s) on %s (%s)", d3_yn, d3_xn, d3_data))
ans4(sprintf("slope on %s", d3_xn), d3_b)
ans(sprintf("%% change in %s when %s %+g  (about)", d3_yn, d3_xn, d3_dx), 100 * d3_b * d3_dx)
ans(sprintf("  EXACT version (ONLY if the question says exact)"), 100 * (exp(d3_b * d3_dx) - 1))

## ======================================================================
## [D4] DATA, LEVEL-LOG: lm(y ~ log(x)) -> change in y = (slope / 100) x % change in x ----
## LOOKS LIKE: "Data: ceosal1. Run lm(salary ~ log(sales)). By about how many thousand
##   dollars does predicted salary change when sales rise by 10%?"   (PS9 #7)
## DEFAULT: 26.29 (in y's units: $1000s)
# >> YOUR NUMBERS: change these lines
d4_data    <- "ceosal1"              # <-- CHANGE  dataset name, in quotes
d4_formula <- salary ~ log(sales)    # <-- CHANGE  y ~ log(x)  (formula only: no lm(), no dataset name)
d4_pctx    <- 10                     # <-- CHANGE  % change in x (falls = negative)
# >> ANSWERS: nothing to change below
d4_reg <- fit(d4_formula, d4_data); d4_b <- coef(d4_reg)[2]
d4_yn <- all.vars(d4_formula)[1]; d4_xn <- all.vars(d4_formula)[2]
blk("D4", sprintf("%s on log(%s) (%s)", d4_yn, d4_xn, d4_data))
ans4(sprintf("slope on log(%s)", d4_xn), d4_b)
ans(sprintf("change in %s (its units) when %s %+g%%", d4_yn, d4_xn, d4_pctx), d4_b / 100 * d4_pctx)

## ======================================================================
## [D5] DATA, LOG-LOG: lm(log(y) ~ log(x)) -> % change in y = slope x % change in x ----
## LOOKS LIKE: "Data: bwght. Run the log-log regression of bwght on faminc. By about what
##   percent does birth weight change when income rises by 15%?"   (Q9 #3, PS10 #3)
## "Constant elasticity model" also means log-log. The slope IS the elasticity.
## DEFAULT: 0.31%
# >> YOUR NUMBERS: change these lines
d5_data    <- "bwght"                     # <-- CHANGE  dataset name, in quotes
d5_formula <- log(bwght) ~ log(faminc)    # <-- CHANGE  log(y) ~ log(x)  (formula only: no lm(), no dataset name)
d5_pctx    <- 15                          # <-- CHANGE  % change in x (falls = negative)
# >> ANSWERS: nothing to change below
d5_reg <- fit(d5_formula, d5_data); d5_b <- coef(d5_reg)[2]
d5_yn <- all.vars(d5_formula)[1]; d5_xn <- all.vars(d5_formula)[2]
blk("D5", sprintf("log(%s) on log(%s) (%s)", d5_yn, d5_xn, d5_data))
ans4(sprintf("slope = elasticity of %s w.r.t. %s", d5_yn, d5_xn), d5_b)
ans(sprintf("%% change in %s when %s %+g%%", d5_yn, d5_xn, d5_pctx), d5_b * d5_pctx)

## ======================================================================
## [D6] DATA, BY HAND: sigma-hat, SSR, SST_x, standard error of the slope ----
## (several x's and you need the se of ONE coefficient by hand? use [D14])
## LOOKS LIKE: "Data: wage1. Run lm(wage ~ educ). What is sigma-hat (the standard error of
##   the regression)?" / "SST_X for educ?" / "compute se(b1) by hand"   (PS9 #18-19, PS10 #10)
## DEFAULTS: sigma-hat 3.38 | SST_x 4025.43 | se 0.05
# >> YOUR NUMBERS: change these lines
d6_data    <- "wage1"        # <-- CHANGE  dataset name, in quotes
d6_formula <- wage ~ educ    # <-- CHANGE  y ~ x  (formula only: no lm(), no dataset name)
# >> ANSWERS: nothing to change below
d6_reg <- fit(d6_formula, d6_data); d6_xn <- all.vars(d6_formula)[2]
d6_x <- model.frame(d6_reg)[[2]]; d6_SSR <- sum(resid(d6_reg)^2); d6_df <- d6_reg$df.residual
d6_SST <- sum((d6_x - mean(d6_x))^2)
blk("D6", sprintf("%s by hand (%s)", deparse(d6_formula), d6_data))
ans("n", nobs(d6_reg)); ans("df = n - k - 1", d6_df)
ans("SSR (sum of squared residuals)", d6_SSR)
ans("sigma^2-hat = SSR / df", d6_SSR / d6_df)
ans("sigma-hat = sqrt(SSR / df)  (= Residual standard error)", sqrt(d6_SSR / d6_df))
ans(sprintf("SST_x = total variation in %s", d6_xn), d6_SST)
ans4("se(slope) = sigma-hat / sqrt(SST_x)", sqrt(d6_SSR / d6_df) / sqrt(d6_SST))
ans4("check: R's Std. Error for the slope", summary(d6_reg)$coefficients[2, 2])

## ======================================================================
## [D7] DATA, MULTIPLE REGRESSION: coefficients, prediction, change holding others fixed ----
## LOOKS LIKE: "Data: wage1. Regress wage on educ, exper and tenure. Predicted hourly wage of
##   a worker with 16 educ, 5 exper, 2 tenure?" / "change when exper rises by 10, holding
##   educ and tenure fixed?"   (Q9 #10-11, PS10 #14-15)
## Values go in the SAME ORDER as the x's in the formula. "Holding fixed" = change of 0.
## DEFAULTS: prediction 7.16 | change 0.22
# >> YOUR NUMBERS: change these lines
d7_data    <- "wage1"                      # <-- CHANGE  dataset name, in quotes
d7_formula <- wage ~ educ + exper + tenure # <-- CHANGE  y ~ x1 + x2 + ...  (formula only: no lm(), no dataset name)
d7_at      <- c(16, 5, 2)                  # <-- CHANGE  prediction: the x VALUES, formula order
d7_dx      <- c(0, 10, 0)                  # <-- CHANGE  change: how much each x CHANGES (fixed = 0)
# >> ANSWERS: nothing to change below
d7_reg <- fit(d7_formula, d7_data); d7_b <- coef(d7_reg)
d7_xn <- names(d7_b)[-1]; d7_yn <- all.vars(d7_formula)[1]
nx(d7_at, d7_xn, "d7_at"); nx(d7_dx, d7_xn, "d7_dx")
blk("D7", sprintf("%s (%s)", deparse(d7_formula), d7_data))
for (i in seq_along(d7_b)) ans4(sprintf("coefficient on %s", names(d7_b)[i]), d7_b[i])
ans(sprintf("predicted %s at %s", d7_yn, paste(d7_xn, d7_at, sep = " = ", collapse = ", ")), d7_b[1] + sum(d7_b[-1] * d7_at))
ans(sprintf("change in %s when %s", d7_yn, paste(sprintf("%s %+g", d7_xn, d7_dx)[d7_dx != 0], collapse = ", ")), sum(d7_b[-1] * d7_dx))
ans("R^2", summary(d7_reg)$r.squared)

## ======================================================================
## [D8] DATA, log(y) MULTIPLE REGRESSION: % change, or predicted DOLLARS with exp() ----
## LOOKS LIKE: "Run lm(log(wage) ~ educ + exper + tenure). By about what percent does wage
##   change when exper rises 2 and tenure rises 1?" / "predicted hourly wage, in dollars,
##   at 12 educ, 10 exper, 3 tenure?"   (PS11 #2-3, PS10 #16-17)
## "In dollars" with log(y) -> exp() of the predicted log. That's the DOLLARS line.
## DEFAULTS: 3.03% | predicted log(wage) 1.50 | $4.46
# >> YOUR NUMBERS: change these lines
d8_data    <- "wage1"                           # <-- CHANGE  dataset name, in quotes
d8_formula <- log(wage) ~ educ + exper + tenure # <-- CHANGE  log(y) ~ x1 + x2 + ...  (formula only: no lm(), no dataset name)
d8_dx      <- c(0, 2, 1)                        # <-- CHANGE  % question: how much each x CHANGES (fixed = 0)
d8_at      <- c(12, 10, 3)                      # <-- CHANGE  dollars question: the x VALUES, formula order
# >> ANSWERS: nothing to change below
d8_reg <- fit(d8_formula, d8_data); d8_b <- coef(d8_reg)
d8_xn <- names(d8_b)[-1]; d8_yn <- all.vars(d8_formula)[1]
nx(d8_at, d8_xn, "d8_at"); nx(d8_dx, d8_xn, "d8_dx")
blk("D8", sprintf("%s (%s)", deparse(d8_formula), d8_data))
for (i in seq_along(d8_b)) ans4(sprintf("coefficient on %s", names(d8_b)[i]), d8_b[i])
ans(sprintf("%% change in %s when %s", d8_yn, paste(sprintf("%s %+g", d8_xn, d8_dx)[d8_dx != 0], collapse = ", ")), 100 * sum(d8_b[-1] * d8_dx))
d8_lp <- d8_b[1] + sum(d8_b[-1] * d8_at)
ans(sprintf("predicted log(%s) (NOT dollars)", d8_yn), d8_lp)
ans(sprintf("predicted %s in DOLLARS = exp(%.3f)", d8_yn, d8_lp), exp(d8_lp))

## ======================================================================
## [D9] DATA: predicted y at the sample means = mean of y ----
## LOOKS LIKE: "Run lm(colGPA ~ ACT + hsGPA). Compute predicted colGPA at ACT = mean(ACT)
##   and hsGPA = mean(hsGPA). Why is it the same as mean(colGPA)?"   (PS11 #5)
## Why: the OLS line always passes through the point of means.   DEFAULT: 3.06
# >> YOUR NUMBERS: change these lines
d9_data    <- "gpa1"                 # <-- CHANGE  dataset name, in quotes
d9_formula <- colGPA ~ ACT + hsGPA   # <-- CHANGE  y ~ x1 + x2 + ...  (formula only: no lm(), no dataset name)
# >> ANSWERS: nothing to change below
d9_reg <- fit(d9_formula, d9_data); d9_mf <- model.frame(d9_reg)
d9_xbar <- colMeans(d9_mf[-1]); d9_yn <- all.vars(d9_formula)[1]
blk("D9", sprintf("%s at the means (%s)", deparse(d9_formula), d9_data))
for (v in names(d9_xbar)) ans(sprintf("mean of %s", v), d9_xbar[v])
ans(sprintf("predicted %s at the means", d9_yn), coef(d9_reg)[1] + sum(coef(d9_reg)[-1] * d9_xbar))
ans(sprintf("mean of %s (always the same number)", d9_yn), mean(d9_mf[[1]]))

## ======================================================================
## [D10] DATA, OMITTED-VARIABLE BIAS: simple vs multiple slope, delta1, b2-hat x delta1 ----
## LOOKS LIKE: "Data: bwght. lm(bwght ~ cigs) slope?" / "add faminc: slope on cigs?" /
##   "regress faminc on cigs; compute b2-hat x delta1"   (PS11 #12-14, PS10 #21)
## x1 = the variable in BOTH regressions. x2 = the one left out of the simple regression.
## DEFAULTS: simple -0.51 | multiple -0.46 | b2 0.09 | delta1 -0.54 | b2 x delta1 -0.05
# >> YOUR NUMBERS: change these lines
d10_data <- "bwght"     # <-- CHANGE  dataset name, in quotes
d10_y    <- "bwght"     # <-- CHANGE  y column
d10_x1   <- "cigs"      # <-- CHANGE  x1: the variable whose slope they ask about
d10_x2   <- "faminc"    # <-- CHANGE  x2: the variable that gets added / left out
# >> ANSWERS: nothing to change below
d10_df <- get(d10_data)
d10_s <- coef(lm(reformulate(d10_x1, d10_y), data = d10_df))
d10_m <- coef(lm(reformulate(c(d10_x1, d10_x2), d10_y), data = d10_df))
d10_d <- coef(lm(reformulate(d10_x1, d10_x2), data = d10_df))
blk("D10", sprintf("leaving %s out of %s ~ %s (%s)", d10_x2, d10_y, d10_x1, d10_data))
ans4(sprintf("SIMPLE slope on %s (b1-tilde)", d10_x1), d10_s[2])
ans4(sprintf("MULTIPLE slope on %s, with %s (b1-hat)", d10_x1, d10_x2), d10_m[2])
ans4(sprintf("coefficient on %s in multiple (b2-hat)", d10_x2), d10_m[3])
ans4(sprintf("delta1 = slope of %s ~ %s", d10_x2, d10_x1), d10_d[2])
ans4("b2-hat x delta1 (the omitted-variable part)", d10_m[3] * d10_d[2])
ans4("check: simple - multiple (same number)", d10_s[2] - d10_m[2])
pick(sprintf("leaving %s out pushes the %s slope", d10_x2, d10_x1),
     ifelse(d10_m[3] * d10_d[2] > 0, "UP (simple slope too big)", "DOWN (simple slope too small / too negative)"))

## ======================================================================
## [D11] DATA, PERFECT COLLINEARITY: R reports NA ----
## LOOKS LIKE: "vote1: totexpend <- expendA + expendB; lm(voteA ~ expendA + expendB +
##   totexpend). What does R report for totexpend?"   (PS11 #8)
## ANSWER: NA. R drops it because it's an exact linear function of the others (MLR.3 fails).
d11_v <- vote1; d11_v$totexpend <- d11_v$expendA + d11_v$expendB
blk("D11", "voteA ~ expendA + expendB + totexpend (vote1)")
print(coef(lm(voteA ~ expendA + expendB + totexpend, data = d11_v)))
pick("coefficient on the exact combination", "NA (dropped: perfect collinearity, MLR.3)")

## ======================================================================
## [D12] DATA, t-TEST: t-statistic, critical value, decision (D21-D22) ----
## LOOKS LIKE: "Run lm(log(wage) ~ educ + exper + tenure). Test H0: b_exper = 0 vs
##   H1: b_exper > 0 at 5%."   (Example 4.1)
## "raises / positive" -> H1: b > 0.  "lowers / negative" -> H1: b < 0.
## DEFAULTS: t 2.39 | c (one-sided 5%) 1.65 -> reject for H1: b > 0
# >> YOUR NUMBERS: change these lines
d12_data    <- "wage1"                           # <-- CHANGE  dataset name, in quotes
d12_formula <- log(wage) ~ educ + exper + tenure # <-- CHANGE  the regression  (formula only: no lm(), no dataset name)
d12_var     <- "exper"                           # <-- CHANGE  the variable being tested, in quotes
d12_h0      <- 0                                 # <-- CHANGE  null value (usually 0)
d12_alpha   <- 0.05                              # <-- CHANGE  significance level (5% = 0.05)
# >> ANSWERS: nothing to change below
d12_reg <- fit(d12_formula, d12_data); d12_s <- summary(d12_reg)$coefficients
d12_b <- d12_s[d12_var, "Estimate"]; d12_se <- d12_s[d12_var, "Std. Error"]
d12_t <- (d12_b - d12_h0) / d12_se; d12_df <- d12_reg$df.residual
d12_c1 <- qt(1 - d12_alpha, d12_df); d12_c2 <- qt(1 - d12_alpha / 2, d12_df)
blk("D12", sprintf("t-test on %s in %s (%s)", d12_var, deparse(d12_formula), d12_data))
ans4(sprintf("estimate on %s", d12_var), d12_b); ans4(sprintf("se of the %s estimate (NOT sigma-hat)", d12_var), d12_se)
ans(sprintf("t = (%.4f - %g) / %.4f", d12_b, d12_h0, d12_se), d12_t)
ans(sprintf("df = n - k - 1 = %d - %d - 1", nobs(d12_reg), length(coef(d12_reg)) - 1), d12_df)
ans(sprintf("critical c, ONE-sided %g%%", 100 * d12_alpha), d12_c1)
ans(sprintf("critical c, TWO-sided %g%%", 100 * d12_alpha), d12_c2)
ans("p-value, two-sided", 2 * pt(-abs(d12_t), d12_df))
ans("sigma-hat = standard error of the REGRESSION", summary(d12_reg)$sigma)
pick(sprintf("H1: %s >  %g  (reject if t > c)", d12_var, d12_h0), ifelse(d12_t > d12_c1, "REJECT H0", "fail to reject H0"))
pick(sprintf("H1: %s <  %g  (reject if t < -c)", d12_var, d12_h0), ifelse(d12_t < -d12_c1, "REJECT H0", "fail to reject H0"))
pick(sprintf("H1: %s != %g  (reject if |t| > c)", d12_var, d12_h0), ifelse(abs(d12_t) > d12_c2, "REJECT H0", "fail to reject H0"))

## ======================================================================
## [D14] DATA, se OF A MULTIPLE-REGRESSION COEFFICIENT BY HAND (PS12 #8-14) ----
## LOOKS LIKE: "Data: hprice1. reg <- lm(price ~ sqrft + bdrms + lotsize). Find the standard error
##   of the bdrms coefficient by hand: df? sigma-hat? SST_j? R_j^2? se?"   (PS12 #8-14; exam: #9, #12)
## se(b_j) = sigma-hat / sqrt( SST_j x (1 - R_j^2) )
##   x_j    = the x whose coefficient you want the se of
##   R_j^2  = R^2 from regressing x_j on the OTHER x's (y is NOT in it)
##   SST_j  = sum((x_j - mean(x_j))^2), on the SAME rows the regression used (NA rows dropped)
## DEFAULTS (PS12): df 84 | sigma-hat 59.83 | SST_j 61.59 | R_j^2 0.28 | se 9.01
# >> YOUR NUMBERS: change these lines
d14_data    <- "hprice1"                       # <-- CHANGE  dataset name, in quotes
d14_formula <- price ~ sqrft + bdrms + lotsize # <-- CHANGE  the full regression  (formula only: no lm(), no dataset name)
d14_xj      <- "bdrms"                         # <-- CHANGE  x_j: the variable whose se they want, in quotes
# >> ANSWERS: nothing to change below
d14_reg <- fit(d14_formula, d14_data); d14_mf <- model.frame(d14_reg)   # rows actually used
d14_others <- setdiff(names(d14_mf)[-1], d14_xj)
d14_SSR <- sum(resid(d14_reg)^2); d14_df <- d14_reg$df.residual; d14_sig <- sqrt(d14_SSR / d14_df)
d14_x <- d14_mf[[d14_xj]]; d14_SST <- sum((d14_x - mean(d14_x))^2)
d14_R2 <- summary(lm(reformulate(d14_others, d14_xj), data = d14_mf))$r.squared
blk("D14", sprintf("se of the %s coefficient in %s (%s)", d14_xj, deparse(d14_formula), d14_data))
ans(sprintf("n (rows used) = %d,  K = %d slopes", nobs(d14_reg), length(coef(d14_reg)) - 1), nobs(d14_reg))
ans(sprintf("df = n - K - 1 = %d - %d - 1", nobs(d14_reg), length(coef(d14_reg)) - 1), d14_df)
ans("SSR = sum(residuals^2)", d14_SSR)
ans("sigma-hat = sqrt(SSR / df)  (= Residual standard error)", d14_sig)
ans(sprintf("SST_j = total variation of %s", d14_xj), d14_SST)
ans(sprintf("R_j^2 = R^2 of %s ~ %s", d14_xj, paste(d14_others, collapse = " + ")), d14_R2)
ans("VIF = 1 / (1 - R_j^2)", 1 / (1 - d14_R2))
ans(sprintf("se(b_%s) = sigma-hat / sqrt(SST_j x (1 - R_j^2))", d14_xj), d14_sig / sqrt(d14_SST * (1 - d14_R2)))
ans(sprintf("check: summary(reg) Std. Error for %s", d14_xj), summary(d14_reg)$coefficients[d14_xj, "Std. Error"])

## ======================================================================
## [D13] REG(): EVERYTHING for one regression in one line ----
## Prints coefficients, se, t, p, CIs, R^2, SST/SSE/SSR, sigma-hat, and (if you give them)
## a prediction, a change, the residual of a row and a t-test. Delete what you don't need.
##   at   = list(educ = 16, exper = 4, tenure = 2)  or  c(16, 4, 2)   (formula order)
##   from = list(educ = 12), to = list(educ = 13)   (a change in educ only)
##   row  = 2      test = "exper"      alpha = 0.05
blk("D13", "REG() example")
REG(log(wage) ~ educ + exper + tenure, data = wage1,          # <-- CHANGE formula, data
    at = list(educ = 16, exper = 4, tenure = 2),              # <-- CHANGE (or delete)
    from = list(educ = 12), to = list(educ = 13),             # <-- CHANGE (or delete)
    row = 2, test = "exper")                                  # <-- CHANGE (or delete)

# PART 2 - NUMBERS IN THE QUESTION ##########################################
cat("\n#################### PART 2 - NUMBERS IN THE QUESTION ####################\n")

## ######################################################################
## UNIVERSAL SOLVERS [S1]-[S7]: USE THESE WHEN THE QUESTION IS WORDED NEW
## Type EVERY number the question gives; leave the rest NA. Each solver fills in
## everything it can and prints ALL related answers, so a flipped direction or a
## merged step still lands on a printed line.
## TRIAGE every question (20 seconds):
##   1. ASKED: what number do they want? (sd? SSR? % change? residual?)
##   2. GIVEN: list the numbers they hand you.
##   3. CONNECT: ASK() or pick the solver that links given -> asked.
##   4. CHECK: correlation in [-1, 1]? % vs units? dollars from log(y) need exp()?
## ######################################################################

## ======================================================================
## [S1] SUMS-OF-SQUARES SOLVER: SST, SSE, SSR, R^2 (any direction) ----
## LOOKS LIKE: "SSE = 135, R^2 = 0.18. Find SSR." / "SST = 241, SSR = 113. Find SSE."
##   / "n = 44, S_y^2 = 7. Find SST." / "What fraction is UNEXPLAINED?"   (Exam I Q24-25, PS8 #9-10)
## SST = SSE + SSR      R^2 = SSE / SST      SST = (n - 1) x (sample variance of y)
## SSE = EXPLAINED.  SSR = RESIDUAL (unexplained).   DEFAULT (Exam I Q25): SSR 615.00
# >> YOUR NUMBERS: type what's GIVEN, leave the rest NA
s1_SST <- NA     # <-- CHANGE  total sum of squares
s1_SSE <- 135    # <-- CHANGE  EXPLAINED sum of squares
s1_SSR <- NA     # <-- CHANGE  RESIDUAL sum of squares
s1_R2  <- 0.18   # <-- CHANGE  R^2 as a decimal (18% -> 0.18)
s1_n   <- NA     # <-- CHANGE  n, if given
s1_S2y <- NA     # <-- CHANGE  sample VARIANCE of y, if given
s1_k   <- NA     # <-- CHANGE  number of slopes k (only for ADJUSTED R^2)
# >> ANSWERS: nothing to change below
s1_given <- c(SST = !is.na(s1_SST), SSE = !is.na(s1_SSE), SSR = !is.na(s1_SSR), R2 = !is.na(s1_R2))
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
s1_tag <- function(k) if (s1_given[k]) "(given)" else "(computed)"
blk("S1", "sums of squares")
ans(paste("SST, TOTAL", s1_tag("SST")), s1_SST)
ans(paste("SSE, EXPLAINED", s1_tag("SSE")), s1_SSE)
ans(paste("SSR, RESIDUAL / unexplained", s1_tag("SSR")), s1_SSR)
ans(paste("R^2, share EXPLAINED", s1_tag("R2")), s1_R2); ans("R^2 in percent", 100 * s1_R2)
ans("1 - R^2, share UNEXPLAINED", 1 - s1_R2)
if (!is.na(s1_n)) ans("sample variance of y = SST / (n - 1)", s1_SST / (s1_n - 1))
if (!is.na(s1_n) && !is.na(s1_k)) ans("ADJUSTED R^2 = 1 - (1-R^2)(n-1)/(n-k-1)", 1 - (1 - s1_R2) * (s1_n - 1) / (s1_n - s1_k - 1))

## ======================================================================
## [S2] VARIANCE / SD / SE SOLVER for the OLS slope ----
## LOOKS LIKE: "sigma = 20, n = 6, S_X^2 = 2: sd(b1)?" / "SSR = 437, n = 13, SST_X = 12: se?"
##   / "sigma-hat = 9.4, n = 23, S_X = 0.7: se?" / "sigma^2 = 66, SST = 53: Var?"   (PS9, PS10, Q8, Q9)
## Var(b1) = sigma^2 / SST_x        sigma^2-hat = SSR / (n - k - 1)       SST_x = (n - 1) x S_x^2
## DEFAULT (PS9 #16): se 1.82
# >> YOUR NUMBERS: type what's GIVEN, leave the rest NA
s2_sigma  <- NA     # <-- CHANGE  error SD: sigma or sigma-hat
s2_sigma2 <- NA     # <-- CHANGE  OR error VARIANCE: sigma^2 or sigma^2-hat
s2_SSR    <- 437    # <-- CHANGE  OR SSR (then sigma^2-hat = SSR / (n - k - 1))
s2_n      <- 13     # <-- CHANGE  n
s2_k      <- 1      # <-- CHANGE  number of slopes (1 = simple regression)
s2_SSTx   <- 12     # <-- CHANGE  SST_x, if given
s2_x      <- NULL   # <-- CHANGE  OR the raw x values, e.g. c(3, 4, 7, 8, 9)
s2_SX     <- NA     # <-- CHANGE  OR the sample SD of x, S_x (gets squared)
s2_SX2    <- NA     # <-- CHANGE  OR the sample VARIANCE of x, S_x^2
s2_Rj2    <- 0      # <-- CHANGE  multiple regression only: R^2 of x_j on the other x's
# >> ANSWERS: nothing to change below
blk("S2", "variance / sd / se of the slope")
if (!is.na(s2_SSTx) && (!is.null(s2_x) || !is.na(s2_SX) || !is.na(s2_SX2)))
  info("!! WARNING: you typed SST_x AND x / S_x.", "Set the one the question didn't give to NA.")
if (sum(!is.na(c(s2_sigma, s2_sigma2, s2_SSR))) > 1)
  info("!! WARNING: more than one of sigma / sigma^2 / SSR typed.", "Keep only the one the question gives.")
if (!is.na(s2_SSTx) && is.null(s2_x)) ans("SST_x (typed in)", s2_SSTx)
if (!is.null(s2_x)) { s2_SSTx <- sum((s2_x - mean(s2_x))^2); if (is.na(s2_n)) s2_n <- length(s2_x)
  ans("SST_x from the x values", s2_SSTx) }
if (is.na(s2_SSTx) && !is.na(s2_SX2)) { s2_SSTx <- (s2_n - 1) * s2_SX2; ans(sprintf("SST_x = (%g - 1) x %g", s2_n, s2_SX2), s2_SSTx) }
if (is.na(s2_SSTx) && !is.na(s2_SX))  { s2_SSTx <- (s2_n - 1) * s2_SX^2; ans(sprintf("SST_x = (%g - 1) x %g^2", s2_n, s2_SX), s2_SSTx) }
if (is.na(s2_sigma2) && !is.na(s2_sigma)) s2_sigma2 <- s2_sigma^2
s2_df <- s2_n - s2_k - 1
if (is.na(s2_sigma2) && !is.na(s2_SSR)) { s2_sigma2 <- s2_SSR / s2_df
  ans(sprintf("df = n - k - 1 = %g - %g - 1", s2_n, s2_k), s2_df)
  ans(sprintf("sigma^2-hat = SSR / df = %g / %g", s2_SSR, s2_df), s2_sigma2) } else ans("sigma^2", s2_sigma2)
ans("sigma (or sigma-hat) = sqrt(sigma^2)", sqrt(s2_sigma2))
if (s2_Rj2 != 0) ans(sprintf("VIF = 1 / (1 - %g)", s2_Rj2), 1 / (1 - s2_Rj2))
s2_var <- s2_sigma2 / (s2_SSTx * (1 - s2_Rj2))
ans(sprintf("Var(b1) = %.4g / %.4g%s", s2_sigma2, s2_SSTx, if (s2_Rj2 != 0) sprintf(" x (1 - %g)", s2_Rj2) else ""), s2_var)
ans("sd(b1) = se(b1) = sqrt(Var)", sqrt(s2_var))
ans("se(b1) if the sample were 2x as large", sqrt(s2_var) / sqrt(2))

## ======================================================================
## [S3] UNITS SOLVER: rescale y and/or x in ANY of the 4 models -> new intercept, slope ----
## LOOKS LIKE: "slope 0.58; x divided by 1,000: new slope?" / "y times 1,000" /
##   "log(salary) = 3.36 + 0.44 log(sales); salary in dollars: new intercept?"  (PS8 #13-16, PS9 #1,#3)
## Thousands -> dollars: 1000.  Dollars -> thousands: 1/1000.  Percent -> decimal: 1/100.  Years -> months: 12.
## R^2 NEVER changes.   DEFAULT (PS9 #3): intercept 10.27, slope 0.44
# >> YOUR NUMBERS: change these lines
s3_model <- "log-log"  # <-- CHANGE  "level-level" | "log-level" (log y) | "level-log" (log x) | "log-log"
s3_b0    <- 3.36       # <-- CHANGE  original intercept (0 if not given)
s3_b1    <- 0.44       # <-- CHANGE  original slope
s3_cy    <- 1000       # <-- CHANGE  what y is MULTIPLIED by (1 = y unchanged)
s3_cx    <- 1          # <-- CHANGE  what x is MULTIPLIED by (1 = x unchanged)
# >> ANSWERS: nothing to change below
s3_new <- switch(s3_model,
  "level-level" = c(s3_cy * s3_b0, s3_cy * s3_b1 / s3_cx),
  "log-level"   = c(s3_b0 + log(s3_cy), s3_b1 / s3_cx),
  "level-log"   = c(s3_cy * (s3_b0 - s3_b1 * log(s3_cx)), s3_cy * s3_b1),
  "log-log"     = c(s3_b0 + log(s3_cy) - s3_b1 * log(s3_cx), s3_b1))
blk("S3", sprintf("%s model, y x %g, x x %g", s3_model, s3_cy, s3_cx))
ans4(sprintf("NEW intercept (was %g)", s3_b0), s3_new[1]); ans4(sprintf("NEW slope (was %g)", s3_b1), s3_new[2])
pick("what changed", paste(ifelse(abs(s3_new[1] - s3_b0) > 1e-9, "intercept CHANGES", "intercept same"),
                           ifelse(abs(s3_new[2] - s3_b1) > 1e-9, "slope CHANGES", "slope same"), "R^2 same", sep = "; "))

## ======================================================================
## [S4] LOG / PERCENT READER (Table 2.3): prints all 4 models, you pick by WHERE the log is ----
## LOOKS LIKE: any "by about what percent / how many units" question with logs; also
##   "the rate rises from 5.6% to 6.6%: percent change? percentage-point change?"
## log on y -> answer in PERCENT.  log on x -> x moves in PERCENT.
## DEFAULTS (slope 0.083): level 0.08 | log-level 8.30% | level-log 0.01 | log-log 0.83%
# >> YOUR NUMBERS: change these lines
s4_b    <- 0.083   # <-- CHANGE  the slope
s4_dx   <- 1       # <-- CHANGE  change in x in x's UNITS (log-level, level-level; falls = negative)
s4_pctx <- 10      # <-- CHANGE  change in x in PERCENT (level-log, log-log; falls = negative)
s4_old  <- NA      # <-- CHANGE  ONLY for "a rate went from 5.6% to 6.6%": the rate BEFORE
s4_new  <- NA      # <-- CHANGE  ... and the rate AFTER
# >> ANSWERS: nothing to change below
blk("S4", sprintf("reading a slope of %g", s4_b))
part("pick the model by where the log is")
ans(sprintf("y = ... + b x        Dy = %g x %g", s4_b, s4_dx), s4_b * s4_dx)
ans(sprintf("log(y) = ... + b x   %%Dy = 100 x %g x %g", s4_b, s4_dx), 100 * s4_b * s4_dx)
ans("log(y) = ... + b x   %Dy EXACT", 100 * (exp(s4_b * s4_dx) - 1))
ans(sprintf("y = ... + b log(x)   Dy = %g/100 x %g%%", s4_b, s4_pctx), s4_b / 100 * s4_pctx)
ans(sprintf("log(y) = ... + b log(x)  %%Dy = %g x %g%%", s4_b, s4_pctx), s4_b * s4_pctx)
if (!is.na(s4_old) && !is.na(s4_new)) {
  part(sprintf("a rate going from %g%% to %g%%", s4_old, s4_new))
  ans(sprintf("PERCENT change = 100 x (%g - %g) / %g", s4_new, s4_old, s4_old), 100 * (s4_new - s4_old) / s4_old)
  ans(sprintf("PERCENTAGE-POINT change = %g - %g", s4_new, s4_old), s4_new - s4_old) }

## ======================================================================
## [S5] PROBABILITY SOLVER: moments, transforms, Var of sums, probability tables ----
## LOOKS LIKE: "E[X]=3, E[X^2]=27: sd of 3X-2?" / "Var(X)=8, Var(Y)=6, Cov=-2.9: Var(2X-2Y)?"
##   / "joint distribution below: Cor(X,Y)?" / "Y takes 6, 14, 34 w.p. .5 .3 .2: E[3Y+4]?"  (Exam I Q18-21, PS8 #3-5)
## "4 - 2X" means a = -2, b = 4 (the number in front of X is a). Unknown things stay NA.
## Four PARTS below; change only the part your question is about.
## DEFAULTS (Exam I): sd(3X - 2) 12.73 | Var(2X - 2Y) 79.20 | Cor -0.43 | E[3Y + 4] 46.00
# >> PART A: one variable X and a transform aX + b
s5_EX   <- 3     # <-- CHANGE  E[X]
s5_EX2  <- 27    # <-- CHANGE  E[X^2]
s5_VarX <- NA    # <-- CHANGE  OR Var(X) directly (then E[X^2] is ignored)
s5_a    <- 3     # <-- CHANGE  a in aX + b (the number in front of X, with its sign)
s5_b    <- -2    # <-- CHANGE  b in aX + b
blk("S5", "probability")
part(sprintf("PART A: one variable X, transform %s", fx(s5_a, s5_b)))
if (is.na(s5_VarX)) { s5_VarX <- s5_EX2 - s5_EX^2
  ans(sprintf("Var(X) = %g - %g^2", s5_EX2, s5_EX), s5_VarX) } else ans("Var(X) (given)", s5_VarX)
ans("sd(X)", sqrt(s5_VarX))
ans(sprintf("E[%s]", fx(s5_a, s5_b)), s5_a * s5_EX + s5_b)
ans(sprintf("Var(%s) = (%g)^2 x Var(X)", fx(s5_a, s5_b), s5_a), s5_a^2 * s5_VarX)
ans(sprintf("sd(%s) = |%g| x sd(X)", fx(s5_a, s5_b), s5_a), abs(s5_a) * sqrt(s5_VarX))
# >> PART B: two variables, Var(c1 X + c2 Y)
s5_vx  <- 8      # <-- CHANGE  Var(X)
s5_vy  <- 6      # <-- CHANGE  Var(Y)
s5_cov <- -2.9   # <-- CHANGE  Cov(X, Y)
s5_c1  <- 2      # <-- CHANGE  c1, the number in front of X
s5_c2  <- -2     # <-- CHANGE  c2, the number in front of Y (a minus goes INTO c2)
part(sprintf("PART B: two variables, Var(X)=%g Var(Y)=%g Cov=%g", s5_vx, s5_vy, s5_cov))
ans(sprintf("Var(%s%s%s)", fx(s5_c1, 0), if (s5_c2 < 0) " - " else " + ", fx(abs(s5_c2), 0, "Y")),
    s5_c1^2 * s5_vx + s5_c2^2 * s5_vy + 2 * s5_c1 * s5_c2 * s5_cov)
ans("Cor(X,Y) = Cov / (sd(X) sd(Y))", s5_cov / sqrt(s5_vx * s5_vy))
# >> PART C: a JOINT probability table of X and Y (one row per cell)
s5_x <- c(1, 4, 5, 6)            # <-- CHANGE  the x column
s5_y <- c(4, 7, 4, 2)            # <-- CHANGE  the y column
s5_p <- c(0.1, 0.4, 0.3, 0.2)    # <-- CHANGE  the probability column
part("PART C: joint probability table of X and Y")
s5_EXt <- sum(s5_x * s5_p); s5_EYt <- sum(s5_y * s5_p)
s5_Vx <- sum(s5_x^2 * s5_p) - s5_EXt^2; s5_Vy <- sum(s5_y^2 * s5_p) - s5_EYt^2
s5_C <- sum(s5_x * s5_y * s5_p) - s5_EXt * s5_EYt
ans("table E[X]", s5_EXt); ans("table E[Y]", s5_EYt); ans("table E[XY]", sum(s5_x * s5_y * s5_p))
ans("table Var(X)", s5_Vx); ans("table Var(Y)", s5_Vy)
ans("table Cov(X,Y) = E[XY] - E[X]E[Y]", s5_C); ans("table Cor(X,Y)", s5_C / sqrt(s5_Vx * s5_Vy))
# >> PART D: ONE variable Y with values and probabilities
s5_v  <- c(6, 14, 34)        # <-- CHANGE  the values Y takes
s5_pv <- c(0.5, 0.3, 0.2)    # <-- CHANGE  their probabilities
s5_A  <- 3                   # <-- CHANGE  A in E[AY + B]
s5_B  <- 4                   # <-- CHANGE  B in E[AY + B]
part(sprintf("PART D: Y takes %s with probabilities %s", paste(s5_v, collapse = ", "), paste(s5_pv, collapse = ", ")))
s5_E <- sum(s5_v * s5_pv)
ans("E[Y]", s5_E); ans("Var(Y)", sum(s5_v^2 * s5_pv) - s5_E^2)
ans(sprintf("E[%s]", fx(s5_A, s5_B, "Y")), s5_A * s5_E + s5_B)

## ======================================================================
## [S6] SMALL-SAMPLE OLS SOLVER: type x and y, get EVERYTHING ----
## LOOKS LIKE: "For x = (...), y = (...): slope? intercept? residual of obs 3? predict at x = 5?
##   sum x*uhat? R^2? sample sd / cov / cor?"   (Exam I Q16-17, 22-23, 28; PS8 #6, #8)
## DEFAULT (Exam I Q23): residual of observation 3 = 1.80
# >> YOUR NUMBERS: change these lines
s6_x  <- c(4, 6, 7, 8, 10)   # <-- CHANGE  the x values
s6_y  <- c(4, 6, 7, 1, 8)    # <-- CHANGE  the y values (same order)
s6_i  <- 3                   # <-- CHANGE  which observation (for its fitted value / residual)
s6_x0 <- 7                   # <-- CHANGE  x to predict at
# >> ANSWERS: nothing to change below
s6_reg <- lm(s6_y ~ s6_x); s6_b <- coef(s6_reg)
blk("S6", sprintf("x = (%s), y = (%s)", paste(s6_x, collapse = ", "), paste(s6_y, collapse = ", ")))
part("the sample")
ans("mean of x", mean(s6_x)); ans("mean of y", mean(s6_y))
ans("sd of x", sd(s6_x)); ans("sd of y", sd(s6_y)); ans("variance of x", var(s6_x)); ans("variance of y", var(s6_y))
ans("covariance of x and y", cov(s6_x, s6_y)); ans("correlation of x and y", cor(s6_x, s6_y))
part("the OLS line")
ans4("slope b1", s6_b[2]); ans4("intercept b0", s6_b[1])
ans(sprintf("predicted y at x = %g", s6_x0), s6_b[1] + s6_b[2] * s6_x0)
if (!is.na(s6_i)) {
  part(sprintf("observation %d: x = %g, y = %g", s6_i, s6_x[s6_i], s6_y[s6_i]))
  ans(sprintf("fitted y for observation %d", s6_i), fitted(s6_reg)[s6_i])
  ans(sprintf("residual of observation %d = y - fitted", s6_i), resid(s6_reg)[s6_i]) }
part("always-true properties and sums of squares")
ans("sum of residuals (always 0)", sum(resid(s6_reg))); ans("sum of x * residual (always 0)", sum(s6_x * resid(s6_reg)))
ans("SST (total)", sum((s6_y - mean(s6_y))^2)); ans("SSE (explained)", sum((fitted(s6_reg) - mean(s6_y))^2))
ans("SSR (residual)", sum(resid(s6_reg)^2)); ans("R^2", summary(s6_reg)$r.squared)

## ======================================================================
## [S7] EQUATION SOLVER: prediction, change, y-bar, and the log(y) versions ----
## LOOKS LIKE: any "y-hat = b0 + b1 x1 + b2 x2 ..." question: predicted value / change /
##   sample mean of y / % change / predicted $ when y is logged    (Q9 #8-9, PS11 #1, #6)
## PREDICTION keeps b0.  CHANGE drops b0.  y-bar = b0 + b1 x1-bar + ...
## BACKWARDS (they give the y-hat or the change and want an x): use s7_yhat / s7_dy below.
## DEFAULTS (y-hat = 4 + 2.9 x1 - 0.6 x2): prediction 5.70 | change 4.70 | y-bar 17.30
# >> YOUR NUMBERS: change these lines (one number per x, same order)
s7_b0   <- 4             # <-- CHANGE  intercept
s7_b    <- c(2.9, -0.6)  # <-- CHANGE  slopes, keep the signs
s7_at   <- c(1, 2)       # <-- CHANGE  prediction: x VALUES
s7_dx   <- c(1, -3)      # <-- CHANGE  change: how much each x CHANGES (falls = negative, fixed = 0)
s7_xbar <- c(5, 2)       # <-- CHANGE  y-bar: the MEANS of the x's
s7_ybar <- NA            # <-- CHANGE  FLIPPED question "y-bar is 20, find x1-bar": type y-bar here and put NA
                         #             in s7_xbar for the mean they ask for, e.g. s7_xbar <- c(NA, 4)
s7_yhat <- NA            # <-- CHANGE  BACKWARDS "what x1 gives a predicted y of 125?": type 125 here, NA in s7_at for that x
s7_dy   <- NA            # <-- CHANGE  BACKWARDS "how much must x1 change to move y-hat by 0.50?": type 0.50 here, NA in s7_dx for that x
# >> ANSWERS: nothing to change below
same_len(s7_b, s7_at, "s7_b", "s7_at"); same_len(s7_b, s7_dx, "s7_b", "s7_dx")
s7_pred <- s7_b0 + sum(s7_b * s7_at); s7_chg <- sum(s7_b * s7_dx)
s7_eq <- paste0("y-hat = ", s7_b0, paste(sprintf(" %s %g x%d", ifelse(s7_b < 0, "-", "+"), abs(s7_b), seq_along(s7_b)), collapse = ""))
blk("S7", s7_eq)
if (!is.na(s7_yhat) && sum(is.na(s7_at)) == 1) {
  j <- which(is.na(s7_at)); s7_known <- s7_b0 + sum(s7_b[-j] * s7_at[-j])
  ans(sprintf("BACKWARDS: x%d needed for y-hat = %g -> (%g - %g) / %g", j, s7_yhat, s7_yhat, s7_known, s7_b[j]), (s7_yhat - s7_known) / s7_b[j])
} else ans(sprintf("PREDICTION at %s", paste(sprintf("x%d = %g", seq_along(s7_at), s7_at), collapse = ", ")), s7_pred)
if (!is.na(s7_dy) && sum(is.na(s7_dx)) == 1) {
  j <- which(is.na(s7_dx)); s7_known <- sum(s7_b[-j] * s7_dx[-j])
  ans(sprintf("BACKWARDS: change in x%d for a y-hat change of %g -> (%g - %g) / %g", j, s7_dy, s7_dy, s7_known, s7_b[j]), (s7_dy - s7_known) / s7_b[j])
} else ans(sprintf("CHANGE when %s", paste(sprintf("x%d %+g", seq_along(s7_dx), s7_dx), collapse = ", ")), s7_chg)
if (!is.na(s7_ybar) && length(s7_xbar) == length(s7_b) && sum(is.na(s7_xbar)) == 1) {
  j <- which(is.na(s7_xbar)); s7_known <- s7_b0 + sum(s7_b[-j] * s7_xbar[-j])
  ans(sprintf("MISSING x%d-bar = (%g - %g) / %g", j, s7_ybar, s7_known, s7_b[j]), (s7_ybar - s7_known) / s7_b[j])
} else ans(sprintf("y-bar at %s", paste(sprintf("x%d-bar = %g", seq_along(s7_xbar), s7_xbar), collapse = ", ")), s7_b0 + sum(s7_b * s7_xbar))
part("ONLY if the left side is log(y)")
ans("% change in y = 100 x CHANGE", 100 * s7_chg)
ans("predicted y in levels/$ = exp(PREDICTION)", exp(s7_pred))

## ======================================================================
## SPECIALIZED BLOCKS: one formula each. The solvers above do all of these too.

## ======================================================================
## [U1] x MULTIPLIED or DIVIDED by c -> new slope ----
## LOOKS LIKE: "The OLS slope is 0.58. Every value of x is divided by 1,000. New slope?"  (PS8 #14, Q8 #2)
## x times c -> slope DIVIDED by c. Intercept and R^2 unchanged.   DEFAULT: 580.00
u1_b1 <- 0.58      # <-- CHANGE  original slope
u1_c  <- 1/1000    # <-- CHANGE  what x is MULTIPLIED by (divided by 1000 -> 1/1000)
blk("U1", "x rescaled")
ans(sprintf("new slope = %g / %g", u1_b1, u1_c), u1_b1 / u1_c)

## ======================================================================
## [U2] y MULTIPLIED by c -> slope and intercept times c ----
## LOOKS LIKE: "The OLS slope is 2.48. Every value of y is multiplied by 1,000. New slope?"  (PS8 #13)
## DEFAULT: 2480.00
u2_b1 <- 2.48   # <-- CHANGE  original slope
u2_b0 <- 0      # <-- CHANGE  original intercept (if asked)
u2_c  <- 1000   # <-- CHANGE  what y is multiplied by
blk("U2", "y rescaled")
ans(sprintf("new slope = %g x %g", u2_c, u2_b1), u2_c * u2_b1)
ans(sprintf("new intercept = %g x %g", u2_c, u2_b0), u2_c * u2_b0)

## ======================================================================
## [U3] log(y) MODEL, y rescaled -> slope same, intercept + log(c) ----
## LOOKS LIKE: "log(salary)-hat = 3.36 + 0.44 log(sales). Salary in dollars instead (times 1000):
##   new intercept?"  (PS9 #3)   DEFAULT: 10.27
u3_b0 <- 3.36   # <-- CHANGE  original intercept
u3_c  <- 1000   # <-- CHANGE  what y is multiplied by
blk("U3", "log(y) model, y rescaled")
ans(sprintf("new intercept = %g + log(%g)", u3_b0, u3_c), u3_b0 + log(u3_c))
pick("slope", "unchanged")

## ======================================================================
## [L1] LOG-LEVEL (log on the LEFT only): % change in y = 100 x b1 x change in x ----
## LOOKS LIKE: "log(y)-hat = 1.5 + 0.02x. By about what percent does y change when x rises by 2?"
##   (PS8 #17, Q8 #3, Q9 #2)   DEFAULT: 4.00
## Units trap (PS9 #2): x in MONTHS but asked per YEAR -> change in x = 12.
l1_b1 <- 0.02   # <-- CHANGE  slope
l1_dx <- 2      # <-- CHANGE  change in x (falls = negative)
blk("L1", "log-level")
ans(sprintf("%% change in y = 100 x %g x %g", l1_b1, l1_dx), 100 * l1_b1 * l1_dx)
ans("% change in y, EXACT", 100 * (exp(l1_b1 * l1_dx) - 1))

## ======================================================================
## [L2] LOG-LOG (log on BOTH sides): % change in y = b1 x % change in x (elasticity) ----
## LOOKS LIKE: "log(y)-hat = 3.5 + 1.22 log(x). By about what percent does y change when x rises
##   by 18%?"  (PS8 #18, PS9 #5, Q8 #4)   DEFAULT: 21.96
l2_b1   <- 1.22   # <-- CHANGE  slope (the elasticity)
l2_pctx <- 18     # <-- CHANGE  % change in x (falls = negative)
blk("L2", "log-log")
ans(sprintf("%% change in y = %g x %g%%", l2_b1, l2_pctx), l2_b1 * l2_pctx)

## ======================================================================
## [L3] LEVEL-LOG (log on the RIGHT only): change in y = (b1 / 100) x % change in x ----
## LOOKS LIKE: "y-hat = 87 + 11.3 log(x). By about how many units does y change when x rises
##   by 13%?"  (PS8 #19, Q8 #5)   DEFAULT: 1.47
l3_b1   <- 11.3   # <-- CHANGE  slope
l3_pctx <- 13     # <-- CHANGE  % change in x (falls = negative)
blk("L3", "level-log")
ans(sprintf("change in y (units) = %g/100 x %g%%", l3_b1, l3_pctx), l3_b1 / 100 * l3_pctx)

## ======================================================================
## [L4] LOG-LEVEL with several x's: % change in y = 100 x (b1 dx1 + b2 dx2 + ...) ----
## LOOKS LIKE: "log(y)-hat = 2.4 + 0.015x1 - 0.037x2. If x1 rises by 3 and x2 rises by 4,
##   about what percent does y change?"  (PS11 #1)   DEFAULT: -10.30
l4_b  <- c(0.015, -0.037)   # <-- CHANGE  slopes, keep minus signs, NO intercept
l4_dx <- c(3, 4)            # <-- CHANGE  changes in each x: "FALLS by 4" -> -4 (fixed = 0)
blk("L4", "log-level, several x's"); same_len(l4_b, l4_dx, "l4_b", "l4_dx")
ans(sprintf("%% change in y = 100 x (%s)", paste(sprintf("%g x %g", l4_b, l4_dx), collapse = " + ")), 100 * sum(l4_b * l4_dx))

## ======================================================================
## [M1] MULTIPLE REGRESSION PREDICTION (keep the intercept) ----
## LOOKS LIKE: "y-hat = 5 + 2.9x1 + 2.2x2. Predicted value at x1 = 13 and x2 = 12?" (Q9 #8)
## DEFAULT: 69.10
m1_b0 <- 5            # <-- CHANGE  intercept
m1_b  <- c(2.9, 2.2)  # <-- CHANGE  slopes, keep signs
m1_x  <- c(13, 12)    # <-- CHANGE  x VALUES
blk("M1", "prediction"); same_len(m1_b, m1_x, "m1_b", "m1_x")
ans(sprintf("predicted y = %g + %s", m1_b0, paste(sprintf("%g x %g", m1_b, m1_x), collapse = " + ")), m1_b0 + sum(m1_b * m1_x))

## ======================================================================
## [M2] MULTIPLE REGRESSION CHANGE (drop the intercept) ----
## LOOKS LIKE: "y-hat = 4 + 0.9x1 - 1.9x2. If x1 rises by 1 and x2 rises by 4, by how much does
##   y-hat change?"  (Q9 #9, Exam I Q14)   DEFAULT: -6.70
m2_b  <- c(0.9, -1.9)   # <-- CHANGE  slopes, keep signs
m2_dx <- c(1, 4)        # <-- CHANGE  changes (falls = negative, fixed = 0)
blk("M2", "change"); same_len(m2_b, m2_dx, "m2_b", "m2_dx")
ans(sprintf("change in y-hat = %s", paste(sprintf("%g x %g", m2_b, m2_dx), collapse = " + ")), sum(m2_b * m2_dx))

## ======================================================================
## [M3] y-bar FROM THE LINE AND THE MEANS (the line passes through the means) ----
## LOOKS LIKE: "y-hat = 3.6 + 0.8x1 - 1.2x2, x1-bar = 4.6, x2-bar = 2.9. What is y-bar?"
##   (PS11 #6, PS8 #12, Exam I Q26)   DEFAULT: 3.80
m3_b0   <- 3.6           # <-- CHANGE  intercept
m3_b    <- c(0.8, -1.2)  # <-- CHANGE  slopes
m3_xbar <- c(4.6, 2.9)   # <-- CHANGE  means of the x's
blk("M3", "y-bar")
ans(sprintf("y-bar = %g + %s", m3_b0, paste(sprintf("%g x %g", m3_b, m3_xbar), collapse = " + ")), m3_b0 + sum(m3_b * m3_xbar))

## ======================================================================
## [O1] OLS RESIDUAL of ONE observation (small sample) ----
## LOOKS LIKE: "For x = (1,4,6,7,9), y = (2,1,6,5,3), regress y on x. Find the residual of the
##   third observation."  (PS8 #6, Q7 #7, Exam I Q23)   DEFAULT: 2.40
o1_x <- c(1, 4, 6, 7, 9)   # <-- CHANGE  x values
o1_y <- c(2, 1, 6, 5, 3)   # <-- CHANGE  y values
o1_i <- 3                  # <-- CHANGE  which observation
o1_reg <- lm(o1_y ~ o1_x)
blk("O1", "residual of one observation")
ans4("slope", coef(o1_reg)[2]); ans4("intercept", coef(o1_reg)[1])
ans(sprintf("fitted y for observation %d (x = %g)", o1_i, o1_x[o1_i]), fitted(o1_reg)[o1_i])
ans(sprintf("residual of observation %d = %g - fitted", o1_i, o1_y[o1_i]), resid(o1_reg)[o1_i])

## ======================================================================
## [O2] MISSING RESIDUAL (OLS residuals always sum to 0) ----
## LOOKS LIKE: "Residuals -1.6, 2.4, -0.2, 0.7, 1.1, and one more. The sixth?" (PS8 #7, Q7 #8)
## DEFAULT: -2.40
o2_known <- c(-1.6, 2.4, -0.2, 0.7, 1.1)   # <-- CHANGE  the residuals you're given
blk("O2", "missing residual")
ans(sprintf("missing residual = -(sum of the %d given)", length(o2_known)), -sum(o2_known))

## ======================================================================
## [O3] sum of x_i x uhat_i -> ALWAYS 0 (just type 0) ----
## LOOKS LIKE: "For x = (...), y = (...), compute the sum of x_i times uhat_i."  (PS8 #8, Exam I Q28)
o3_x <- c(3, 6, 7, 9, 10, 15); o3_y <- c(12, 12, 8, 15, 8, 10)   # (optional check)
blk("O3", "sum of x times residual")
ans("sum of x x residual (always 0)", sum(o3_x * resid(lm(o3_y ~ o3_x))))

## ======================================================================
## [O4] SSR FROM SSE AND R^2: SST = SSE / R^2, SSR = SST - SSE ----
## LOOKS LIKE: "SSE = 53 and R^2 = 0.89. Find SSR."  (PS8 #9, Q7 #9)   DEFAULT: 6.55
o4_SSE <- 53     # <-- CHANGE  explained sum of squares
o4_R2  <- 0.89   # <-- CHANGE  R^2 (decimal)
blk("O4", "SSR from SSE and R^2")
ans(sprintf("SST = %g / %g", o4_SSE, o4_R2), o4_SSE / o4_R2)
ans("SSR = SST - SSE", o4_SSE / o4_R2 - o4_SSE)

## ======================================================================
## [O5] SST FROM n AND THE SAMPLE VARIANCE: SST = (n - 1) x S_y^2 ----
## LOOKS LIKE: "n = 54 observations, sample variance S_y^2 = 20. Find SST." (PS8 #10, Q7 #10)
## DEFAULT: 1060.00
o5_n  <- 54   # <-- CHANGE  n
o5_S2 <- 20   # <-- CHANGE  sample VARIANCE of y (given the SD? square it)
blk("O5", "SST from n and variance")
ans(sprintf("SST = (%g - 1) x %g", o5_n, o5_S2), (o5_n - 1) * o5_S2)

## ======================================================================
## [V1] Var(b1) = sigma^2 / SST_x ----
## LOOKS LIKE: "sigma^2 = 66 and SST_X = 53. Find Var(b1-hat)."  (PS9 #11)   DEFAULT: 1.25
v1_sigma2 <- 66   # <-- CHANGE  sigma^2 (given sigma = 4? type 4^2)
v1_SST    <- 53   # <-- CHANGE  SST_x
blk("V1", "Var(b1)")
ans(sprintf("Var(b1) = %g / %g", v1_sigma2, v1_SST), v1_sigma2 / v1_SST)

## ======================================================================
## [V2] sd(b1) or se(b1) FROM sigma (or sigma-hat), n, and S_X or S_X^2 ----
## LOOKS LIKE: "sigma = 20, n = 6, sample variance S_X^2 = 2. Find sd(b1-hat)." (PS9 #12)
##   "n = 23, sigma-hat = 9.4, sample SD S_X = 0.7. Find se(b1-hat)." (Q9 #6, PS10 #7)
## SST_X = (n - 1) x S_X^2.   DEFAULT: 6.32   (the Q9 #6 numbers give 2.86)
v2_n      <- 6      # <-- CHANGE  n
v2_sigma  <- 20     # <-- CHANGE  sigma or sigma-hat
v2_S      <- 2      # <-- CHANGE  the S_X number given
v2_is_var <- TRUE   # <-- CHANGE  TRUE if they gave S_X^2 (variance), FALSE if S_X (sd)
v2_SST <- (v2_n - 1) * if (v2_is_var) v2_S else v2_S^2
blk("V2", "sd/se of the slope")
ans(sprintf("SST_x = (%g - 1) x %s", v2_n, if (v2_is_var) format(v2_S) else paste0(v2_S, "^2")), v2_SST)
ans(sprintf("sd(b1) = %g / sqrt(%g)", v2_sigma, v2_SST), v2_sigma / sqrt(v2_SST))

## ======================================================================
## [V3] sd(b1) FROM sigma AND THE RAW x VALUES ----
## LOOKS LIKE: "sigma = 6. The five X values are x = (3,4,7,8,9). Find sd(b1-hat)."  (PS9 #14, Q8 #9)
## DEFAULT: 1.16
v3_sigma <- 6                 # <-- CHANGE  sigma
v3_x     <- c(3, 4, 7, 8, 9)  # <-- CHANGE  the x values
blk("V3", "sd of the slope from raw x")
ans("SST_x = sum of (x - mean)^2", sum((v3_x - mean(v3_x))^2))
ans(sprintf("sd(b1) = %g / sqrt(SST_x)", v3_sigma), v3_sigma / sqrt(sum((v3_x - mean(v3_x))^2)))

## ======================================================================
## [V4] sigma^2-hat = SSR / (n - k - 1)   (simple regression: k = 1 -> n - 2) ----
## LOOKS LIKE: "Simple regression, n = 14, SSR = 268. Estimate of the error variance?"  (PS9 #15, Q8 #10)
## DEFAULT: 22.33
v4_SSR <- 268   # <-- CHANGE  SSR
v4_n   <- 14    # <-- CHANGE  n
v4_k   <- 1     # <-- CHANGE  number of slopes
blk("V4", "estimated error variance")
ans(sprintf("sigma^2-hat = %g / (%g - %g - 1)", v4_SSR, v4_n, v4_k), v4_SSR / (v4_n - v4_k - 1))
ans("sigma-hat = sqrt of that", sqrt(v4_SSR / (v4_n - v4_k - 1)))

## ======================================================================
## [V5] se(b1) FROM SSR, n AND SST_x ----
## LOOKS LIKE: "n = 13, SSR = 437, SST_X = 12. Find se(b1-hat)."  (PS9 #16, Q8 #11)   DEFAULT: 1.82
v5_SSR <- 437   # <-- CHANGE  SSR
v5_n   <- 13    # <-- CHANGE  n
v5_SST <- 12    # <-- CHANGE  SST_x
blk("V5", "se of the slope")
ans(sprintf("sigma-hat = sqrt(%g / (%g - 2))", v5_SSR, v5_n), sqrt(v5_SSR / (v5_n - 2)))
ans(sprintf("se(b1) = sigma-hat / sqrt(%g)", v5_SST), sqrt(v5_SSR / (v5_n - 2)) / sqrt(v5_SST))

## ======================================================================
## [V6] sd(b1) WHEN THE SAMPLE IS k TIMES AS LARGE: divide by sqrt(k) ----
## LOOKS LIKE: "sd(b1-hat) = 0.34. Sample 6 times as large (SST_X also 6x). New sd?"  (Q9 #7, PS10 #9)
## DEFAULT: 0.14      (sigma doubles instead -> multiply the sd by 2)
v6_sd <- 0.34   # <-- CHANGE  current sd
v6_k  <- 6      # <-- CHANGE  how many times as large
blk("V6", "bigger sample")
ans(sprintf("new sd = %g / sqrt(%g)", v6_sd, v6_k), v6_sd / sqrt(v6_k))

## ======================================================================
## [V7] MULTIPLE REGRESSION: Var(bj) = sigma^2 / [SST_j (1 - Rj^2)],  VIF = 1 / (1 - Rj^2) ----
## LOOKS LIKE: "sigma^2 = 15, SST_1 = 120, R_1^2 = 0.6. Var(b1-hat)? VIF?"   DEFAULTS: VIF 2.50, Var 0.31
v7_sigma2 <- 15    # <-- CHANGE  sigma^2
v7_SSTj   <- 120   # <-- CHANGE  SST_j
v7_Rj2    <- 0.6   # <-- CHANGE  R_j^2 (x_j regressed on the other x's)
blk("V7", "multicollinearity")
ans(sprintf("VIF = 1 / (1 - %g)", v7_Rj2), 1 / (1 - v7_Rj2))
ans(sprintf("Var(bj) = %g / (%g x (1 - %g))", v7_sigma2, v7_SSTj, v7_Rj2), v7_sigma2 / (v7_SSTj * (1 - v7_Rj2)))
ans("sd(bj) = sqrt of that", sqrt(v7_sigma2 / (v7_SSTj * (1 - v7_Rj2))))

## ======================================================================
## [B1] OVB FORMULA (3.23): b1-tilde = b1-hat + b2-hat x delta1. Type 3 pieces, NA on the asked one ----
## LOOKS LIKE: "Simple regression gives b1-tilde = -0.36. Multiple gives b2-hat = -1.18; slope of
##   X2 on X1 is delta1 = -0.51. Find b1-hat."  (PS11 #11, PS10 #18)   DEFAULT: b1-hat -0.96
## "short regression" = simple (b1-tilde). "long regression" = multiple (b1-hat, b2-hat).
b1_b1tilde <- -0.36   # <-- CHANGE  SIMPLE slope on x1 (NA if that's what's asked)
b1_b1hat   <- NA      # <-- CHANGE  MULTIPLE slope on x1 (NA if asked)
b1_b2hat   <- -1.18   # <-- CHANGE  coefficient on x2 in the multiple regression (NA if asked)
b1_delta1  <- -0.51   # <-- CHANGE  slope from regressing x2 on x1 (NA if asked)
blk("B1", "formula (3.23)")
if (is.na(b1_b1hat))   ans(sprintf("b1-hat = %g - (%g x %g)", b1_b1tilde, b1_b2hat, b1_delta1), b1_b1tilde - b1_b2hat * b1_delta1)
if (is.na(b1_b1tilde)) ans(sprintf("b1-tilde = %g + %g x %g", b1_b1hat, b1_b2hat, b1_delta1), b1_b1hat + b1_b2hat * b1_delta1)
if (is.na(b1_b2hat))   ans(sprintf("b2-hat = (%g - %g) / %g", b1_b1tilde, b1_b1hat, b1_delta1), (b1_b1tilde - b1_b1hat) / b1_delta1)
if (is.na(b1_delta1))  ans(sprintf("delta1 = (%g - %g) / %g", b1_b1tilde, b1_b1hat, b1_b2hat), (b1_b1tilde - b1_b1hat) / b1_b2hat)

## ======================================================================
## [B2] BIAS = beta2 x delta1 (and the expected simple slope) ----
## LOOKS LIKE: "beta2 = -1.17. Omit X2; slope of X2 on X1 is delta1 = -0.26. Bias?"  (PS10 #19)
##   / "beta1 = 2, beta2 = 0.9, delta1 = -0.3: E[b1-tilde]?"   DEFAULT: bias 0.30 (biased UP)
b2_beta2  <- -1.17   # <-- CHANGE  true effect of the omitted x2 on y
b2_delta1 <- -0.26   # <-- CHANGE  slope of x2 on x1
b2_beta1  <- NA      # <-- CHANGE  true beta1, only if they ask for E[b1-tilde]
blk("B2", "bias from leaving x2 out")
ans(sprintf("bias = %g x %g", b2_beta2, b2_delta1), b2_beta2 * b2_delta1)
pick("direction", ifelse(b2_beta2 * b2_delta1 > 0, "UPWARD (estimate too big)", "DOWNWARD (estimate too small)"))
if (!is.na(b2_beta1)) ans(sprintf("E[b1-tilde] = %g + bias", b2_beta1), b2_beta1 + b2_beta2 * b2_delta1)

## ======================================================================
## [B3] DIRECTION OF BIAS (Table 3.2): sign of beta2 x sign of corr(x1, x2) ----
## LOOKS LIKE: "An omitted X2 lowers Y and is negatively correlated with X1. The simple slope
##   is..." / fertilizer and land quality / tutoring and ability  (PS11 #16-18, PS10 #20)
## Same signs -> UPWARD (overstates). Opposite signs -> DOWNWARD (understates).
b3_b2   <- -1   # <-- CHANGE  +1 if the omitted x2 RAISES y, -1 if it LOWERS y
b3_corr <- -1   # <-- CHANGE  +1 if x2 is usually HIGH when x1 is high, -1 if LOW
blk("B3", sprintf("x2 %s y, x2 %s with x1", ifelse(b3_b2 > 0, "raises", "lowers"), ifelse(b3_corr > 0, "moves together", "moves opposite")))
pick("bias", ifelse(b3_b2 * b3_corr > 0, "UPWARD (overstates the effect)", "DOWNWARD (understates the effect)"))

## ======================================================================
## [P1] sd(aX + b) FROM E[X] AND E[X^2] ----
## LOOKS LIKE: "E[X] = 4 and E[X^2] = 20. Find the sd of 3X - 4."  (PS8 #3, Q7 #4)   DEFAULT: 6.00
p1_EX  <- 4    # <-- CHANGE  E[X]
p1_EX2 <- 20   # <-- CHANGE  E[X^2]
p1_a   <- 3    # <-- CHANGE  a, the number in front of X (b doesn't matter for sd)
blk("P1", "sd of aX + b")
ans(sprintf("Var(X) = %g - %g^2", p1_EX2, p1_EX), p1_EX2 - p1_EX^2)
ans(sprintf("sd(%gX + b) = |%g| x sd(X)", p1_a, p1_a), abs(p1_a) * sqrt(p1_EX2 - p1_EX^2))

## ======================================================================
## [P2] Var(aX + bY) = a^2 Var(X) + b^2 Var(Y) + 2ab Cov(X, Y)   (a minus sign goes INTO b) ----
## LOOKS LIKE: "Var(X) = 4, Var(Y) = 3, Cov = -1.9. Find Var(2X - 3Y)."  (PS8 #4, Q7 #5)   DEFAULT: 65.80
p2_vx  <- 4      # <-- CHANGE  Var(X)
p2_vy  <- 3      # <-- CHANGE  Var(Y)
p2_cov <- -1.9   # <-- CHANGE  Cov(X, Y)
p2_a   <- 2      # <-- CHANGE  a, in front of X
p2_b   <- -3     # <-- CHANGE  b, in front of Y (with its sign)
blk("P2", "variance of a sum")
ans(sprintf("Var(%gX %s %gY)", p2_a, ifelse(p2_b < 0, "-", "+"), abs(p2_b)), p2_a^2 * p2_vx + p2_b^2 * p2_vy + 2 * p2_a * p2_b * p2_cov)

## ======================================================================
## [P3] CORRELATION FROM A JOINT PROBABILITY TABLE (weight by p; never cor()) ----
## LOOKS LIKE: "X and Y have the joint distribution below. Find Cor(X, Y)."  (PS8 #5, Q7 #6)   DEFAULT: -0.59
p3_x <- c(1, 5, 7, 8)             # <-- CHANGE  x column
p3_y <- c(3, 3, 1, 3)             # <-- CHANGE  y column
p3_p <- c(0.2, 0.3, 0.4, 0.1)     # <-- CHANGE  probability column
p3_EX <- sum(p3_x * p3_p); p3_EY <- sum(p3_y * p3_p)
p3_cov <- sum(p3_x * p3_y * p3_p) - p3_EX * p3_EY
blk("P3", "joint probability table")
ans("E[X]", p3_EX); ans("E[Y]", p3_EY)
ans("Cov(X,Y) = E[XY] - E[X]E[Y]", p3_cov)
ans("Cor(X,Y) = Cov / (sd(X) sd(Y))", p3_cov / sqrt((sum(p3_x^2 * p3_p) - p3_EX^2) * (sum(p3_y^2 * p3_p) - p3_EY^2)))

## ======================================================================
## [T1] t-STATISTIC FROM AN ESTIMATE AND se; critical values; p-values; decisions ----
## LOOKS LIKE: "b-hat = 0.54, se = 0.05. t?" / "H0: b = 0 vs H1: b > 0 at 5%, df = 522"
## df = n - k - 1 (n = 526, k = 3 -> 522).  Given b and t but not se? se = b / t.
## "raises / positive" -> H1: b > 0.  "lowers / negative" -> H1: b < 0.   DEFAULT: t 10.80
## The question GIVES t already (no estimate + se)? Don't use this block: go to [T2].
t1_b     <- 0.54   # <-- CHANGE  the estimate
t1_se    <- 0.05   # <-- CHANGE  its standard error
t1_h0    <- 0      # <-- CHANGE  null value (usually 0)
t1_df    <- 522    # <-- CHANGE  df, IF the question gives df directly
t1_n     <- NA     # <-- CHANGE  OR give n ...
t1_k     <- NA     # <-- CHANGE  ... and k = number of slopes (then df = n - k - 1 is computed for you)
t1_alpha <- 0.05   # <-- CHANGE  significance level
if (!is.na(t1_n) && !is.na(t1_k)) t1_df <- t1_n - t1_k - 1
t1_t <- (t1_b - t1_h0) / t1_se; t1_c1 <- qt(1 - t1_alpha, t1_df); t1_c2 <- qt(1 - t1_alpha / 2, t1_df)
blk("T1", sprintf("t-test, df = %g, alpha = %g", t1_df, t1_alpha))
if (!is.na(t1_n) && !is.na(t1_k)) ans(sprintf("df = n - k - 1 = %g - %g - 1", t1_n, t1_k), t1_df)
ans(sprintf("t = (%g - %g) / %g", t1_b, t1_h0, t1_se), t1_t)
ans(sprintf("critical c, ONE-sided %g%%", 100 * t1_alpha), t1_c1)
ans(sprintf("critical c, TWO-sided %g%%", 100 * t1_alpha), t1_c2)
ans("p-value, two-sided", 2 * pt(-abs(t1_t), t1_df)); ans("p-value, one-sided H1: b > h0", pt(t1_t, t1_df, lower.tail = FALSE))
pick("H1: b >  h0  (reject if t > c)", ifelse(t1_t > t1_c1, "REJECT H0", "fail to reject H0"))
pick("H1: b <  h0  (reject if t < -c)", ifelse(t1_t < -t1_c1, "REJECT H0", "fail to reject H0"))
pick("H1: b != h0  (reject if |t| > c)", ifelse(abs(t1_t) > t1_c2, "REJECT H0", "fail to reject H0"))

## ======================================================================
## [T2] DECISION FROM A GIVEN t AND c, OR FROM A p-VALUE ----
## LOOKS LIKE: "H0: b = 0 vs H1: b > 0, c = 1.68. t = 2.4: reject?" / "p = 0.03 at 5%?"
t2_t <- 2.4    # <-- CHANGE  the t-statistic
t2_c <- 1.68   # <-- CHANGE  the critical value they give
t2_p <- 0.03   # <-- CHANGE  a p-value (for p-value questions)
blk("T2", sprintf("t = %g, c = %g, p = %g", t2_t, t2_c, t2_p))
pick(sprintf("H1: b >  0  (is %g > %g?)", t2_t, t2_c), ifelse(t2_t > t2_c, "REJECT H0", "fail to reject H0"))
pick(sprintf("H1: b <  0  (is %g < -%g?)", t2_t, t2_c), ifelse(t2_t < -t2_c, "REJECT H0", "fail to reject H0"))
pick(sprintf("H1: b != 0  (is |%g| > %g?)", t2_t, t2_c), ifelse(abs(t2_t) > t2_c, "REJECT H0", "fail to reject H0"))
for (a in c(0.10, 0.05, 0.01)) pick(sprintf("p = %g at alpha = %g", t2_p, a), ifelse(t2_p < a, "REJECT H0", "fail to reject H0"))

## ======================================================================
## [T3] CONFIDENCE INTERVAL: b +/- c x se. A value inside -> fail to reject H0: b = that value ----
t3_b  <- 0.30   # <-- CHANGE  estimate
t3_se <- 0.10   # <-- CHANGE  standard error
t3_c  <- 1.96   # <-- CHANGE  critical value (95% large sample: 1.96)   DEFAULT: [0.10, 0.50]
blk("T3", "confidence interval")
ans(sprintf("lower = %g - %g x %g", t3_b, t3_c, t3_se), t3_b - t3_c * t3_se)
ans(sprintf("upper = %g + %g x %g", t3_b, t3_c, t3_se), t3_b + t3_c * t3_se)

## ======================================================================
## [T4] F-STATISTIC: F = ((SSR_r - SSR_ur) / q) / (SSR_ur / (n - k - 1)) ----
t4_SSRr  <- 198.311   # <-- CHANGE  SSR of the RESTRICTED model (fewer x's)
t4_SSRur <- 183.186   # <-- CHANGE  SSR of the UNRESTRICTED model (all x's)
t4_q     <- 3         # <-- CHANGE  number of restrictions (x's dropped)
t4_n     <- 353       # <-- CHANGE  n
t4_k     <- 5         # <-- CHANGE  slopes in the unrestricted model   DEFAULT: F 9.55
blk("T4", "F-test")
ans(sprintf("F = ((%g - %g)/%g) / (%g/%g)", t4_SSRr, t4_SSRur, t4_q, t4_SSRur, t4_n - t4_k - 1), ((t4_SSRr - t4_SSRur) / t4_q) / (t4_SSRur / (t4_n - t4_k - 1)))

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

## [K18] se OF A COEFFICIENT, the pieces (PS12 #1, #2, #3, #7, #14, #15) ----
pick("[K18] x_j is", "the independent variable whose coefficient's se you want")
pick("[K18] R_j^2 comes from", "regressing x_j on the OTHER x's, e.g. lm(exper ~ educ + tenure). y is NOT in it")
pick("[K18] sigma-hat estimates", "sigma, the standard deviation of the error U (= 'Residual standard error' in summary)")
pick("[K18] R_j^2 -> 1", "se grows without bound (multicollinearity)")
pick("[K18] missing data (NA)", "compute every piece on the rows the regression used, or the hand se won't match summary()")
pick("[K18] Var(X + b), population vs sample", "Var(X + b) = Var(X). mu_Y is a fixed number; Y-bar is a random variable")

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

# ASK()/FIND() TRAINING EXAMPLES (leave alone) ###############################
## Real PS8-PS11, Exam I and Mock II questions with the block that solves each.
## ASK()/FIND() compare a new question against these to pick the block.
EXAMPLES <- data.frame(stringsAsFactors = FALSE, tag = c(
  "K2",
  "K1",
  "S5",
  "S5",
  "S5",
  "S6",
  "O2",
  "S6",
  "S1",
  "S1",
  "D1",
  "S7",
  "S3",
  "S3",
  "K8",
  "D2",
  "L1",
  "L2",
  "L3",
  "K9",
  "D3",
  "K8",
  "L1",
  "S3",
  "K9",
  "L2",
  "D3",
  "D4",
  "K4",
  "K3",
  "K5",
  "S2",
  "S2",
  "K7",
  "S2",
  "S2",
  "S2",
  "K6",
  "D6",
  "D6",
  "L1",
  "D5",
  "K4",
  "K7",
  "K7",
  "S2",
  "S2",
  "V6",
  "D6",
  "K14",
  "S7",
  "S7",
  "D7",
  "D7",
  "D8",
  "D8",
  "B1",
  "B2",
  "B3",
  "D10",
  "L4",
  "D8",
  "D8",
  "K10",
  "D9",
  "S7",
  "K11",
  "D11",
  "K12",
  "K13",
  "B1",
  "D10",
  "D10",
  "D10",
  "K14",
  "B3",
  "B3",
  "B3",
  "K15",
  "S4",
  "K2",
  "S1",
  "K1",
  "S7",
  "S4",
  "S6",
  "S5",
  "S5",
  "S5",
  "S5",
  "S5",
  "S6",
  "S6",
  "S1",
  "S1",
  "S7",
  "O2",
  "S6",
  "D0",
  "D0",
  "D0",
  "D1",
  "D1",
  "D1",
  "D1",
  "D1",
  "D1",
  "D1",
  "K2",
  "B3",
  "S3",
  "K7",
  "S4",
  "K11",
  "K16",
  "T2",
  "L4",
  "S5",
  "S1",
  "S1",
  "B1",
  "S2",
  "L1",
  "L3",
  "S7",
  "M3",
  "B2",
  "T1",
  "D0",
  "D0",
  "D7",
  "D7",
  "D5",
  "D10",
  "D1",
  "D8",
  "D6",
  "D12",
  "K18",
  "K18",
  "K18",
  "S2",
  "S2",
  "S2",
  "K18",
  "D14",
  "D14",
  "D14",
  "D14",
  "D14",
  "D14",
  "K18",
  "K18",
  # Wooldridge Ch2-3 problems and computer exercises
  "S6",
  "S6",
  "S6",
  "S6",
  "S7",
  "S7",
  "S7",
  "K9",
  "K6",
  "K2",
  "D0",
  "D0",
  "D1",
  "D1",
  "D1",
  "D0",
  "D0",
  "D0",
  "D3",
  "D1",
  "D1",
  "D0",
  "D1",
  "D3",
  "D5",
  "D4",
  "D0",
  "D0",
  "D1",
  "S7",
  "S7",
  "S7",
  "S7",
  "S7",
  "S7",
  "S4",
  "S4",
  "K9",
  "K11",
  "K12",
  "B3",
  "B3",
  "D10",
  "K7",
  "K11",
  "D10",
  "D7",
  "D7",
  "D7",
  "D7",
  "D13",
  "D8",
  "D5",
  "D0",
  "D7",
  "D7",
  "D10",
  "D10",
  "D10",
  "D0",
  "D7",
  "D8",
  "D0",
  "D7",
  # Wooldridge Ch2-3 in-chapter worked examples
  "D1",
  "D1",
  "D1",
  "D1",
  "D1",
  "D1",
  "D9",
  "D1",
  "B3",
  "D7",
  "D7",
  "D7",
  "D10",
  "D7",
  "D8",
  "D8",
  "D7",
  "D10",
  "D10",
  "D7",
  "D7",
  "D7",
  "D7",
  "D7",
  "D7",
  "D7",
  "D7",
  "B3",
  "B3"),
text = c(
  "In ( {test score}= _0+ _1 , {class size}+U ), family income is part of (U ). Richer school districts tend to have smaller classes. Which statement is correct?",
  "The OLS estimates ( _0, _1 ) are called least squares estimates. A researcher fits four candidate lines to the same sample and records three sums for each. Exactly one is the OLS line. Which one? Line ( _i u_i ) ( _i| u_i| ) ( _i u_i^{2} ) A 0.00 7.30 9.71 B -1.00 5.80 9.00 C 0.00 6.40 8.13 D 0.50 6.70 8.35",
  "(E[X]=4 ) and (E[X^2]=20 ). Find the standard deviation of (3X-4 ). (round to the hundredths)",
  "( {Var}(X)=4 ), ( {Var}(Y)=3 ), and ( {Cov}(X,Y)=-1.9 ). Find ( {Var}(2X-3Y) ). (round to the hundredths)",
  "(X ) and (Y ) have the joint distribution below. Find ( {Cor}(X,Y) ). (round to the hundredths) (x ) (y ) (P(X=x, ,Y=y) ) 1 3 0.2 5 3 0.3 7 1 0.4 8 3 0.1",
  "For the sample (x=(1,4,6,7,9) ), (y=(2,1,6,5,3) ), regress (y ) on (x ) by OLS. Find the residual of the third observation, ((x_3,y_3)=(6,6) ). (round to the hundredths)",
  "An OLS regression on six observations has residuals -1.6, 2.4, -0.2, 0.7, 1.1, and one more. What is the sixth residual? (round to the hundredths)",
  "For the sample (x=(3,6,7,9,10,15) ), (y=(12,12,8,15,8,10) ), regress (y ) on (x ) by OLS. Compute ( _{i=1}^{6}x_i u_i ). (round to the hundredths)",
  "A regression has explained sum of squares ( {SSE}=53 ) and (R^2=0.89 ). Find the sum of squared residuals ( {SSR} ). (round to the hundredths)",
  "A sample of (n=54 ) observations has sample variance (S_y^2=20 ). Find the total sum of squares ( {SST} ). (round to the hundredths)",
  "Data: wage1 ( wage = average hourly earnings in dollars; tenure = years with the current employer). Run reg <- lm(wage ~ tenure, data = wage1) . What is the OLS residual of the worker in row 12? (round to the hundredths)",
  "An OLS regression line has intercept ( _0=-5 ) and slope ( _1=2.8 ). The sample mean of (x ) is 4. What is the sample mean of (y )? (round to the hundredths)",
  "In a regression of (y ) on (x ), the OLS slope is ( _1=2.48 ). Every value of (y ) is then multiplied by 1,000 (for example, dollars to cents when the multiplier is 100). What is the new OLS slope? (round to the hundredths)",
  "In a regression of (y ) on (x ), the OLS slope is ( _1=0.58 ). Every value of (x ) is then divided by 1,000 (for example, percent to decimal when the divisor is 100). What is the new OLS slope? (round to the hundredths)",
  "In a regression of (y ) on (x ), every value of (x ) is multiplied by 10. Which statement is correct?",
  "Data: ceosal1 ( salary = a CEO's salary in thousands of dollars; sales = firm sales in millions of dollars). Run lm(salary ~ sales, data = ceosal1) . If salary is measured in dollars instead of thousands of dollars, what is the OLS slope? (Use the unrounded slope.) (round to the hundredths)",
  "A log-level regression gives ( { (y)}=1.5+0.02 ,x ). By about what percent does (y ) change when (x ) rises by 2? (Give a percent, e.g. 12.34 for 12.34%.) (round to the hundredths)",
  "A log-log regression gives ( { (y)}=3.5+1.22 (x) ). By about what percent does (y ) change when (x ) rises by 18%? (Give a percent.) (round to the hundredths)",
  "A level-log regression gives ( y=87+11.3 (x) ). By about how many units does (y ) change when (x ) rises by 13%? (round to the hundredths)",
  "A study estimates ( { ( {rent})}=2.1+0.45 ( {income}) ). What does the 0.45 mean?",
  "Data: wage1 ( wage = average hourly earnings in dollars; exper = years of potential work experience). Run the log-level regression lm(log(wage) ~ exper, data = wage1) . By about what percent does predicted wage change with 10 more years of experience? (Give a percent, e.g. 12.34 for 12.34%. Use the unrounded slope.) (round to the hundredths)",
  "A log-log regression of CEO salary on firm sales gives ( { ( {salary})}= _0+ _1 ( {sales}) ), with salary in thousands of dollars. Salary is then measured in dollars instead. What happens?",
  "A log-level regression of ( ( {wage}) ) on tenure, with tenure measured in months , gives a slope of 0.0062. By about what percent does wage rise with one more year of tenure? (Give a percent, e.g. 12.34 for 12.34%.) (round to the hundredths)",
  "A regression gives ( { ( {salary})}=3.36+0.44 ( {sales}) ), with salary in thousands of dollars. If salary is measured in dollars instead (every salary times 1000), what is the new intercept? (round to the hundredths)",
  "In which model is the slope read as ( % y 100 _1 x )?",
  "A log-log regression gives ( { (y)}=2.9+0.94 (x) ). By about what percent does (y ) change when (x ) falls by 8%? (Give a percent; it can be negative.) (round to the hundredths)",
  "Data: ceosal1 ( salary = a CEO's 1990 salary in thousands of dollars; roe = the firm's return on equity, in percent; sales = firm sales in millions of dollars). Run the log-level regression lm(log(salary) ~ roe, data = ceosal1) . By about what percent does predicted salary change when return on equity rises by 5 points? (Give a percent. Use the unrounded slope.) (round to the hundredths)",
  "Data: ceosal1 ( salary = a CEO's 1990 salary in thousands of dollars; roe = the firm's return on equity, in percent; sales = firm sales in millions of dollars). Run the level-log regression lm(salary ~ log(sales), data = ceosal1) . By about how many thousand dollars does predicted salary change when sales rise by 10%? (Use the unrounded slope.) (round to the hundredths)",
  "Theorem 2.1 says that under SLR1–SLR4, (E[ _1]= _1 ). What does this mean?",
  "In ( {wage}= _0+ _1 , {educ}+U ), which of the following is the most likely to contribute omitted-variable bias to the OLS slope on educ?",
  "In a sample of workers, every worker has exactly 12 years of education. You regress wage on education. What goes wrong?",
  "Under SLR1–SLR5, the error variance is ( ^2=66 ) and ( {SST}_X=53 ). Find ( {Var}( _1) ). (round to the hundredths)",
  "Under SLR1–SLR5, the error standard deviation is ( =20 ). A sample has (n=6 ) observations, and the sample variance of (X ) is (S_X^2=2 ). Find ( {sd}( _1) ). (round to the hundredths)",
  "Holding everything else fixed, which change makes ( {Var}( _1) ) smaller ?",
  "Under SLR1–SLR5, the error standard deviation is ( =6 ). A sample has the five (X ) values (x=(3,4,7,8,9) ). Find ( {sd}( _1) ). (round to the hundredths)",
  "A simple regression on (n=14 ) observations has ( {SSR}=268 ). Find the estimate of the error variance, ( ^2 ). (round to the hundredths)",
  "A simple regression on (n=13 ) observations has ( {SSR}=437 ), and ( {SST}_X=12 ). Find the standard error ( {se}( _1) ). (round to the hundredths)",
  "In a regression of food spending on income, the spread of food spending around the regression line grows as income grows. Which statement is correct?",
  "Data: wage1 ( wage = average hourly earnings in dollars; educ = years of education). Run reg <- lm(wage ~ educ, data = wage1) . What is ( ), the standard error of the regression? (round to the hundredths)",
  "Data: wage1 ( wage = average hourly earnings in dollars; educ = years of education). What is ( {SST}_X ) for educ, the total sum of squares of the explanatory variable? (round to the hundredths)",
  "A log-level regression gives ( { (y)}=2.5+0.01 ,x ). By about what percent does (y ) change when (x ) falls by 1? (Give a percent; it can be negative.) (round to the hundredths)",
  "Data: bwght ( bwght = a baby's birth weight in ounces; faminc = the family's income in thousands of dollars). Run the log-log regression lm(log(bwght) ~ log(faminc), data = bwght) . By about what percent does predicted birth weight change when family income rises by 20%? (Give a percent.) (round to the hundredths)",
  "Suppose you could draw 1,000 different random samples from the same population and compute ( _1 ) in each one. If OLS is unbiased (SLR1–SLR4 hold), which statement is correct?",
  "Why do we prefer an unbiased estimator with a smaller variance ( {Var}( _1) )?",
  "Under SLR1–SLR5, ( {Var}( _1)= ^2/ {SST}_X ). Holding everything else fixed, which changes would make ( {Var}( _1) ) larger ? Select all that apply.",
  "A simple regression on (n=11 ) observations has ( =8.6 ), and the sample standard deviation of (X ) is (S_X=1.7 ). Find the standard error ( {se}( _1) ). (round to the hundredths)",
  "A simple regression uses the five (X ) values (x=(2,3,4,5,9) ) and has ( {SSR}=62 ). Find the standard error ( {se}( _1) ). (round to the hundredths)",
  "Under SLR1–SLR5, a regression has ( {sd}( _1)=0.32 ). If the sample were 2 times as large, with the (X ) values spread out in the same way (so ( {SST}_X ) is also 2 times as large), what would ( {sd}( _1) ) be? (round to the hundredths)",
  "Data: ceosal1 ( salary = a CEO's 1990 salary in thousands of dollars; roe = the firm's return on equity, in percent; sales = firm sales in millions of dollars). Run reg <- lm(salary ~ roe, data = ceosal1) . Compute the standard error ( {se}( _1) ) by hand from ( ) and ( {SST}_X ). (round to the hundredths)",
  "In ( { {wage}}= _0+ _1 , {educ}+ _2 , {exper} ), what does ( _1 ) measure?",
  "A multiple regression gives ( y=10+2.4x_1+1.7x_2 ). Find the predicted value ( y ) at (x_1=2 ) and (x_2=10 ). (round to the hundredths)",
  "A multiple regression gives ( y=2+3.8x_1-0.7x_2 ). If (x_1 ) rises by 1 and (x_2 ) rises by 4, by how much does ( y ) change? (round to the hundredths)",
  "Data: wage1 ( wage = average hourly earnings in dollars; educ = years of education; exper = years of experience; tenure = years with the current employer). Run reg <- lm(wage ~ educ + exper + tenure, data = wage1) . What is the predicted hourly wage of a worker with 14 years of education, 10 years of experience and 5 years of tenure? (round to the hundredths)",
  "Data: wage1 ( wage = average hourly earnings in dollars; educ = years of education; exper = years of experience; tenure = years with the current employer). Using the same regression of wage on educ, exper and tenure, by how much does the predicted hourly wage change when tenure rises by 3 years, holding education and experience fixed? (round to the hundredths)",
  "Data: ceosal1 ( salary = a CEO's 1990 salary in thousands of dollars; roe = the firm's return on equity, in percent; sales = firm sales in millions of dollars). Run reg <- lm(log(salary) ~ log(sales) + roe, data = ceosal1) . By about what percent does predicted salary change when return on equity rises by 10 points, holding sales fixed? (Give a percent. Use the unrounded coefficient.) (round to the hundredths)",
  "Data: ceosal1 ( salary = a CEO's 1990 salary in thousands of dollars; roe = the firm's return on equity, in percent; sales = firm sales in millions of dollars). Using the same regression of log(salary) on log(sales) and roe, what is the predicted salary, in thousands of dollars, of a CEO whose firm has sales of 5,000 (that is, $5 billion) and a return on equity of 15? (Use the unrounded coefficients.) (round to the hundredths)",
  "Formula (3.23) links the simple and multiple regression slopes: ( _1= _1+ _2 _1 ). The multiple regression of (Y ) on (X_1 ) and (X_2 ) gives ( _1=0.25 ) and ( _2=1.44 ), and the slope from regressing (X_2 ) on (X_1 ) is ( _1=0.11 ). Find the simple-regression slope ( _1 ) from regressing (Y ) on (X_1 ) alone. (round to the hundredths)",
  "In the population, (Y= _0+ _1X_1+ _2X_2+U ) with ( _2=-1.17 ). You omit (X_2 ) and regress (Y ) on (X_1 ) alone, and the slope from regressing (X_2 ) on (X_1 ) is ( _1=-0.26 ). What is the bias of the simple-regression slope, ( {Bias}( _1)=E[ _1]- _1 )? (round to the hundredths)",
  "An omitted variable (X_2 ) lowers (Y ) ( ( _2<0 )), and (X_2 ) is positively correlated with (X_1 ). The simple-regression slope on (X_1 ) is:",
  "Data: wage1 ( wage = average hourly earnings in dollars; educ = years of education; exper = years of experience; tenure = years with the current employer). Run the multiple regression lm(wage ~ educ + exper, data = wage1) and the regression of the omitted variable on the included one, lm(exper ~ educ, data = wage1) . Compute ( _2 _1 ), the exper coefficient from the first regression times the educ slope from the second. (round to the hundredths)",
  "A regression gives ( { (y)}=2.4+0.015 ,x_1-0.037 ,x_2 ). If (x_1 ) rises by 3 and (x_2 ) rises by 4, by about what percent does predicted (y ) change? (Give a percent; it can be negative.) (round to the hundredths)",
  "Data: wage1 ( wage = average hourly earnings in dollars; educ = years of education; exper = years of experience; tenure = years with the current employer). Run reg <- lm(log(wage) ~ educ + exper + tenure, data = wage1) . By about what percent does predicted wage change when experience rises by 2 years and tenure rises by 1 year, holding education fixed? (Give a percent. Use the unrounded coefficients.) (round to the hundredths)",
  "Data: wage1 ( wage = average hourly earnings in dollars; educ = years of education; exper = years of experience; tenure = years with the current employer). Using the same regression of log(wage) on educ, exper and tenure, what is the predicted hourly wage, in dollars, of a worker with 12 years of education, 10 years of experience and 3 years of tenure? (round to the hundredths)",
  "After an OLS multiple regression of (Y ) on (X_1, ,X_K ) (with an intercept) and residuals ( U_i=Y_i- Y_i ), which statements are always true? Select all that apply.",
  "Data: gpa1 ( colGPA = college GPA; ACT = ACT score; hsGPA = high-school GPA). Run reg <- lm(colGPA ~ ACT + hsGPA, data = gpa1) . Compute the predicted colGPA at ACT = mean(gpa1$ACT) and hsGPA = mean(gpa1$hsGPA) . (round to the hundredths)",
  "A multiple regression gives ( y=3.6+0.8x_1-1.2x_2 ). The sample means of the independent variables are ( x_1=4.6 ) and ( x_2=2.9 ). What is the sample mean ( y )? (round to the hundredths)",
  "Which of these regressions violate MLR3 (no perfect collinearity), so that OLS cannot estimate them? Select all that apply.",
  "Data: vote1 ( voteA = percent of the vote won by candidate A; expendA and expendB = campaign spending by candidates A and B, in thousands of dollars). Create total spending with vote1$totexpend <- vote1$expendA + vote1$expendB , then run lm(voteA ~ expendA + expendB + totexpend, data = vote1) . What does R report for the coefficient on totexpend?",
  "Which situation makes MLR4, (E[U X_1, ,X_K]=0 ), fail (so that the (X ) variables are endogenous )?",
  "Unbiasedness only needs MLR1-MLR4. Why not simply add every variable we can find to the regression?",
  "Formula (3.23): ( _1= _1+ _2 _1 ). The simple regression of (Y ) on (X_1 ) gives ( _1=-0.36 ). The multiple regression of (Y ) on (X_1 ) and (X_2 ) gives ( _2=-1.18 ), and the slope from regressing (X_2 ) on (X_1 ) is ( _1=-0.51 ). Find the multiple-regression slope ( _1 ). (round to the hundredths)",
  "Data: bwght ( bwght = a baby's birth weight in ounces; cigs = cigarettes the mother smoked per day during pregnancy; faminc = the family's income in thousands of dollars). Run the simple regression lm(bwght ~ cigs, data = bwght) . What is the slope on cigs (the predicted change in birth weight, in ounces, from one more cigarette per day)? (round to the hundredths)",
  "Data: bwght ( bwght = a baby's birth weight in ounces; cigs = cigarettes the mother smoked per day during pregnancy; faminc = the family's income in thousands of dollars). Now add family income: reg <- lm(bwght ~ cigs + faminc, data = bwght) . What is the slope on cigs, holding faminc fixed? (round to the hundredths)",
  "Data: bwght ( bwght = a baby's birth weight in ounces; cigs = cigarettes the mother smoked per day during pregnancy; faminc = the family's income in thousands of dollars). Regress faminc (the variable left out of the simple regression in problem 12) on cigs, lm(faminc ~ cigs, data = bwght) , to get ( _1 ). Compute ( _2 _1 ), the faminc coefficient from the multiple regression times this slope. (round to the hundredths)",
  "In the birth-weight regressions, the simple-regression cigs slope is about (-0.51 ) and the multiple-regression slope (holding faminc fixed) is about (-0.46 ). Which reading is correct?",
  "An omitted variable (X_2 ) lowers (Y ) ( ( _2<0 )), and (X_2 ) is negatively correlated with the included (X_1 ). The simple-regression slope on (X_1 ) is:",
  "A researcher regresses crop yield on fertilizer use across farms, leaving out land quality. Better land raises yield, and farmers tend to use more fertilizer on better land. The simple-regression fertilizer slope most likely:",
  "A school regresses exam scores on hours of tutoring, leaving out prior ability. Higher ability raises exam scores, but the students who sign up for the most tutoring tend to be the ones with lower prior ability. The simple-regression tutoring slope most likely:",
  "You regress (Y ) on (X_1 ) alone, leaving out (X_2 ). When does this cause no omitted-variable bias in the slope on (X_1 )? Select all that apply.",
  "The unemployment rate falls from 5% to 4%. Select all statements that are correct.",
  "In ( {yield}= _0+ _1 , {fertilizer}+U ), land quality is part of (U ). Suppose farmers put more fertilizer on better-quality land. Then:",
  "In a sample where the (y ) values are not all equal, every observation lies exactly on the OLS line. Then:",
  "A researcher fits four candidate lines to the same sample. For each line she records the sum of the residuals, the sum of their absolute values, and the sum of squared residuals. Exactly one of the four lines is the ordinary least squares (OLS) regression line, the line that gives ( _0 ) and ( _1 ). Which one? Line ( _i u_i ) ( _i| u_i| ) ( _i u_i^{2} ) A 0.00 3.80 3.30 B 0.00 3.20 2.40 C -0.50 3.30 2.55 D 1.00 3.00 3.00",
  "Suppose (y=4+2.9X_1-0.6X_2 ). If (X_1 ) rises by 1 and (X_2 ) falls by 3, by how much does (y ) change? (round to the hundredths)",
  "The unemployment rate rises from 5.6% to 6.6%. By what percent does the unemployment rate change? Give a percent rounded to the hundredths, e.g. 12.34 for 12.34%.",
  "Find the sample standard deviation of (x=(5,5,2,12) ). (round to the hundredths)",
  "A sample has sample covariance (S_{xy}=11 ), sample standard deviation (S_x=3 ), and sample variance (S_y^2=64 ). Find the sample correlation between (x ) and (y ). (round to the hundredths)",
  "(E[X]=3 ) and (E[X^2]=27 ). Find the standard deviation of (3X-2 ). (round to the hundredths)",
  "Given (X=x ), (Y ) takes the values 6, 14, and 34 with probabilities 0.5, 0.3, and 0.2. Find (E[3Y+4 X=x] ). (round to the hundredths)",
  "( {Var}(X)=8 ), ( {Var}(Y)=6 ), and ( {Cov}(X,Y)=-2.9 ). Find ( {Var}(2X-2Y) ). (round to the hundredths)",
  "(X ) and (Y ) have the joint distribution below. Find ( {Cor}(X,Y) ). (round to the hundredths) (x ) (y ) (P(X=x, ,Y=y) ) 1 4 0.1 4 7 0.4 5 4 0.3 6 2 0.2",
  "For the sample (x=(1,2,4,9,10) ), (y=(1,1,10,5,9) ), find the OLS slope ( _1 ) from regressing (y ) on (x ). (round to the hundredths)",
  "For the sample (x=(4,6,7,8,10) ), (y=(4,6,7,1,8) ), regress (y ) on (x ) by OLS. Find the OLS residual of the third observation, ((x_3,y_3)=(7,7) ). (round to the hundredths)",
  "A sample of (n=44 ) observations has sample variance (S_y^2=7 ). Find the total sum of squares, ( {SST} ). (round to the hundredths)",
  "A regression has explained sum of squares ( {SSE}=135 ) and (R^2=0.18 ). Find the sum of squared residuals, ( {SSR} ). (round to the hundredths)",
  "An OLS regression line has intercept ( _0=4 ) and slope ( _1=1.2 ). The sample mean of (x ) is 10. What is the sample mean of (y )? (round to the hundredths)",
  "An OLS regression on five observations has residuals -0.7, 2.3, 2.3, 1.8, and one more. What is the fifth residual? (round to the hundredths)",
  "For the sample (x=(1,2,5,10,11,15) ), (y=(5,8,6,10,8,14) ), regress (y ) on (x ) by OLS. Compute ( _{i=1}^{6}x_i u_i ), where ( u_i ) are the OLS residuals. (round to the hundredths)",
  "Data: ceosal1 ( salary = a CEO's 1990 salary in thousands of dollars; roe = the firm's return on equity, in percent). How many CEOs are in the sample?",
  "Data: ceosal1 ( salary = a CEO's 1990 salary in thousands of dollars; roe = the firm's return on equity, in percent). What is the sample mean of return on equity? (round to the hundredths)",
  "Data: ceosal1 ( salary = a CEO's 1990 salary in thousands of dollars; roe = the firm's return on equity, in percent). What is the sample correlation between salary and return on equity? (round to the hundredths)",
  "Data: wage1 ( wage = average hourly earnings in dollars; tenure = years with the current employer). Run the OLS regression of wage on tenure. What is the OLS slope? (round to the hundredths)",
  "Data: wage1 ( wage = average hourly earnings in dollars; tenure = years with the current employer). Using the OLS regression of wage on tenure, what is the predicted hourly wage of a worker with 10 years of tenure? (round to the hundredths)",
  "Data: wage1 ( wage = average hourly earnings in dollars; tenure = years with the current employer). Using the OLS regression of wage on tenure, by how much does the predicted hourly wage change when tenure rises from 3 to 16 years? (round to the hundredths)",
  "Data: wage1 ( wage = average hourly earnings in dollars; tenure = years with the current employer). What percentage of the sample variation in wage is explained by tenure? Give a percent rounded to the hundredths, e.g. 12.34 for 12.34%.",
  "Data: wage1 ( wage = average hourly earnings in dollars; tenure = years with the current employer). Using the OLS regression of wage on tenure, what is the OLS residual of the worker in the second row of wage1? (round to the hundredths)",
  "Data: bwght ( bwght = a baby's birth weight in ounces; faminc = the family's income in thousands of dollars). Run the OLS regression of birth weight on family income. What is the explained sum of squares, ( {SSE} )? (round to the hundredths)",
  "Data: bwght ( bwght = a baby's birth weight in ounces; faminc = the family's income in thousands of dollars). Using the OLS regression of birth weight on family income, by how many ounces does predicted birth weight change when family income rises by 17, that is, by $17,000? (round to the hundredths)",
  "In price = β₀ + β₁·sqrft + U, neighborhood quality is part of U, and bigger houses tend to be in better neighborhoods. Which statement is correct?",
  "A researcher regresses crop yield on rainfall, leaving out irrigation. Irrigation raises yield, and farms that get less rain irrigate more. The rainfall slope most likely:",
  "In log(wage) = β₀ + β₁·educ + U, educ is re-measured in MONTHS instead of years (every value multiplied by 12). What happens?",
  "Holding everything else fixed, which change makes se(β̂₁) LARGER in a multiple regression?",
  "A study estimates log(rent) = 0.8 + 0.03·dist, where dist is miles from campus. What does the 0.03 mean?",
  "A regression of sales on the product's price in dollars AND its price in cents is estimated. What happens?",
  "Which assumptions make OLS the Best Linear Unbiased Estimator (BLUE)?",
  "Test H₀: β₁ = 0 against H₁: β₁ > 0 at 5% with critical value c = 1.65. The t-statistic is −2.50. Conclusion?",
  "log(ŷ) = 1.2 + 0.04x₁ − 0.015x₂. If x₁ FALLS by 2 and x₂ FALLS by 10, by about what percent does predicted y change?",
  "E[X] = 5 and E[X²] = 34. Find Var(4 − 2X).",
  "A regression has SSR = 420 and R² = 0.30. Find the EXPLAINED sum of squares, SSE.",
  "A sample of n = 25 has sample variance of y equal to 12, and the regression has SSR = 168. Find R².",
  "The simple regression of y on x₁ gives a slope of 0.80. The multiple regression on x₁ and x₂ gives 0.62 on x₁, and regressing x₂ on x₁ gives δ̃₁ = 0.45. Find β̂₂, the coefficient on x₂.",
  "A simple regression on n = 30 observations has σ̂² = 16, and the sample standard deviation of x is 2. Find se(β̂₁).",
  "log(wage) = 0.5 + 0.0062·tenure, with tenure measured in MONTHS. By about what percent does wage rise with two more YEARS of tenure?",
  "ŷ = 40 + 15·log(x). By about how many units does y change when x FALLS by 6%?",
  "log(price) = 4.2 + 0.0003·sqrft + 0.02·bdrms, with price in $1000s. What is the predicted price, in $1000s, of a 2,000 sq ft home with 3 bedrooms?",
  "ŷ = 12 − 0.5x₁ + 3x₂. The sample mean of y is 20 and the sample mean of x₂ is 4. What is the sample mean of x₁?",
  "In the population, β₁ = 2 and β₂ = 0.9. You omit x₂, and the slope from regressing x₂ on x₁ is δ̃₁ = −0.3. What is the expected value of the simple-regression slope, E[β̃₁]?",
  "A regression on n = 88 observations with k = 3 slopes gives β̂₁ = −0.042 and se(β̂₁) = 0.018. What is the t-statistic for H₀: β₁ = 0?",
  "Data: hprice1 (price = house price in $1000s; sqrft = square footage; bdrms = bedrooms; lotsize = lot size in sq ft). How many houses are in the sample?",
  "Data: hprice1. What is the sample correlation between price and sqrft?",
  "Data: hprice1. Regress price on sqrft and bdrms. What is the predicted price (in $1000s) of a 2,000 sq ft house with 4 bedrooms?",
  "Same regression. By how much does predicted price change (in $1000s) when square footage rises by 100, holding bedrooms fixed?",
  "Data: hprice1. Run lm(log(price) ~ log(lotsize) + sqrft). By about what percent does predicted price change when lot size rises by 10%, holding sqrft fixed?",
  "Data: meap93 (math10 = % passing a math test; lnchprg = % of students in the lunch program; expend = spending per student). Regress math10 on lnchprg and log(expend). What is the coefficient on lnchprg?",
  "Data: wage1. Regress wage on educ and exper. What is the explained sum of squares, SSE?",
  "Data: ceosal2 (salary = CEO salary in $1000s; sales = firm sales; ceoten = years as CEO). Run lm(log(salary) ~ log(sales) + ceoten). By about what percent does predicted salary change with one more year as CEO, holding sales fixed?",
  "Data: hprice1. For the regression of price on sqrft and bdrms, what is σ̂ (the standard error of the regression)?",
  "Same regression. What is the t-statistic on bdrms?",
  "In the formula \\(\\mathrm{se}(\\hat\\beta_j)=\\hat\\sigma/\\sqrt{\\mathrm{SST}_j\\,(1-R_j^2)}\\), what is \\(X_j\\)? The dependent variable \\(Y\\). The residuals from the regression. The independent variable whose coefficient \\(\\hat\\beta_j\\) we want the standard error of. Whichever independent variable has the largest coefficient.",
  "In \\(\\mathrm{wage}=\\beta_0+\\beta_1\\,\\mathrm{educ}+\\beta_2\\,\\mathrm{exper}+\\beta_3\\,\\mathrm{tenure}+U\\), you want \\(\\mathrm{se}(\\hat\\beta_2)\\), the standard error of the exper coefficient. Which regression gives \\(R_j^2\\)? The regression of wage on exper alone: lm(wage ~ exper) The regression of exper on wage: lm(exper ~ wage) The regression of exper on educ and tenure: lm(exper ~ educ + tenure) The regression of wage on educ, exper and tenure (its own \\(R^2\\))",
  "The standard error of the regression is \\(\\hat\\sigma=\\sqrt{\\mathrm{SSR}/(n-K-1)}\\). What does \\(\\hat\\sigma\\) estimate? The standard deviation of \\(\\hat\\beta_j\\) The \\(R^2\\) of the regression \\(\\sigma\\), the standard deviation of the error \\(U\\) The standard deviation of \\(Y\\)",
  "A multiple regression with \\(K=2\\) independent variables, estimated on \\(n=42\\) observations, has \\(\\mathrm{SSR}=2,857\\). Find the standard error of the regression, \\(\\hat\\sigma\\). (round to the hundredths)",
  "In a sample of \\(n=62\\) observations, the independent variable \\(X_j\\) has sample standard deviation \\(S_{X_j}=3.1\\). Find \\(\\mathrm{SST}_j\\). (round to the hundredths)",
  "A multiple regression has \\(\\hat\\sigma=5.1\\). For the independent variable \\(X_j\\), \\(\\mathrm{SST}_j=363\\), and regressing \\(X_j\\) on the other independent variables gives \\(R_j^2=0.74\\). Find \\(\\mathrm{se}(\\hat\\beta_j)\\). (round to the hundredths)",
  "Holding \\(\\hat\\sigma\\) and \\(\\mathrm{SST}_j\\) fixed, what happens to \\(\\mathrm{se}(\\hat\\beta_j)\\) as \\(R_j^2\\) gets close to 1 (that is, as \\(X_j\\) becomes nearly a linear function of the other independent variables)? It approaches \\(\\hat\\sigma\\). It shrinks toward 0. It does not change. It grows without bound (multicollinearity).",
  "Data: hprice1 (price = house price in thousands of dollars; sqrft = size of the house in square feet; bdrms = number of bedrooms; lotsize = size of the lot in square feet). Run reg <- lm(price ~ sqrft + bdrms + lotsize, data = hprice1). You will find the standard error of the bdrms coefficient by hand, so here \\(X_j\\) = bdrms. First, how many degrees of freedom does the regression have, \\(\\mathrm{df}=n-K-1\\)?",
  "Data: hprice1 (price = house price in thousands of dollars; sqrft = size of the house in square feet; bdrms = number of bedrooms; lotsize = size of the lot in square feet). Using the same regression reg, compute the standard error of the regression, \\(\\hat\\sigma=\\sqrt{\\mathrm{SSR}/\\mathrm{df}}\\). (round to the hundredths)",
  "Data: hprice1 (price = house price in thousands of dollars; sqrft = size of the house in square feet; bdrms = number of bedrooms; lotsize = size of the lot in square feet). Compute \\(\\mathrm{SST}_j\\) for \\(X_j\\) = bdrms, the total variation of bdrms around its mean. (round to the hundredths)",
  "Data: hprice1 (price = house price in thousands of dollars; sqrft = size of the house in square feet; bdrms = number of bedrooms; lotsize = size of the lot in square feet). Compute \\(R_j^2\\) for \\(X_j\\) = bdrms: the \\(R^2\\) from regressing bdrms on the other independent variables. (round to the hundredths)",
  "Data: hprice1 (price = house price in thousands of dollars; sqrft = size of the house in square feet; bdrms = number of bedrooms; lotsize = size of the lot in square feet). Put the pieces together: compute \\(\\mathrm{se}(\\hat\\beta_j)=\\hat\\sigma/\\sqrt{\\mathrm{SST}_j\\,(1-R_j^2)}\\) for the bdrms coefficient. (round to the hundredths)",
  "Data: hprice1 (price = house price in thousands of dollars; sqrft = size of the house in square feet; bdrms = number of bedrooms; lotsize = size of the lot in square feet). Now the quick way. In summary(reg)$coefficients, the \"Std. Error\" column holds every standard error. What is the standard error of the bdrms coefficient there? (It should match problem 12.) (round to the hundredths)",
  "Print summary(reg). Near the bottom is a line \"Residual standard error: ... on 84 degrees of freedom\". Which of your answers does it match? None of them Problem 9 (\\(\\hat\\sigma\\)), and its degrees of freedom match problem 8 Problem 12 (the standard error of the bdrms coefficient) Problem 10 (\\(\\mathrm{SST}_j\\))",
  "A warning about missing data. Some datasets have missing values (NA). lm() silently drops every row with an NA in any variable of the regression. Suppose \\(Y\\) (or another independent variable) has missing values but \\(X_j\\) does not, and you compute \\(\\mathrm{SST}_j\\) by hand from all the rows of \\(X_j\\). What happens? Your hand-computed standard error can differ from summary(reg), because \\(\\mathrm{SST}_j\\) uses rows the regression dropped. Compute every piece on the same rows the regression used. Only \\(R^2\\) is affected, never the standard errors. R stops with an error, so you notice right away. Nothing: missing values never change any statistic.",
  # Wooldridge Ch2-3 problems and computer exercises
  "For eight students, GPA = (2.8, 3.4, 3.0, 3.5, 3.6, 3.0, 2.7, 3.7) and ACT = (21, 24, 26, 27, 29, 25, 25, 30). Estimate GPA = b0 + b1 ACT by OLS. What is the slope?",
  "Same eight students. How much higher is the predicted GPA if the ACT score is increased by five points?",
  "Same eight students. What is the predicted value of GPA when ACT = 20?",
  "Same eight students. How much of the variation in GPA is explained by ACT (R-squared)?",
  "bwght-hat = 119.77 - 0.514 cigs. What is the predicted birth weight when cigs = 20 (one pack per day)?",
  "bwght-hat = 119.77 - 0.514 cigs. To predict a birth weight of 125 ounces, what would cigs have to be?",
  "cons-hat = -124.84 + 0.853 inc, with both in dollars. What is the predicted consumption when family income is $30,000?",
  "log(price) = 9.40 + 0.312 log(dist), where dist is distance from a garbage incinerator. What does the coefficient 0.312 mean?",
  "sav = b0 + b1 inc + u, where u = sqrt(inc)*e and e is independent of inc. Var(u|inc) grows with inc. Which assumption fails, and is OLS still unbiased?",
  "sat = b0 + b1 hours + u, where students choose their hours in an SAT prep course. Which factors in u (like ability or motivation) are likely correlated with hours, and what does that mean for the zero conditional mean assumption?",
  "Data: k401k. Find the average participation rate prate in the sample of plans.",
  "Data: k401k. Find the average match rate mrate in the sample.",
  "Data: k401k. Estimate prate = b0 + b1 mrate by OLS. What is the slope on mrate?",
  "Data: k401k. Using the regression of prate on mrate, find the predicted prate when mrate = 3.5.",
  "Data: k401k. How much of the variation in prate is explained by mrate? Give a percent.",
  "Data: ceosal2 (salary = annual compensation in thousands of dollars; ceoten = prior years as company CEO). Find the average salary in the sample.",
  "Data: ceosal2. How many CEOs are in their first year as CEO (that is, ceoten = 0)?",
  "Data: ceosal2. What is the longest tenure as a CEO (the maximum of ceoten)?",
  "Data: ceosal2. Estimate log(salary) = b0 + b1 ceoten + u. What is the approximate predicted percentage increase in salary given one more year as a CEO?",
  "Data: sleep75 (sleep = minutes of sleep per week; totwrk = minutes worked per week). Estimate sleep = b0 + b1 totwrk + u. What is the intercept?",
  "Data: sleep75. Using the regression of sleep on totwrk, if totwrk increases by 2 hours, by how much is sleep estimated to change (in minutes)?",
  "Data: wage2 (wage = monthly salary; IQ = IQ score). What is the sample standard deviation of IQ?",
  "Data: wage2. Estimate a simple regression where a one-point increase in IQ changes wage by a constant dollar amount. What is the predicted increase in wage for an increase in IQ of 15 points?",
  "Data: wage2. Estimate a model where each one-point increase in IQ has the same percentage effect on wage. If IQ increases by 15 points, what is the approximate percentage increase in predicted wage?",
  "Data: rdchem (rd = R&D expenditures; sales = annual sales, both in millions). Estimate a constant elasticity model of rd on sales. What is the estimated elasticity of rd with respect to sales?",
  "Data: meap93 (math10 = math pass rate; expend = spending per student). Estimate math10 = b0 + b1 log(expend) + u. If spending increases by 10%, what is the estimated percentage point increase in math10?",
  "Data: charity. What is the average gift in the sample (in Dutch guilders)?",
  "Data: charity. What percentage of people gave no gift (gift = 0)?",
  "Data: charity. Estimate gift = b0 + b1 mailsyear + u by OLS. What is the slope on mailsyear?",
  "colgpa-hat = 1.392 - 0.0135 hsperc + 0.00148 sat. What is the predicted college GPA when hsperc = 20 and sat = 1,050?",
  "colgpa-hat = 1.392 - 0.0135 hsperc + 0.00148 sat. Students A and B graduated in the same percentile, but A's SAT score was 140 points higher. What is the predicted difference in college GPA?",
  "colgpa-hat = 1.392 - 0.0135 hsperc + 0.00148 sat. Holding hsperc fixed, what difference in SAT scores leads to a predicted colgpa difference of 0.50?",
  "educ-hat = 10.36 - 0.094 sibs + 0.131 meduc + 0.210 feduc. Holding meduc and feduc fixed, by how much does sibs have to increase to reduce predicted years of education by one year?",
  "educ-hat = 10.36 - 0.094 sibs + 0.131 meduc + 0.210 feduc. Man A has no siblings and his parents each have 12 years of education; Man B has no siblings and his parents each have 16. What is the predicted difference in years of education between B and A?",
  "sleep-hat = 3638.25 - 0.148 totwrk - 11.13 educ + 2.20 age, with sleep and totwrk in minutes per week. If someone works five more hours per week, by how many minutes is sleep predicted to change?",
  "log(salary)-hat = 8.34 + 0.0047 LSAT + 0.248 GPA + 0.095 log(libvol) + 0.038 log(cost) - 0.0033 rank. What is the predicted ceteris paribus difference in salary for schools with a median GPA different by one point? (Report a percentage.)",
  "log(salary)-hat = 8.34 + 0.0047 LSAT + 0.248 GPA + 0.095 log(libvol) + 0.038 log(cost) - 0.0033 rank. How much is a difference in ranking of 20 worth in terms of predicted starting salary? (Report a percentage.)",
  "In the law school salary equation, log(salary) includes 0.095 log(libvol). How do you interpret the coefficient on log(libvol)?",
  "GPA = b0 + b1 study + b2 sleep + b3 work + b4 leisure + u, where for every student study + sleep + work + leisure = 168 hours. Why does this model violate MLR.3?",
  "Which of the following can cause OLS estimators to be biased: heteroskedasticity, omitting an important variable, or a sample correlation of .95 between two included independent variables?",
  "avgprod = b0 + b1 avgtrain + b2 avgabil + u. Grants went to firms whose workers have less than average ability, so avgtrain and avgabil are negatively correlated. What is the likely bias in the simple-regression slope of avgprod on avgtrain?",
  "log(price) = b0 + b1 log(nox) + b2 rooms + u. Rooms raise price, and log(nox) and rooms are negatively correlated. Does the simple regression of log(price) on log(nox) produce an upward or a downward biased estimator of b1?",
  "Data: hprice2. Regress log(price) on log(nox) alone, then on log(nox) and rooms. What is the simple-regression slope on log(nox)?",
  "You regress y on x1 alone and on x1, x2, x3. x1 is highly correlated with x2 and x3, and x2 and x3 have small partial effects on y. Would you expect the simple or the multiple regression se of the x1 slope to be smaller?",
  "growth = b0 + b1 shareP + b2 shareI + b3 shareS + b4 shareF + u, where the four tax shares add up to one. Why must one of the tax share variables be omitted?",
  "Data: bwght. Estimate bwght on cigs with and without faminc. What is the slope on cigs in the regression that includes faminc?",
  "Data: hprice1. Estimate price = b0 + b1 sqrft + b2 bdrms + u. What is the estimated increase in price for a house with one more bedroom, holding square footage constant?",
  "Data: hprice1. Using price on sqrft and bdrms, what is the estimated increase in price for a house with an additional bedroom that is 140 square feet in size?",
  "Data: hprice1. What percentage of the variation in price is explained by square footage and number of bedrooms?",
  "Data: hprice1. The first house in the sample has sqrft = 2,438 and bdrms = 4. Find the predicted selling price for this house from the regression of price on sqrft and bdrms.",
  "Data: hprice1. The actual selling price of the first house was $300,000 (price = 300). Using price on sqrft and bdrms, find the residual for this house.",
  "Data: ceosal2. Estimate log(salary) on log(sales), log(mktval), profits and ceoten. What is the estimated percentage return for another year of CEO tenure, holding other factors fixed?",
  "Data: ceosal2. Estimate a constant elasticity model of salary on sales and market value (log(salary) on log(sales) and log(mktval)). What is the coefficient on log(sales)?",
  "Data: attend (atndrte = percent of classes attended; priGPA = prior GPA; ACT = ACT score). What is the minimum value of atndrte?",
  "Data: attend. Estimate atndrte = b0 + b1 priGPA + b2 ACT + u. What is the predicted atndrte if priGPA = 3.65 and ACT = 20?",
  "Data: attend. Using atndrte on priGPA and ACT: Student A has priGPA = 3.1 and ACT = 21; Student B has priGPA = 2.1 and ACT = 26. What is the predicted difference in their attendance rates (A minus B)?",
  "Data: wage2. Run a simple regression of IQ on educ. What is the slope coefficient (delta-tilde)?",
  "Data: wage2. Run the multiple regression of log(wage) on educ and IQ. What is the slope on educ?",
  "Data: meap93. Run the simple regression of math10 on log(expend) and compare with math10 on log(expend) and lnchprg. What is the simple-regression slope on log(expend)?",
  "Data: discrim (prpblck = proportion black; income = median family income). Find the average value of prpblck in the sample.",
  "Data: discrim. Estimate psoda = b0 + b1 prpblck + b2 income + u. What is the coefficient on prpblck?",
  "Data: discrim. Estimate log(psoda) = b0 + b1 prpblck + b2 log(income) + u. If prpblck increases by .20 (20 percentage points), what is the estimated percentage change in psoda?",
  "Data: htv. What percentage of men completed 12th grade but no higher grade (educ = 12)?",
  "Data: htv. Estimate educ = b0 + b1 motheduc + b2 fatheduc + u. How much sample variation in educ is explained by parents' education (R-squared)?",
  # Wooldridge Ch2-3 in-chapter worked examples
  "Data: vote1 (voteA = percent of the vote received by Candidate A; shareA = Candidate A's percentage of total campaign spending). Regress voteA on shareA. What is the OLS slope?",
  "Data: vote1. Using the regression of voteA on shareA, what is the predicted vote share of Candidate A when shareA = 60?",
  "Data: vote1. What percentage of the variation in voteA is explained by shareA in the simple regression?",
  "Data: ceosal1 (salary = CEO salary in thousands of dollars; roe = return on equity, in percent). Using the OLS regression of salary on roe, what is the residual for the first CEO in the data set (row 1)?",
  "Data: ceosal1. Using the regression of salary on roe, what is the fitted value (salaryhat) for the fifth CEO (row 5)?",
  "Data: ceosal1. In the regression of salary on roe, what percentage of the variation in salary is left unexplained?",
  "Data: wage1 (wage = hourly wage in dollars; educ = years of education). Run the regression of wage on educ. What is the predicted wage at the sample mean of educ?",
  "Data: meap93 (math10 = percent of students passing a math test; lnchprg = percent of students eligible for the school lunch program). Regress math10 on lnchprg. What is the slope on lnchprg?",
  "math10 = b0 + b1 lnchprg + u, where lnchprg measures poverty. Poverty rate is left out. School quality and family resources in u are negatively correlated with lnchprg and raise math scores. Is the simple-regression slope on lnchprg likely biased upward or downward?",
  "Data: gpa1 (colGPA = college GPA; hsGPA = high school GPA; ACT = achievement test score). Estimate colGPA = b0 + b1 hsGPA + b2 ACT + u. What is the coefficient on hsGPA?",
  "Data: gpa1. Using colGPA on hsGPA and ACT, what is the predicted college GPA for a student with hsGPA = 3.4 and ACT = 24?",
  "Data: gpa1. Using colGPA on hsGPA and ACT, holding hsGPA fixed, how much higher is predicted colGPA for a student whose ACT score is 10 points higher?",
  "Data: gpa1. Regress colGPA on ACT alone. What is the simple-regression slope on ACT, and is it larger than the slope on ACT when hsGPA is included?",
  "Data: gpa1. What percentage of the variation in colGPA do hsGPA and ACT explain together?",
  "Data: wage1 (wage = hourly wage; educ = years of education; exper = years of experience; tenure = years with current employer). Run lm(log(wage) ~ educ + exper + tenure, data = wage1). Holding exper and tenure fixed, by about what percent does one more year of education raise predicted wage?",
  "Data: wage1. Using log(wage) on educ, exper and tenure: a worker stays at the same firm for one more year, so exper and tenure both increase by one year. By about what percent does predicted wage change?",
  "Data: k401k (prate = percent of eligible workers participating in the 401(k) plan; mrate = the firm's match rate; age = age of the plan in years). Run lm(prate ~ mrate + age, data = k401k). What is the coefficient on mrate?",
  "Data: k401k. Run the simple regression of prate on mrate, leaving out age. What is the simple-regression slope on mrate?",
  "Data: k401k. Regress age on mrate. What is the slope (delta-tilde) used in formula (3.23) to link the simple and multiple regression slopes on mrate?",
  "Data: k401k. Using prate on mrate and age, what is the predicted participation rate for a plan with mrate = 0.75 and age = 10?",
  "Data: crime1 (narr86 = number of times arrested in 1986; pcnv = proportion of prior arrests that led to conviction; ptime86 = months in prison in 1986; qemp86 = quarters employed in 1986). Run lm(narr86 ~ pcnv + ptime86 + qemp86, data = crime1). What is the coefficient on pcnv?",
  "Data: crime1. Using narr86 on pcnv, ptime86 and qemp86: if pcnv increases by 0.50, holding the other variables fixed, by how much does the predicted number of arrests change?",
  "Data: crime1. Using narr86 on pcnv, ptime86 and qemp86: for a group of 100 men, if pcnv increases by 0.50, by how many arrests does the predicted total change?",
  "Data: crime1. Using narr86 on pcnv, ptime86 and qemp86: if ptime86 increases from 0 to 12 months, by how much does predicted narr86 change?",
  "Data: crime1. Using narr86 on pcnv, ptime86 and qemp86: if a man is employed for 4 more quarters, by how much does predicted narr86 change?",
  "Data: crime1. What percentage of the variation in narr86 is explained by pcnv, ptime86 and qemp86?",
  "Data: crime1. Add avgsen (average sentence length from prior convictions): run lm(narr86 ~ pcnv + avgsen + ptime86 + qemp86, data = crime1). What is the coefficient on avgsen?",
  "log(wage) = b0 + b1 educ + b2 abil + u, but ability is not in the data, so we estimate the simple regression of log(wage) on educ. Ability raises wages and is positively correlated with education. Is the simple-regression slope on educ likely too high or too low?",
  "avgscore = b0 + b1 expend + b2 povrate + u. The poverty rate is not observed, so we regress avgscore on expend alone. Poverty lowers scores, and expend is negatively correlated with povrate. What is the likely direction of the bias in the simple-regression slope on expend?"))
