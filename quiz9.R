# =====================================================================
# ECN 377 - QUIZ 9 SCRIPT (PS10). Round every answer to the hundredths.
# =====================================================================
# BEFORE THE QUIZ (internet is off once it starts):
#   1. Pull this repo, open it as an RStudio project (so data/ is found).
#   2. Press Ctrl+Shift+Enter (Mac: Cmd+Shift+Enter) once. Every block
#      should print the "PS10 answer" shown in its comments. If it does,
#      you're set.
# DURING THE QUIZ:
#   1. Match the quiz question to a block below by its wording.
#   2. Change ONLY the lines marked  # <-- CHANGE.
#   3. Re-run the whole file (Ctrl/Cmd+Shift+Enter) and read that block's
#      ">>> ANSWER" line. Type it with two decimals (2.00, not 2).
# Quiz 9 = PS10 problems #1 2 3 4 6 7 9 12 13 14 15 (new numbers).
# Canvas shows an intro first, so Canvas "question 2" = problem #1.
# SIGN RULE: "falls", "decreases", "drops" -> type the change as NEGATIVE.
# =====================================================================
if (requireNamespace("wooldridge", quietly = TRUE)) {
  data("ceosal1", package = "wooldridge"); data("wage1", package = "wooldridge")
  data("bwght", package = "wooldridge")
} else {
  ceosal1 <- read.csv("data/ceosal1.csv")
  wage1   <- read.csv("data/wage1.csv")
  bwght   <- read.csv("data/bwght.csv")
}
ans  <- function(label, x) cat(sprintf(">>> ANSWER %-30s %s\n", label, format(round(unname(x), 2), nsmall = 2)))
pick <- function(label, x) cat(sprintf(">>> PICK   %-30s %s\n", label, x))
info <- function(label, x) cat(sprintf("    %-37s %s\n", label, x))

cat("\n################ QUIZ 9 ITEMS ################\n")

# ---------------------------------------------------------------------
# #1  MULTIPLE CHOICE: "yhat = 12 + 8 log(income). What does the 8 mean?"
#     PS10 answer: "A 1% rise in income ... about 0.08 points in predicted test score"
# Find where the log is. Logged side = PERCENT. Unlogged side = UNITS/points.
#   y ~ log(x)       (level-log): 1% rise in x  -> y changes b1/100 UNITS
#   log(y) ~ x       (log-level): 1 unit rise in x -> y changes 100*b1 PERCENT
#   log(y) ~ log(x)  (log-log)  : 1% rise in x  -> y changes b1 PERCENT
# ---------------------------------------------------------------------
p1_b1 <- 8                                             # <-- CHANGE: the slope
pick("#1 IF y ~ log(x)", sprintf("1%% rise in x -> about %s points/units", p1_b1 / 100))
pick("#1 IF log(y) ~ x", sprintf("1 unit rise in x -> about %s%%", 100 * p1_b1))
pick("#1 IF log(y) ~ log(x)", sprintf("1%% rise in x -> about %s%%", p1_b1))

# ---------------------------------------------------------------------
# #2  "log(y) = 2.5 + 0.01x. By about what percent does y change when x
#      FALLS by 1?"                                        PS10 answer: -1.00
# Formula: %dy = 100 * b1 * dx
# ---------------------------------------------------------------------
p2_b1 <- 0.01                                          # <-- CHANGE: slope on x
p2_dx <- -1                                            # <-- CHANGE: change in x (falls = NEGATIVE)
ans("#2 % change in y", 100 * p2_b1 * p2_dx)

# ---------------------------------------------------------------------
# #3  "bwght: lm(log(bwght) ~ log(faminc)). By about what percent does
#      birth weight change when family income rises by 20%?" PS10 answer: 0.41
# Formula: %dy = b1 * %dx  (log-log, no 100)
# ---------------------------------------------------------------------
p3_pctx <- 20                                          # <-- CHANGE: % change in income (falls = NEGATIVE)
p3_fit  <- lm(log(bwght) ~ log(faminc), data = bwght)
info("#3 slope (elasticity)", signif(coef(p3_fit)[2], 6))
ans("#3 % change in birth weight", coef(p3_fit)[2] * p3_pctx)

# ---------------------------------------------------------------------
# #4  MULTIPLE CHOICE: "1,000 samples, OLS is unbiased. Which is correct?"
# ---------------------------------------------------------------------
pick("#4", "The AVERAGE of the estimates is close to b1")
info("#4 wrong choices", "every estimate = b1 / no spread (Var=0) / all positive")

# ---------------------------------------------------------------------
# #6  SELECT ALL: "Var(b1) = sigma^2/SST_X. Which make Var(b1) LARGER?"
#     READ CAREFULLY: does it say LARGER or SMALLER?
# ---------------------------------------------------------------------
pick("#6 if it asks LARGER", "larger sigma^2 + SMALLER sample + X bunched together")
pick("#6 if it asks SMALLER", "smaller sigma^2 + LARGER sample + X more spread out")
info("#6 NEVER pick", "a larger (or smaller) true slope b1 -- not in the formula")

# ---------------------------------------------------------------------
# #7  "n = 11, sigma hat = 8.6, sample SD of X is S_X = 1.7. Find se(b1)."
#                                                          PS10 answer: 1.60
# Formula: SST_X = (n-1)*S_X^2, then se = sigma hat / sqrt(SST_X)
# If the question gives the VARIANCE of X (S_X^2) instead of the SD,
# set p7_given_var <- TRUE.
# If it gives sigma^2 hat instead of sigma hat, type sqrt(that number).
# ---------------------------------------------------------------------
p7_n         <- 11                                     # <-- CHANGE: n
p7_sigma     <- 8.6                                    # <-- CHANGE: sigma hat
p7_SX        <- 1.7                                    # <-- CHANGE: S_X (the SD of X)
p7_given_var <- FALSE                                  # <-- CHANGE: TRUE if they gave S_X^2
p7_SSTx <- (p7_n - 1) * if (p7_given_var) p7_SX else p7_SX^2
info("#7 SST_X", round(p7_SSTx, 4))
ans("#7 se(b1 hat)", p7_sigma / sqrt(p7_SSTx))

# ---------------------------------------------------------------------
# #9  "sd(b1) = 0.32. If the sample were 2 times as large (SST_X also
#      2 times as large), what would sd(b1) be?"           PS10 answer: 0.23
# Formula: new sd = old sd / sqrt(k)   (half as large -> k = 0.5)
# ---------------------------------------------------------------------
p9_sd <- 0.32                                          # <-- CHANGE: original sd(b1)
p9_k  <- 2                                             # <-- CHANGE: "k times as large"
ans("#9 new sd(b1 hat)", p9_sd / sqrt(p9_k))

# ---------------------------------------------------------------------
# #12 "yhat = 10 + 2.4 x1 + 1.7 x2. Find yhat at x1 = 2, x2 = 10."
#                                                          PS10 answer: 31.80
# PREDICTED VALUE -> KEEP the intercept.
# ---------------------------------------------------------------------
p12_b0 <- 10                                           # <-- CHANGE: intercept
p12_b1 <- 2.4                                          # <-- CHANGE: x1 coefficient (keep minus sign)
p12_b2 <- 1.7                                          # <-- CHANGE: x2 coefficient (keep minus sign)
p12_x1 <- 2                                            # <-- CHANGE: x1 value
p12_x2 <- 10                                           # <-- CHANGE: x2 value
ans("#12 predicted yhat", p12_b0 + p12_b1 * p12_x1 + p12_b2 * p12_x2)

# ---------------------------------------------------------------------
# #13 "yhat = 2 + 3.8 x1 - 0.7 x2. If x1 rises by 1 and x2 rises by 4,
#      by how much does yhat change?"                      PS10 answer: 1.00
# CHANGE -> intercept DROPS OUT. dy = b1*dx1 + b2*dx2
# ---------------------------------------------------------------------
p13_b1  <- 3.8                                         # <-- CHANGE: x1 coefficient
p13_b2  <- -0.7                                        # <-- CHANGE: x2 coefficient (keep minus sign!)
p13_dx1 <- 1                                           # <-- CHANGE: change in x1 (falls = NEGATIVE)
p13_dx2 <- 4                                           # <-- CHANGE: change in x2 (falls = NEGATIVE)
ans("#13 change in yhat", p13_b1 * p13_dx1 + p13_b2 * p13_dx2)

# ---------------------------------------------------------------------
# #14 "wage1: lm(wage ~ educ + exper + tenure). Predicted hourly wage of
#      a worker with 14 educ, 10 exper, 5 tenure?"         PS10 answer: 6.58
# ---------------------------------------------------------------------
p14_educ   <- 14                                       # <-- CHANGE
p14_exper  <- 10                                       # <-- CHANGE
p14_tenure <- 5                                        # <-- CHANGE
p14_fit <- lm(wage ~ educ + exper + tenure, data = wage1)
b <- coef(p14_fit)
info("#14 coefficients", paste(names(b), round(b, 4), collapse = "  "))
ans("#14 predicted wage ($/hr)", b[1] + b[2] * p14_educ + b[3] * p14_exper + b[4] * p14_tenure)

# ---------------------------------------------------------------------
# #15 "Same wage1 regression. By how much does predicted wage change when
#      tenure rises by 3, holding educ and exper fixed?"   PS10 answer: 0.51
# "Holding X fixed" -> that change is 0.
# ---------------------------------------------------------------------
p15_dtenure <- 3                                       # <-- CHANGE: change in tenure
p15_deduc   <- 0                                       # <-- CHANGE: change in educ (0 if held fixed)
p15_dexper  <- 0                                       # <-- CHANGE: change in exper (0 if held fixed)
ans("#15 change in wage ($/hr)", b[2] * p15_deduc + b[3] * p15_dexper + b[4] * p15_dtenure)

cat("\n######## OTHER PS10 PROBLEMS (not on Quiz 9) ########\n")
pick("#5", "smaller Var -> estimates land closer to b1, more reliable")
# #8: se(b1) from raw x and SSR; sigma hat = sqrt(SSR/(n-2))     PS10 answer: 0.84
p8_x <- c(2, 3, 4, 5, 9); p8_SSR <- 62
p8_sig <- sqrt(p8_SSR / (length(p8_x) - 2))
ans("#8 se(b1 hat)", p8_sig / sqrt(sum((p8_x - mean(p8_x))^2)))
# #10: ceosal1, se of roe slope by hand                          PS10 answer: 11.12
p10_fit <- lm(salary ~ roe, data = ceosal1)
p10_sig <- sqrt(sum(resid(p10_fit)^2) / (nrow(ceosal1) - 2))
ans("#10 se(b1 hat) by hand", p10_sig / sqrt(sum((ceosal1$roe - mean(ceosal1$roe))^2)))
pick("#11", "change in wage from +1 educ, HOLDING exper FIXED")
# #16, #17: ceosal1 log(salary) ~ log(sales) + roe              PS10: 17.87, 1067.66
p16_fit <- lm(log(salary) ~ log(sales) + roe, data = ceosal1)
c16 <- coef(p16_fit)
ans("#16 % change salary, roe +10", 100 * c16["roe"] * 10)
ans("#17 predicted salary ($000s)", exp(c16[1] + c16[2] * log(5000) + c16[3] * 15))
ans("#18 b1 tilde = b1 + b2*delta1", 0.25 + 1.44 * 0.11)       # PS10: 0.41
ans("#19 bias = b2*delta1", -1.17 * -0.26)                    # PS10: 0.30
pick("#20", "b2 < 0 and corr > 0 -> biased DOWNWARD")
# #21: wage1, b2_hat * delta1                                   PS10 answer: -0.10
p21_m <- lm(wage ~ educ + exper, data = wage1)
p21_d <- lm(exper ~ educ, data = wage1)
ans("#21 b2hat * delta1", coef(p21_m)["exper"] * coef(p21_d)["educ"])
