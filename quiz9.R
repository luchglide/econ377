# ECN 377 - Quiz 9 / PS10 R script. Round answers to hundredths.
# Quiz 9 (Wed 10/28) = PS10 problems #1, #2, #3, #4, #6, #7, #9, #12, #13, #14, #15
# with NEW numbers. Numbering below is the PS10 PROBLEM number (Canvas shows an
# intro block first, so Canvas "question 2" = problem #1).
# HOW TO USE: change the numbers under each block, then re-run the whole file
# (Ctrl+Shift+Enter / Cmd+Shift+Enter in RStudio). Each block prints its answer.
# Pull the repo BEFORE the quiz (closed internet). Open it as an RStudio project so
# the working directory is the repo root and data/ is found.
# Data: uses the wooldridge package if installed, otherwise the CSV copies in data/.
if (requireNamespace("wooldridge", quietly = TRUE)) {
  data("ceosal1", package = "wooldridge"); data("wage1", package = "wooldridge")
  data("bwght", package = "wooldridge")
} else {
  ceosal1 <- read.csv("data/ceosal1.csv")
  wage1   <- read.csv("data/wage1.csv")
  bwght   <- read.csv("data/bwght.csv")
}
show <- function(label, x) cat(sprintf("%-36s %s\n", label, format(round(unname(x), 2), nsmall = 2)))
say  <- function(label, x) cat(sprintf("%-36s %s\n", label, x))

cat("\n########## QUIZ 9 ITEMS ##########\n")

# --- #1 (conceptual): level-log, yhat = b0 + b1*log(x) --------------------------
# A 1% rise in x -> yhat rises by about b1/100 UNITS (points), not percent.
# PS10: test = 12 + 8*log(income) -> "1% rise in income ... about 0.08 points".
p1_b1 <- 8
say("#1", sprintf("1%% rise in x -> about %s points in yhat (b1/100)", round(p1_b1 / 100, 4)))

# --- #2: log-level, %dy = 100 * b1 * dx ----------------------------------------
p2_b1 <- 0.01         # slope on x
p2_dx <- -1           # change in x ("falls" -> NEGATIVE)
show("#2 % change in y", 100 * p2_b1 * p2_dx)

# --- #3: bwght log-log, %dy = b1 * %dx ------------------------------------------
p3_pctx <- 20         # % change in faminc (fall -> negative)
p3_fit  <- lm(log(bwght) ~ log(faminc), data = bwght)
say("#3 slope (elasticity)", signif(coef(p3_fit)[2], 6))
show("#3 % change in birth weight", coef(p3_fit)[2] * p3_pctx)

# --- #4 (conceptual): unbiased ---------------------------------------------------
say("#4", "the AVERAGE of the many estimates is close to b1")
# Not: every estimate equals b1 / Var = 0 / all positive.

# --- #6 (conceptual, SELECT ALL): Var(b1) = sigma^2 / SSTx ----------------------
# Question asks LARGER Var -> pick: larger sigma^2, SMALLER sample, X bunched tightly.
# NOT a larger true slope b1 (irrelevant). NOT a larger sample.
# (If it asks SMALLER Var: smaller sigma^2, larger sample, X more spread out.)
say("#6 LARGER Var(b1)", "larger sigma^2; smaller sample; X bunched (small SSTx)")

# --- #7: se(b1) from sigma hat and S_X. SSTx = (n-1)*S_X^2 -----------------------
p7_n     <- 11
p7_sigma <- 8.6       # sigma hat
p7_SX    <- 1.7       # sample SD of X (it gets SQUARED). If given S_X^2, use sqrt of it here.
p7_SSTx  <- (p7_n - 1) * p7_SX^2
show("#7 SSTx", p7_SSTx)
show("#7 se(b1hat)", p7_sigma / sqrt(p7_SSTx))

# --- #9: SST_X scaled by k -> sd divided by sqrt(k) ------------------------------
p9_sd <- 0.32         # original sd(b1hat)
p9_k  <- 2            # sample k times as large
show("#9 new sd(b1hat)", p9_sd / sqrt(p9_k))

# --- #12: MLR prediction yhat = b0 + b1*x1 + b2*x2 -------------------------------
p12_b0 <- 10; p12_b1 <- 2.4; p12_b2 <- 1.7      # coefficients (keep minus signs)
p12_x1 <- 2;  p12_x2 <- 10
show("#12 yhat", p12_b0 + p12_b1 * p12_x1 + p12_b2 * p12_x2)

# --- #13: MLR change, intercept cancels ------------------------------------------
p13_b1 <- 3.8; p13_b2 <- -0.7                   # slopes (keep minus signs!)
p13_dx1 <- 1;  p13_dx2 <- 4                     # changes ("falls" -> negative)
show("#13 change in yhat", p13_b1 * p13_dx1 + p13_b2 * p13_dx2)

# --- #14: wage1, lm(wage ~ educ + exper + tenure), predicted wage ----------------
p14_educ <- 14; p14_exper <- 10; p14_tenure <- 5
p14_fit <- lm(wage ~ educ + exper + tenure, data = wage1)
b <- coef(p14_fit)
print(round(b, 4))
show("#14 predicted wage", b[1] + b[2] * p14_educ + b[3] * p14_exper + b[4] * p14_tenure)

# --- #15: same wage1 regression, CHANGE in wage = slope * change (intercept drops) ---
p15_dtenure <- 3; p15_deduc <- 0; p15_dexper <- 0
show("#15 change in wage", b[2] * p15_deduc + b[3] * p15_dexper + b[4] * p15_dtenure)

cat("\n########## OTHER PS10 PROBLEMS ##########\n")
say("#5", "smaller Var -> estimates land closer to b1, more reliable")
# #8: se(b1) from raw x and SSR; sigma hat = sqrt(SSR/(n-2))
p8_x <- c(2, 3, 4, 5, 9); p8_SSR <- 62
p8_sig <- sqrt(p8_SSR / (length(p8_x) - 2))
show("#8 SSTx", sum((p8_x - mean(p8_x))^2))
show("#8 se(b1hat)", p8_sig / sqrt(sum((p8_x - mean(p8_x))^2)))
# #10: ceosal1, se of roe slope by hand
p10_fit <- lm(salary ~ roe, data = ceosal1)
p10_sig <- sqrt(sum(resid(p10_fit)^2) / (nrow(ceosal1) - 2))
show("#10 se(b1hat) by hand", p10_sig / sqrt(sum((ceosal1$roe - mean(ceosal1$roe))^2)))
show("#10 check summary()", coef(summary(p10_fit))["roe", "Std. Error"])
say("#11", "change in wage from +1 educ, HOLDING exper FIXED")
# #16, #17: ceosal1 log(salary) ~ log(sales) + roe
p16_fit <- lm(log(salary) ~ log(sales) + roe, data = ceosal1)
c16 <- coef(p16_fit)
show("#16 % change salary, roe +10", 100 * c16["roe"] * 10)
show("#17 predicted salary ($000s)", exp(c16[1] + c16[2] * log(5000) + c16[3] * 15))
# #18: b1_tilde = b1_hat + b2_hat * delta1
show("#18 b1 tilde", 0.25 + 1.44 * 0.11)
# #19: bias = beta2 * delta1
show("#19 bias", -1.17 * -0.26)
say("#20", "b2 < 0 and corr > 0 -> biased DOWNWARD")
# #21: wage1, b2_hat * delta1 = simple educ slope - multiple educ slope
p21_m <- lm(wage ~ educ + exper, data = wage1)
p21_d <- lm(exper ~ educ, data = wage1)
show("#21 b2hat * delta1", coef(p21_m)["exper"] * coef(p21_d)["educ"])
show("#21 check", coef(lm(wage ~ educ, data = wage1))["educ"] - coef(p21_m)["educ"])
