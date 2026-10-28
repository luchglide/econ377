# =======================================================================
# ECN 377 - EXAM II SCRIPT (Wed Nov 11). Round every answer to hundredths.
# Covers D13 + D15-D23: units & logs, unbiasedness & OVB, Var/se of OLS,
# multiple regression, Gauss-Markov, t-tests (one/two-sided), p-values,
# confidence intervals, F-test. Part E has a quick Exam I refresher.
# =======================================================================
# SETUP (before the exam, internet is off once it starts):
#   1. Pull this repo, open it as an RStudio project (so data/ is found).
#   2. Run the WHOLE file once: Ctrl+Shift+Enter (Mac: Cmd+Shift+Enter).
#      Every block prints ">>> ANSWER"; each comment says what the default
#      numbers should give. If they match, you're set.
# DURING THE EXAM:
#   1. Ctrl+F the tag in the table of contents (e.g. "[C9]").
#   2. Change ONLY the lines marked  # <-- CHANGE.
#   3. Highlight the block, Ctrl+Enter. Read the ">>> ANSWER" / ">>> PICK" lines.
# SIGN RULE: "falls/decreases/drops" -> type the change as NEGATIVE.
# TIME RULE: Exam I ran out of time. Do Part III (real data) with [B2] first;
#            one REG() line answers most of those questions at once.
# =======================================================================
# TABLE OF CONTENTS (Ctrl+F the tag)
#  PART B - REAL DATA (wooldridge)
#   [B1] n, mean, sd, correlation of variables          STATS()
#   [B2] regression report: coefs, se, t, p, CI, R^2,   REG()
#        SST/SSE/SSR, sigma-hat, prediction, change,
#        residual of row i, t-test of b = a
#   [B3] omitted-variable bias with data (3.23 check)   OVB()
#   [B4] F-test, restricted vs unrestricted model       FTEST()
#  PART C - HAND FORMULAS (numbers typed in the question)
#   [C1] reading log models (level/log combos)
#   [C2] units of measurement (rescale y or x)
#   [C3] MLR prediction (keeps intercept; exp() for log y)
#   [C4] MLR predicted change (intercept drops)
#   [C5] SST_X, Var(b1), sd/se(b1), VIF
#   [C6] sd(b1) when sample is k times as large / sigma changes
#   [C7] sigma^2-hat = SSR/(n-k-1)
#   [C8] OVB formula (3.23), bias = b2*delta1, sign table
#   [C9] t-test from b, se (and h0) -> t, critical values, p, decisions
#   [C10] decision from a given t and c, or a given p-value
#   [C11] critical value table (qt)
#   [C12] confidence interval; back out b and se from a CI
#   [C13] F-statistic (R^2 form and SSR form)
#  PART D - CONCEPTS (multiple choice / true-false)
#  PART E - EXAM I REFRESHER (the question types missed on Exam I)
# =======================================================================

rm(list = ls())
ans  <- function(label, x) cat(sprintf(">>> ANSWER %-36s %s\n", label, format(round(unname(x), 2), nsmall = 2)))
pick <- function(label, x) cat(sprintf(">>> PICK   %-36s %s\n", label, x))
ans4 <- function(label, x) cat(sprintf(">>> ANSWER %-36s %s\n", label, format(round(unname(x), 4), nsmall = 4)))
info <- function(label, x) cat(sprintf("    %-43s %s\n", label, x))
## Loads a wooldridge dataset by name. Falls back to data/<name>.csv offline.
get_data <- function(name) {
  if (requireNamespace("wooldridge", quietly = TRUE)) {
    e <- new.env(); data(list = name, package = "wooldridge", envir = e); get(name, e)
  } else read.csv(file.path("data", paste0(name, ".csv")))
}
for (d in c("wage1", "ceosal1", "bwght", "gpa1", "campus", "rdchem", "mlb1", "meap93"))
  assign(d, get_data(d))
## Any other dataset:  hprice1 <- get_data("hprice1")

## ---- STATS(): n, mean, sd, var, min, max, and correlations -------------------
STATS <- function(data, vars) {
  cat(sprintf("\n--- STATS: dataset has n = %d rows ---\n", nrow(data)))
  for (v in vars) {
    x <- data[[v]]
    cat(sprintf(">>> ANSWER %-14s n=%d  mean=%.2f  sd=%.2f  var=%.2f  min=%.2f  max=%.2f\n",
                v, sum(!is.na(x)), mean(x, na.rm = TRUE), sd(x, na.rm = TRUE),
                var(x, na.rm = TRUE), min(x, na.rm = TRUE), max(x, na.rm = TRUE)))
  }
  if (length(vars) > 1) {
    cat("    correlation matrix:\n"); print(round(cor(data[vars], use = "complete.obs"), 4))
    cat("    covariance matrix:\n");  print(round(cov(data[vars], use = "complete.obs"), 4))
  }
}

## ---- REG(): one call answers most real-data questions ---------------------------
## formula : y ~ x1 + x2 ...   (log(y), log(x) allowed)
## at      : list(x1 = , x2 = )  predicted value at these x's (missing x's -> their mean)
## from,to : list(...)           predicted CHANGE from one set of x's to another
## row     : row number          actual, fitted and residual of that observation
## test    : "x1"                t-test of H0: b = h0 at significance alpha
REG <- function(formula, data, at = NULL, from = NULL, to = NULL, row = NULL,
                test = NULL, h0 = 0, alpha = 0.05, level = 0.95) {
  fit <- lm(formula, data = data)
  s   <- summary(fit); ct <- coef(s)
  n   <- nobs(fit); df <- fit$df.residual; k <- length(coef(fit)) - 1
  yname <- deparse(formula[[2]]); logy <- grepl("^log\\(", yname)
  ci  <- confint(fit, level = level)
  cat(sprintf("\n===== REG: %s   (n = %d, k = %d, df = n-k-1 = %d) =====\n",
              deparse(formula), n, k, df))
  tab <- cbind(estimate = ct[, 1], se = ct[, 2], t = ct[, 3], p = ct[, 4], ci)
  colnames(tab)[5:6] <- paste0(c("CI_low_", "CI_high_"), level * 100)
  print(round(tab, 4))
  yv  <- model.response(model.frame(fit))
  SSR <- sum(resid(fit)^2); SST <- sum((yv - mean(yv))^2); SSE <- SST - SSR
  ans("R^2", s$r.squared); ans("R^2 in percent", 100 * s$r.squared)
  ans("adjusted R^2", s$adj.r.squared)
  ans("SST (total)", SST); ans("SSE (EXPLAINED)", SSE); ans("SSR (RESIDUAL)", SSR)
  ans("sigma-hat = sqrt(SSR/(n-k-1))", s$sigma); ans("sigma^2-hat", s$sigma^2)
  if (k > 0) ans("overall F-stat (all slopes = 0)", s$fstatistic[1])
  vars <- all.vars(formula)[-1]
  base <- lapply(model.frame(lm(reformulate(vars, yname), data = data))[vars], mean)
  pred <- function(vals) { nd <- base; nd[names(vals)] <- vals; predict(fit, as.data.frame(nd)) }
  if (!is.null(at)) {
    miss <- setdiff(vars, names(at))
    if (length(miss)) info("WARNING: set to their mean:", paste(miss, collapse = ", "))
    p <- pred(at); ans(paste0("prediction of ", yname), p)
    if (logy) ans("prediction in levels = exp(above)", exp(p))
  }
  if (!is.null(from) && !is.null(to)) {
    dd <- pred(to) - pred(from); ans(paste0("change in ", yname), dd)
    if (logy) { ans("% change in y (approx 100*change)", 100 * dd)
                ans("% change in y (exact)", 100 * (exp(dd) - 1)) }
  }
  if (!is.null(row)) {
    r <- as.character(row)
    ans(paste0("row ", row, " actual ", yname), yv[r])
    ans(paste0("row ", row, " fitted value"), fitted(fit)[r])
    ans(paste0("row ", row, " residual (actual-fitted)"), resid(fit)[r])
  }
  if (!is.null(test)) {
    b <- ct[test, 1]; se <- ct[test, 2]; t <- (b - h0) / se
    c2 <- qt(1 - alpha / 2, df); c1 <- qt(1 - alpha, df)
    cat(sprintf("--- t-test on %s:  H0: b = %g,  alpha = %g ---\n", test, h0, alpha))
    ans("t = (b - h0)/se", t)
    ans("two-sided critical value c", c2); ans("one-sided critical value c", c1)
    ans("p-value two-sided  (H1: b != h0)", 2 * pt(-abs(t), df))
    ans("p-value one-sided  (H1: b >  h0)", pt(t, df, lower.tail = FALSE))
    ans("p-value one-sided  (H1: b <  h0)", pt(t, df))
    pick("H1: b != h0", ifelse(abs(t) > c2, "REJECT H0", "fail to reject H0"))
    pick("H1: b >  h0", ifelse(t > c1, "REJECT H0", "fail to reject H0"))
    pick("H1: b <  h0", ifelse(t < -c1, "REJECT H0", "fail to reject H0"))
  }
  invisible(fit)
}

## ---- OVB(): simple vs multiple slope and formula (3.23) -------------------------
## y on x1 alone vs y on x1 + x2. delta1 = slope of x2 on x1.
OVB <- function(y, x1, x2, data) {
  simple <- coef(lm(reformulate(x1, y), data = data))[x1]
  multi  <- coef(lm(reformulate(c(x1, x2), y), data = data))
  delta1 <- coef(lm(reformulate(x1, x2), data = data))[x1]
  cat(sprintf("\n===== OVB: %s on %s, omitted/added %s =====\n", y, x1, x2))
  ans4("b1-tilde (simple, x2 left out)", simple)
  ans4("b1-hat (multiple, x2 included)", multi[x1])
  ans4("b2-hat (coef on x2 in multiple)", multi[x2])
  ans4("delta1 (slope of x2 on x1)", delta1)
  ans4("b2-hat * delta1 (= bias part)", multi[x2] * delta1)
  ans4("check: b1-tilde - b1-hat", simple - multi[x1])
}

## ---- FTEST(): H0: the variables dropped in 'restricted' all have b = 0 -----------
FTEST <- function(unrestricted, restricted, data, alpha = 0.05) {
  dat <- data[complete.cases(data[all.vars(unrestricted)]), ]
  fu <- lm(unrestricted, data = dat); fr <- lm(restricted, data = dat)
  SSRu <- sum(resid(fu)^2); SSRr <- sum(resid(fr)^2)
  q <- fr$df.residual - fu$df.residual; dfu <- fu$df.residual
  Fs <- ((SSRr - SSRu) / q) / (SSRu / dfu); cF <- qf(1 - alpha, q, dfu)
  cat(sprintf("\n===== F-test: q = %d restrictions, df = %d =====\n", q, dfu))
  ans("SSR restricted", SSRr); ans("SSR unrestricted", SSRu)
  ans("R^2 restricted", summary(fr)$r.squared); ans("R^2 unrestricted", summary(fu)$r.squared)
  ans("F-statistic", Fs); ans("critical value c", cF)
  ans("p-value", pf(Fs, q, dfu, lower.tail = FALSE))
  pick("decision", ifelse(Fs > cF, "REJECT H0 (jointly significant)", "fail to reject H0"))
}

cat("\n#################### PART B - REAL DATA ####################\n")
## These defaults are the actual Exam I Part III questions. The correct
## Canvas answers are in the comments, so they double as a self-check.

## [B1] n, mean, correlation --------------------------------------------------
## ceosal1: n = 209, mean roe = 17.18, cor(salary, roe) = 0.11
STATS(ceosal1, c("salary", "roe"))                             # <-- CHANGE dataset, variables

## [B2] regression report -------------------------------------------------------
## wage1, wage on tenure: slope 0.18 | wage at tenure 10 = 6.76 | change 3 -> 16 = 2.31
## | R^2 % = 12.03 | residual of row 2 = -2.11
REG(wage ~ tenure, data = wage1,                               # <-- CHANGE formula, data
    at = list(tenure = 10),                                    # <-- CHANGE (or delete line)
    from = list(tenure = 3), to = list(tenure = 16),           # <-- CHANGE (or delete line)
    row = 2)                                                   # <-- CHANGE (or delete line)
## bwght, bwght on faminc: SSE (explained) = 6819.05 | change from +17 income = 2.01
REG(bwght ~ faminc, data = bwght, from = list(faminc = 0), to = list(faminc = 17))

## Exam II style. Example 4.1: is the return to experience positive (H1: b > 0)?
## exper: t = 2.39 > c = 1.65 -> reject. Example 3.2 prediction at 16/4/2 = 6.16
REG(log(wage) ~ educ + exper + tenure, data = wage1,
    at = list(educ = 16, exper = 4, tenure = 2),
    from = list(educ = 12), to = list(educ = 13),              # +1 educ, others fixed
    test = "exper", h0 = 0, alpha = 0.05)
## Example 4.4 style (campus): H0: elasticity = 1. t = (1.27 - 1)/0.11 = 2.46
REG(log(crime) ~ log(enroll), data = campus, test = "log(enroll)", h0 = 1)
## Example 4.8 (rdchem): 95% CI for log(sales) is [0.96, 1.21] -> 1 is inside
REG(log(rd) ~ log(sales) + profmarg, data = rdchem, level = 0.95)

## [B3] omitted-variable bias with data -------------------------------------------
## Example 3.1/3.3 gpa1: ACT alone 0.0271; with hsGPA 0.0094; delta1 = 0.0389
OVB(y = "colGPA", x1 = "ACT", x2 = "hsGPA", data = gpa1)      # <-- CHANGE names, data

## [B4] F-test -----------------------------------------------------------------
## Example 4.9 (mlb1): drop bavg, hrunsyr, rbisyr -> F = 9.55, reject
FTEST(log(salary) ~ years + gamesyr + bavg + hrunsyr + rbisyr,   # <-- CHANGE unrestricted
      log(salary) ~ years + gamesyr,                             # <-- CHANGE restricted
      data = mlb1)

cat("\n#################### PART C - HAND FORMULAS ####################\n")

## [C1] reading log models ------------------------------------------------------
## Find where the log is: logged side = PERCENT, unlogged side = UNITS.
## Defaults b1 = 0.083: level-level 0.08 | log-level 8.30% | level-log 0.01 | log-log 0.83%
c1_b1   <- 0.083   # <-- CHANGE slope
c1_dx   <- 1       # <-- CHANGE change in x in UNITS (falls = negative)
c1_pctx <- 10      # <-- CHANGE change in x in PERCENT (falls = negative)
ans("[C1] IF y ~ x:          dy (units)", c1_b1 * c1_dx)
ans("[C1] IF log(y) ~ x:     %dy approx", 100 * c1_b1 * c1_dx)
ans("[C1] IF log(y) ~ x:     %dy exact", 100 * (exp(c1_b1 * c1_dx) - 1))
ans("[C1] IF y ~ log(x):     dy (units)", c1_b1 / 100 * c1_pctx)
ans("[C1] IF log(y)~log(x):  %dy", c1_b1 * c1_pctx)
pick("[C1] words: y ~ log(x)", "1% rise in x -> b1/100 UNITS of y")
pick("[C1] words: log(y) ~ x", "1 unit rise in x -> 100*b1 PERCENT in y")
pick("[C1] words: log(y)~log(x)", "1% rise in x -> b1 PERCENT in y (elasticity)")

## [C2] units of measurement -----------------------------------------------------
## y times cy, x times cx (salary $000s -> $: cy = 1000; roe % -> decimal: cx = 1/100).
## Defaults (963.191 + 18.501 roe), cy = 1000: new b0 = 963191, new b1 = 18501
c2_b0 <- 963.191   # <-- CHANGE
c2_b1 <- 18.501    # <-- CHANGE
c2_cy <- 1000      # <-- CHANGE what y is MULTIPLIED by (1 if y unchanged)
c2_cx <- 1         # <-- CHANGE what x is MULTIPLIED by (1 if x unchanged; /100 -> 1/100)
ans("[C2] level y: new intercept = cy*b0", c2_cy * c2_b0)
ans("[C2] level y: new slope = cy*b1/cx", c2_cy * c2_b1 / c2_cx)
ans("[C2] log(y): new intercept = b0+log(cy)", c2_b0 + log(c2_cy))
ans("[C2] log(y): new slope = b1/cx", c2_b1 / c2_cx)
pick("[C2] R^2 after any rescaling", "UNCHANGED (also t-stats unchanged)")

## [C3] MLR prediction (KEEP the intercept) --------------------------------------
## Default (Example 3.2, log wage): log-hat = 1.82, wage = exp(...) = 6.15
c3_b <- c(0.284, 0.092, 0.0041, 0.022)  # <-- CHANGE b0, b1, b2, ... (keep minus signs)
c3_x <- c(16, 4, 2)                      # <-- CHANGE x1, x2, ... (same order)
c3_logy <- TRUE                          # <-- CHANGE TRUE if left side is log(y)
c3_yhat <- c3_b[1] + sum(c3_b[-1] * c3_x)
ans("[C3] yhat", c3_yhat)
if (c3_logy) ans("[C3] y in levels = exp(yhat)", exp(c3_yhat))

## [C4] MLR predicted change (intercept DROPS) -------------------------------------
## Default: 0.6 educ + 0.07 exper, +1 educ, exper fixed -> 0.60
c4_b  <- c(0.6, 0.07)        # <-- CHANGE slopes only (keep minus signs)
c4_dx <- c(1, 0)             # <-- CHANGE changes (held fixed = 0, falls = negative)
c4_logy <- FALSE             # <-- CHANGE TRUE if left side is log(y)
ans("[C4] change in yhat", sum(c4_b * c4_dx))
if (c4_logy) ans("[C4] % change in y = 100*change", 100 * sum(c4_b * c4_dx))

## [C5] SST_X, Var(b1), sd/se(b1) ---------------------------------------------------
## Var(bj) = sigma^2 / (SST_j * (1 - R_j^2)).  SST_X = (n-1)*S_X^2 = sum((x-mean)^2)
## Default (D16): sigma 4, n 26, S_X^2 4 -> SST_X = 100, Var = 0.16, sd = 0.40
c5_n     <- 26        # <-- CHANGE n
c5_SX2   <- 4         # <-- CHANGE sample VARIANCE of X. Given the SD? type it squared: 1.7^2
c5_x     <- NULL      # <-- CHANGE OR raw x values, e.g. c(2,3,4,5,9) (overrides n and SX2)
c5_sigma <- 4         # <-- CHANGE sigma (or sigma-hat). Given sigma^2? type sqrt(66)
c5_SSR   <- NA        # <-- CHANGE OR give SSR: sigma-hat = sqrt(SSR/(n-k-1)) (overrides sigma)
c5_k     <- 1         # <-- CHANGE number of slopes (1 in simple regression)
c5_Rj2   <- 0         # <-- CHANGE MLR only: R^2 of x_j on the other x's (0 for simple)
if (!is.null(c5_x)) { c5_n <- length(c5_x); c5_SST <- sum((c5_x - mean(c5_x))^2)
} else c5_SST <- (c5_n - 1) * c5_SX2
if (!is.na(c5_SSR)) c5_sigma <- sqrt(c5_SSR / (c5_n - c5_k - 1))
ans("[C5] SST_X", c5_SST)
ans("[C5] sigma (or sigma-hat) used", c5_sigma)
ans("[C5] VIF = 1/(1-Rj^2)", 1 / (1 - c5_Rj2))
ans("[C5] Var(b1)", c5_sigma^2 / (c5_SST * (1 - c5_Rj2)))
ans("[C5] sd(b1) = se(b1)", c5_sigma / sqrt(c5_SST * (1 - c5_Rj2)))

## [C6] sd(b1) when things change ---------------------------------------------------
## sd = sigma/sqrt(SST_X): SST_X times k -> sd / sqrt(k); sigma times m -> sd times m
## Default: 0.32, sample 2x -> 0.23
c6_sd <- 0.32   # <-- CHANGE original sd(b1)
c6_k  <- 2      # <-- CHANGE sample k times as large (half -> 0.5; 1 if unchanged)
c6_m  <- 1      # <-- CHANGE sigma multiplied by m (doubles -> 2; 1 if unchanged)
ans("[C6] new sd(b1)", c6_sd * c6_m / sqrt(c6_k))

## [C7] sigma^2-hat = SSR / (n - k - 1) -----------------------------------------------
## Default: SSR 450, n 30, k 3 -> 17.31, sigma-hat 4.16
c7_SSR <- 450; c7_n <- 30; c7_k <- 3     # <-- CHANGE (k = number of SLOPES)
ans("[C7] df = n-k-1", c7_n - c7_k - 1)
ans("[C7] sigma^2-hat", c7_SSR / (c7_n - c7_k - 1))
ans("[C7] sigma-hat (SER)", sqrt(c7_SSR / (c7_n - c7_k - 1)))

## [C8] omitted-variable bias -----------------------------------------------------------
## (3.23): b1-tilde = b1-hat + b2-hat * delta1. Put NA on the one they ask for.
## Defaults: 0.25 + 1.44*0.11 = 0.41 | bias = -1.17 * -0.26 = 0.30
c8_b1tilde <- NA      # <-- CHANGE simple-regression slope (x2 left out)
c8_b1hat   <- 0.25    # <-- CHANGE multiple-regression slope on x1
c8_b2hat   <- 1.44    # <-- CHANGE slope on x2 (in the true / multiple model)
c8_delta1  <- 0.11    # <-- CHANGE slope from regressing x2 on x1
if (is.na(c8_b1tilde)) ans("[C8] b1-tilde", c8_b1hat + c8_b2hat * c8_delta1)
if (is.na(c8_b1hat))   ans("[C8] b1-hat",   c8_b1tilde - c8_b2hat * c8_delta1)
if (is.na(c8_b2hat))   ans("[C8] b2-hat",   (c8_b1tilde - c8_b1hat) / c8_delta1)
if (is.na(c8_delta1))  ans("[C8] delta1",   (c8_b1tilde - c8_b1hat) / c8_b2hat)
c8_beta2 <- -1.17; c8_d <- -0.26          # <-- CHANGE for "Bias = beta2 * delta1"
ans("[C8] Bias(b1-tilde) = beta2*delta1", c8_beta2 * c8_d)
## Sign table: bias sign = sign(beta2) * sign(corr(x1, x2))
##                  corr(x1,x2) > 0     corr(x1,x2) < 0
##   beta2 > 0      UPWARD (+)          DOWNWARD (-)
##   beta2 < 0      DOWNWARD (-)        UPWARD (+)
c8_sign_b2 <- +1; c8_sign_corr <- +1      # <-- CHANGE +1 / -1
pick("[C8] bias direction", ifelse(c8_sign_b2 * c8_sign_corr > 0, "UPWARD (overstates)", "DOWNWARD (understates)"))
pick("[C8] NO bias when", "beta2 = 0 OR x1 and x2 uncorrelated (delta1 = 0)")

## [C9] t-test from an estimate and se ----------------------------------------------------
## t = (b - h0)/se. df = n - k - 1. Prints all three H1's: use the one asked.
## Default (D20): b 0.54, se 0.05 -> t = 10.80, reject in every direction except H1: b < 0
c9_b  <- 0.54      # <-- CHANGE estimate
c9_se <- 0.05      # <-- CHANGE standard error
c9_h0 <- 0         # <-- CHANGE null value a in H0: b = a (usually 0)
c9_df <- 524       # <-- CHANGE df = n - k - 1
c9_alpha <- 0.05   # <-- CHANGE significance level (5% = 0.05)
c9_t  <- (c9_b - c9_h0) / c9_se
c9_c2 <- qt(1 - c9_alpha / 2, c9_df); c9_c1 <- qt(1 - c9_alpha, c9_df)
ans("[C9] t-statistic", c9_t)
ans("[C9] critical c, two-sided", c9_c2)
ans("[C9] critical c, one-sided", c9_c1)
ans("[C9] p-value two-sided", 2 * pt(-abs(c9_t), c9_df))
ans("[C9] p-value one-sided H1: b > a", pt(c9_t, c9_df, lower.tail = FALSE))
ans("[C9] p-value one-sided H1: b < a", pt(c9_t, c9_df))
pick("[C9] H1: b != a (reject if |t| > c)", ifelse(abs(c9_t) > c9_c2, "REJECT H0", "fail to reject"))
pick("[C9] H1: b >  a (reject if t > c)",   ifelse(c9_t > c9_c1, "REJECT H0", "fail to reject"))
pick("[C9] H1: b <  a (reject if t < -c)",  ifelse(c9_t < -c9_c1, "REJECT H0", "fail to reject"))

## [C10] decision from a given t and c, or from a p-value ---------------------------------
## Default (D21): c = 1.68, t = 2.4 -> reject for H1: b > 0. (t = -3.0 with H1: b > 0 -> fail)
c10_t <- 2.4      # <-- CHANGE t
c10_c <- 1.68     # <-- CHANGE critical value they give (positive number)
pick("[C10] H1: b != 0", ifelse(abs(c10_t) > c10_c, "REJECT H0", "fail to reject"))
pick("[C10] H1: b >  0", ifelse(c10_t > c10_c, "REJECT H0", "fail to reject"))
pick("[C10] H1: b <  0", ifelse(c10_t < -c10_c, "REJECT H0", "fail to reject"))
c10_p <- 0.03     # <-- CHANGE p-value
for (a in c(0.10, 0.05, 0.01))
  pick(sprintf("[C10] p = %g at alpha = %g", c10_p, a), ifelse(c10_p < a, "REJECT H0", "fail to reject"))

## [C11] critical value table ---------------------------------------------------------------
c11_df <- 25      # <-- CHANGE df = n - k - 1
for (a in c(0.10, 0.05, 0.01)) {
  ans(sprintf("[C11] df=%d alpha=%.2f one-sided", c11_df, a), qt(1 - a, c11_df))
  ans(sprintf("[C11] df=%d alpha=%.2f two-sided", c11_df, a), qt(1 - a / 2, c11_df))
}
## Large df (> 120): one-sided 1.28 / 1.645 / 2.33,  two-sided 1.645 / 1.96 / 2.58

## [C12] confidence interval -------------------------------------------------------------------
## CI = b +/- c*se. "a inside the CI" = fail to reject H0: b = a (two-sided, same level).
## Default (D23): 0.30, se 0.10, c 1.96 -> [0.10, 0.50]; 0 outside -> reject
c12_b  <- 0.30     # <-- CHANGE estimate
c12_se <- 0.10     # <-- CHANGE se
c12_c  <- 1.96     # <-- CHANGE c given. If they give df and level instead: qt(1 - (1-0.95)/2, df)
c12_a  <- 0        # <-- CHANGE value to check (H0: b = a)
c12_lo <- c12_b - c12_c * c12_se; c12_hi <- c12_b + c12_c * c12_se
ans("[C12] CI lower", c12_lo); ans("[C12] CI upper", c12_hi)
pick(sprintf("[C12] is %g inside?", c12_a), ifelse(c12_a >= c12_lo & c12_a <= c12_hi,
     "YES inside -> fail to reject H0", "NO outside -> REJECT H0"))
## Back out b and se from a reported CI:
c12_L <- 0.10; c12_U <- 0.50     # <-- CHANGE reported lower, upper
ans("[C12] b-hat = midpoint", (c12_L + c12_U) / 2)
ans("[C12] se = (U - L)/(2c)", (c12_U - c12_L) / (2 * c12_c))

## [C13] F-statistic --------------------------------------------------------------------------------
## F = ((SSR_r - SSR_ur)/q) / (SSR_ur/(n-k-1))  =  ((R2_ur - R2_r)/q) / ((1 - R2_ur)/(n-k-1))
## k = slopes in the UNRESTRICTED model, q = number of variables dropped.
## Default (Example 4.9): 198.311, 183.186, q 3, n 353, k 5 -> F = 9.55
c13_SSRr <- 198.311; c13_SSRur <- 183.186   # <-- CHANGE (or use the R^2 lines)
c13_R2r  <- NA;      c13_R2ur  <- NA        # <-- CHANGE if given R^2 instead (else NA)
c13_q <- 3; c13_n <- 353; c13_k <- 5        # <-- CHANGE
c13_df <- c13_n - c13_k - 1
c13_F <- if (!is.na(c13_R2ur)) ((c13_R2ur - c13_R2r) / c13_q) / ((1 - c13_R2ur) / c13_df) else
         ((c13_SSRr - c13_SSRur) / c13_q) / (c13_SSRur / c13_df)
ans("[C13] F-statistic", c13_F)
ans("[C13] 5% critical value", qf(0.95, c13_q, c13_df))
ans("[C13] p-value", pf(c13_F, c13_q, c13_df, lower.tail = FALSE))
pick("[C13] decision (5%)", ifelse(c13_F > qf(0.95, c13_q, c13_df), "REJECT H0: jointly significant", "fail to reject"))

cat("\n#################### PART D - CONCEPTS ####################\n")
## ---- Assumptions (MLR) ----
pick("MLR.1", "linear in parameters")
pick("MLR.2", "random sample")
pick("MLR.3", "no PERFECT collinearity (x not an exact combo of others)")
pick("MLR.4", "zero conditional mean E[U|X1..Xk] = 0")
pick("MLR.5", "homoskedasticity Var(U|X) = sigma^2")
pick("MLR.6", "U ~ Normal(0, sigma^2), indep of X -> t and F exact")
pick("MLR.1-4 give", "UNBIASED: E[b-hat] = b (right on AVERAGE)")
pick("MLR.1-5 give", "Gauss-Markov: OLS is BLUE (Best Linear Unbiased)")
pick("MLR.1-6 give", "t-stats have a t(n-k-1) distribution")
pick("Heteroskedasticity (MLR.5 fails)", "still UNBIASED; se/t-tests invalid")
pick("Omitted var affects y AND corr w/ x", "BIASED (MLR.4 fails)")
pick("Irrelevant variable added", "still unbiased; Var(b) can rise")
pick("High (not perfect) collinearity", "allowed; Var(bj) bigger (VIF up)")
pick("Perfect collinearity examples", "x and 2x; shares summing to 1; same var in 2 units")
## ---- Unbiasedness & variance ----
pick("Unbiased means", "AVERAGE of b-hat over many samples = b")
pick("Var(b1) BIGGER when", "bigger sigma^2, smaller n, x bunched (small SST), high Rj^2")
pick("Var(b1) SMALLER when", "smaller sigma^2, bigger n, x spread out, low Rj^2")
pick("Why prefer small Var", "estimates land closer to b; more reliable/precise")
pick("se vs sd", "sd uses true sigma; se plugs in sigma-hat")
## ---- MLR interpretation ----
pick("bj means", "change in y from +1 xj HOLDING the other x's FIXED")
pick("Prediction vs change", "prediction KEEPS intercept; change DROPS it")
pick("Adding a regressor", "R^2 never falls; adjusted R^2 can")
## ---- Testing ----
pick("t-stat", "(b-hat - a)/se: how many se's from the null value")
pick("Two-sided", "reject if |t| > c   (H1: b != a)")
pick("One-sided >", "reject if t > c    (H1: b > a)")
pick("One-sided <", "reject if t < -c   (H1: b < a)")
pick("p-value", "smallest alpha at which H0 is rejected; reject if p < alpha")
pick("p = 0.03 means", "reject at 5% and 10%, NOT at 1%")
pick("Small p-value", "evidence AGAINST H0 (not prob H0 true)")
pick("Statistically significant", "reject H0: b = 0 (not the same as big/important)")
pick("summary() t and p columns", "test H0: b = 0, two-sided")
pick("Lower alpha (1% vs 5%)", "bigger c, HARDER to reject")
pick("95% CI", "b +/- c*se; a inside -> fail to reject b = a at 5%")
pick("Wider CI when", "bigger se, higher confidence level (99% > 95%)")
pick("F-test", "JOINT test that several b's = 0; F >= 0; reject if F > c")
pick("Jointly sig. but each t insignif.", "possible: multicollinearity")

cat("\n#################### PART E - EXAM I REFRESHER ####################\n")
## The Exam I question types that were left blank or missed. "(Exam I: x)" = the
## correct Canvas answer for those exact numbers; the rest use made-up numbers.
e_r   <- 0.45                                   # correlation after rescaling income (Exam I: 0.45)
pick("[E1] rescaled correlation", sprintf("unchanged: %.2f (covariance would change)", e_r))
e_v   <- c(49, rep(5, 18))                      # 19 numbers: first 49, rest 5 (Exam I: 7.32)
ans("[E2] sample mean", mean(e_v))
e_b <- c(2.6, -0.7); e_dx <- c(1, -3)           # +1 x1, x2 falls by 3 (made-up slopes) -> 4.70
ans("[E3] change dy = b1*dx1 + b2*dx2", sum(e_b * e_dx))
e_old <- 5.6; e_new <- 6.6                      # (Exam I: 17.86 percent); 1 percentage point
ans("[E4] percent change", 100 * (e_new - e_old) / e_old); ans("[E4] pp change", e_new - e_old)
e_cov <- 6; e_sx <- 2; e_sy2 <- 41.6            # cor = cov/(sx*sy); given a VARIANCE -> sqrt it
ans("[E5] correlation", e_cov / (e_sx * sqrt(e_sy2)))
e_EX <- 4; e_EX2 <- 178                          # sd from E[X], E[X^2] (made-up) -> 12.73
ans("[E6] sd(X)", sqrt(e_EX2 - e_EX^2))
e_y <- c(6, 14, 34); e_p <- c(0.5, 0.3, 0.2)     # Y | X table (Exam I values)
e_a7 <- 3; e_b7 <- 4                             # E[aY + b | X] = a*E[Y|X] + b (made-up a, b) -> 46
ans("[E7] E[Y] from table", sum(e_y * e_p)); ans("[E7] E[Y^2]", sum(e_y^2 * e_p))
ans("[E7] E[aY + b]", e_a7 * sum(e_y * e_p) + e_b7)
ans("[E7] Var(Y) from table", sum(e_y^2 * e_p) - sum(e_y * e_p)^2)
e_a <- 2; e_bb <- -3; e_vx <- 9; e_vy <- 4; e_cxy <- 1.2   # Var(aX+bY) = a^2VX + b^2VY + 2abCov (made-up)
ans("[E8] Var(aX + bY)", e_a^2 * e_vx + e_bb^2 * e_vy + 2 * e_a * e_bb * e_cxy)
e_x <- c(1, 4, 5, 6); e_yy <- c(4, 7, 4, 2); e_pp <- c(0.1, 0.4, 0.3, 0.2)  # joint table (Exam I: Cor = -0.43)
e_EXv <- sum(e_x * e_pp); e_EYv <- sum(e_yy * e_pp)
e_cv <- sum(e_x * e_yy * e_pp) - e_EXv * e_EYv
ans("[E9] Cov from joint table", e_cv)
ans("[E9] Cor from joint table", e_cv / sqrt((sum(e_x^2 * e_pp) - e_EXv^2) * (sum(e_yy^2 * e_pp) - e_EYv^2)))
e_sx2 <- c(2, 4, 6, 8, 10); e_sy <- c(3, 7, 5, 9, 12); e_i <- 3   # OLS by hand on a small sample (made-up)
e_b1 <- cov(e_sx2, e_sy) / var(e_sx2); e_b0 <- mean(e_sy) - e_b1 * mean(e_sx2)
e_u <- e_sy - (e_b0 + e_b1 * e_sx2)
ans("[E10] OLS slope", e_b1); ans("[E10] OLS intercept", e_b0)
ans("[E10] residual of obs i", e_u[e_i])
ans("[E10] sum(x * uhat)  (always 0)", sum(e_sx2 * e_u))
e_SSE <- 410; e_R2 <- 0.4                        # SSR from SSE and R^2: SST = SSE/R^2 (Exam I: 615)
ans("[E11] SSR = SSE/R^2 - SSE", e_SSE / e_R2 - e_SSE)
e_n <- 44; e_S2 <- 7                             # SST = (n-1)*S^2 (Exam I: 301)
ans("[E12] SST = (n-1)*S_y^2", (e_n - 1) * e_S2)
e_b0b <- 6; e_b1b <- 1; e_xbar <- 10             # ybar = b0 + b1*xbar (Exam I: 16)
ans("[E13] ybar = b0 + b1*xbar", e_b0b + e_b1b * e_xbar)
e_known <- c(-0.7, 2.3, 2.3, 1.8)                # missing residual (Exam I: -5.70)
ans("[E14] missing residual = -sum(others)", -sum(e_known))
