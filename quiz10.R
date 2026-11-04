# =====================================================================
# ECN 377 - QUIZ 10 SCRIPT (PS11). Round every answer to the hundredths.
# =====================================================================
# BEFORE THE QUIZ (internet is off once it starts):
#   1. Pull this repo, open it as an RStudio project (so data/ is found).
#   2. Press Ctrl+Shift+Enter (Mac: Cmd+Shift+Enter) once. Every block
#      should print the "PS11 answer" in its comment.
# DURING THE QUIZ:
#   1. Match the quiz question to a block by its wording.
#   2. Change ONLY the lines marked  # <-- CHANGE.
#   3. Re-run (Ctrl/Cmd+Shift+Enter) and read that block's ">>> ANSWER".
# Quiz 10 = PS11 problems #1 2 3 4 6 7 9 11 14 16 17 (new numbers).
# SIGN RULE: "falls/decreases" -> NEGATIVE change. Keep minus signs on slopes.
# =====================================================================
if (requireNamespace("wooldridge", quietly = TRUE)) {
  data("wage1", package = "wooldridge"); data("bwght", package = "wooldridge")
} else {
  wage1 <- read.csv("data/wage1.csv"); bwght <- read.csv("data/bwght.csv")
}
ans  <- function(label, x) cat(sprintf(">>> ANSWER %-36s %s\n", label, format(round(unname(x), 2), nsmall = 2)))
pick <- function(label, x) cat(sprintf(">>> PICK   %-36s %s\n", label, x))

cat("\n################ QUIZ 10 ITEMS ################\n")

# ---------------------------------------------------------------------
# #1  "log(y)-hat = 2.4 + 0.015 x1 - 0.037 x2. x1 rises by 3, x2 rises by 4.
#      About what percent does predicted y change?"          PS11 answer: -10.30
# Log-level MLR: %dy = 100 * (b1*dx1 + b2*dx2). Intercept drops out.
# ---------------------------------------------------------------------
p1_b   <- c(0.015, -0.037)       # <-- CHANGE slopes (keep minus signs!)
p1_dx  <- c(3, 4)                # <-- CHANGE changes (falls = NEGATIVE)
ans("#1 % change in y", 100 * sum(p1_b * p1_dx))

# ---------------------------------------------------------------------
# #2  "wage1: lm(log(wage) ~ educ + exper + tenure). % change in wage when
#      exper rises by 2 and tenure by 1, educ fixed?"         PS11 answer: 3.03
# #3  "...predicted hourly WAGE in dollars at educ 12, exper 10, tenure 3?"
#                                                             PS11 answer: 4.46
# ---------------------------------------------------------------------
reg <- lm(log(wage) ~ educ + exper + tenure, data = wage1)
b <- reg$coefficients            # b[1] intercept, b[2] educ, b[3] exper, b[4] tenure
p2_d <- c(educ = 0, exper = 2, tenure = 1)          # <-- CHANGE changes (fixed = 0)
ans("#2 % change in wage", 100 * (b[2] * p2_d["educ"] + b[3] * p2_d["exper"] + b[4] * p2_d["tenure"]))
p3_x <- c(educ = 12, exper = 10, tenure = 3)        # <-- CHANGE values
p3_log <- b[1] + b[2] * p3_x["educ"] + b[3] * p3_x["exper"] + b[4] * p3_x["tenure"]
ans("#3 predicted log(wage) (NOT the answer)", p3_log)
ans("#3 predicted WAGE in $ = exp(...)", exp(p3_log))

# ---------------------------------------------------------------------
# #4  SELECT ALL: which are always true after OLS (with an intercept)?
# ---------------------------------------------------------------------
pick("#4 TRUE", "passes through the means: ybar = b0 + b1*x1bar + ... + bK*xKbar")
pick("#4 TRUE", "average of the residuals is 0")
pick("#4 TRUE", "sample covariance between EACH Xj and the residuals is 0")
pick("#4 FALSE", "every residual is 0 for a big sample  /  cov(Y, residuals) = 0")

# ---------------------------------------------------------------------
# #6  "yhat = 3.6 + 0.8 x1 - 1.2 x2, x1bar = 4.6, x2bar = 2.9. ybar?"
#                                                             PS11 answer: 3.80
# The OLS line passes through the means. KEEP the intercept.
# ---------------------------------------------------------------------
p6_b0 <- 3.6                     # <-- CHANGE intercept
p6_b  <- c(0.8, -1.2)            # <-- CHANGE slopes (keep minus signs)
p6_xbar <- c(4.6, 2.9)           # <-- CHANGE means of the x's
ans("#6 ybar", p6_b0 + sum(p6_b * p6_xbar))

# ---------------------------------------------------------------------
# #7  SELECT ALL: which violate MLR.3 (no PERFECT collinearity)?
# ---------------------------------------------------------------------
pick("#7 VIOLATES", "more x's than observations (5 x's, 4 obs: need n >= k + 1)")
pick("#7 VIOLATES", "x3 = x1 + x2 exactly (totexpend = expendA + expendB)")
pick("#7 VIOLATES", "same variable in two units (income in $ AND in $000s)")
pick("#7 FINE", "x's highly but NOT perfectly correlated (ACT & hsGPA)")
pick("#7 FINE", "x's that vary and aren't exact functions of each other")

# ---------------------------------------------------------------------
# #9  Which makes MLR.4 (E[U|X] = 0) fail / X endogenous?
# ---------------------------------------------------------------------
pick("#9", "a variable that affects Y and is correlated with X1 is LEFT OUT")
pick("#9 (also fails)", "wrong functional form (levels vs logs)")
pick("#9 NOT", "high correlation / small n / units of Y")

# ---------------------------------------------------------------------
# #11 (3.23): b1tilde = b1hat + b2hat * delta1. Put NA on the one they ask for.
#     PS11: b1tilde = -0.36, b2hat = -1.18, delta1 = -0.51 -> b1hat = -0.96
# ---------------------------------------------------------------------
p11_b1tilde <- -0.36             # <-- CHANGE simple-regression slope (NA if asked)
p11_b1hat   <- NA                # <-- CHANGE multiple-regression slope (NA if asked)
p11_b2hat   <- -1.18             # <-- CHANGE (NA if asked)
p11_delta1  <- -0.51             # <-- CHANGE (NA if asked)
if (is.na(p11_b1hat))   ans("#11 b1hat = b1tilde - b2hat*delta1", p11_b1tilde - p11_b2hat * p11_delta1)
if (is.na(p11_b1tilde)) ans("#11 b1tilde = b1hat + b2hat*delta1", p11_b1hat + p11_b2hat * p11_delta1)
if (is.na(p11_b2hat))   ans("#11 b2hat", (p11_b1tilde - p11_b1hat) / p11_delta1)
if (is.na(p11_delta1))  ans("#11 delta1", (p11_b1tilde - p11_b1hat) / p11_b2hat)

# ---------------------------------------------------------------------
# #14 "bwght: delta1 from lm(faminc ~ cigs). Compute b2hat * delta1, b2hat =
#      faminc coef in lm(bwght ~ cigs + faminc)."             PS11 answer: -0.05
# ---------------------------------------------------------------------
p14_simple <- lm(bwght ~ cigs, data = bwght)              # <-- CHANGE y ~ x1
p14_multi  <- lm(bwght ~ cigs + faminc, data = bwght)     # <-- CHANGE y ~ x1 + x2
p14_aux    <- lm(faminc ~ cigs, data = bwght)             # <-- CHANGE x2 ~ x1
p14_b2 <- p14_multi$coefficients[3]; p14_d1 <- p14_aux$coefficients[2]
ans("#14 b2hat (x2 coef in multiple)", p14_b2)
ans("#14 delta1 (slope of x2 on x1)", p14_d1)
ans("#14 b2hat * delta1", p14_b2 * p14_d1)
ans("#14 check: simple - multiple x1 slope", p14_simple$coefficients[2] - p14_multi$coefficients[2])

# ---------------------------------------------------------------------
# #16 #17  Direction of bias (Table 3.2): sign(beta2) x sign(corr(x1, x2))
#   #16: beta2 < 0, corr < 0  -> (-)(-) = + -> biased UPWARD
#   #17: land quality raises yield (+), more fertilizer on better land (+)
#        -> (+)(+) = + -> OVERSTATES (upward)
# ---------------------------------------------------------------------
p16_sign_b2   <- -1              # <-- CHANGE +1 if omitted x2 RAISES y, -1 if it lowers y
p16_sign_corr <- -1              # <-- CHANGE +1 if x2 moves WITH x1, -1 if opposite
pick("#16/#17 bias", ifelse(p16_sign_b2 * p16_sign_corr > 0, "UPWARD (overstates)", "DOWNWARD (understates)"))
pick("#16/#17 no bias if", "beta2 = 0 OR x1, x2 uncorrelated")
