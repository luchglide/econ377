# ECN 377 - Quiz 9 plug-and-play script (Wooldridge Ch. 2 wrap-up + Ch. 3 multiple regression).
# Round answers to hundredths.
# NOTE: built from the course pattern (PS9 = Ch. 2.4-2.5), NOT from the actual Canvas
# questions. Each block is a question TYPE. Find the type, swap the INPUTS, run the block.
# HOW TO USE: highlight a block + Ctrl/Cmd+Enter, or run the whole file
# (Ctrl/Cmd+Shift+Enter). Every block prints a labelled answer.
# Pull the repo BEFORE the quiz (closed internet). Open it as an RStudio project so
# the working directory is the repo root and data/ is found.
# Data: uses the wooldridge package if installed, otherwise the CSV copies in data/.
if (requireNamespace("wooldridge", quietly = TRUE)) {
  data("ceosal1", package = "wooldridge"); data("wage1", package = "wooldridge")
} else {
  ceosal1 <- read.csv("data/ceosal1.csv")
  wage1   <- read.csv("data/wage1.csv")
}
show <- function(label, x) cat(sprintf("%-38s %s\n", label, format(round(unname(x), 2), nsmall = 2)))
say  <- function(label, x) cat(sprintf("%-38s %s\n", label, x))

cat("\n########## A. READING AN MLR EQUATION ##########\n")

# --- A1: change in yhat, intercept cancels: dy = b1*dx1 + b2*dx2 + ... ----------
# "Holding x2 fixed" -> that dx is 0. "Falls" -> negative.
a1_b  <- c(0.092, 0.0041, 0.022)   # slopes (b1, b2, b3), any length
a1_dx <- c(4, 0, 0)                # changes in each x, same order
show("A1 change in yhat", sum(a1_b * a1_dx))

# --- A2: predicted value and residual --------------------------------------------
a2_b0 <- -2.87                     # intercept
a2_b  <- c(0.599, 0.022, 0.169)    # slopes
a2_x  <- c(12, 10, 3)              # this person's x values, same order
a2_y  <- 5.50                      # ACTUAL y (for the residual); NA if not asked
a2_yhat <- a2_b0 + sum(a2_b * a2_x)
show("A2 yhat (prediction)", a2_yhat)
show("A2 residual = y - yhat", a2_y - a2_yhat)

# --- A3: log(y) on the left -> % change in y ---------------------------------------
# Approx %dy = 100*sum(b*dx). Exact %dy = 100*(exp(sum(b*dx)) - 1).
a3_b  <- c(0.092, 0.0041)
a3_dx <- c(1, 0)
show("A3 approx % change in y", 100 * sum(a3_b * a3_dx))
show("A3 exact % change in y", 100 * (exp(sum(a3_b * a3_dx)) - 1))

# --- A4: log(x) on the right (level-log): dy = (b/100) * %dx -----------------------
#         log-log: %dy = b * %dx (elasticity)
a4_b    <- 0.257
a4_pctx <- 10
show("A4 level-log  dy", (a4_b / 100) * a4_pctx)
show("A4 log-log   %dy", a4_b * a4_pctx)

# --- A5: quadratic, y = b0 + b1*x + b2*x^2 ---------------------------------------
# Marginal effect at x = b1 + 2*b2*x. Turning point x* = |b1 / (2*b2)|.
a5_b1 <- 0.298; a5_b2 <- -0.0061; a5_x <- 10
show("A5 marginal effect at x", a5_b1 + 2 * a5_b2 * a5_x)
show("A5 turning point x*", abs(a5_b1 / (2 * a5_b2)))

# --- A6: dummy variable --------------------------------------------------------------
# Coefficient on a 0/1 dummy = difference in predicted y between the groups,
# holding the other x's fixed. In log(y): % gap ~ 100*b, exact 100*(exp(b)-1).
a6_b <- -1.81
show("A6 level gap (group1 - group0)", a6_b)
show("A6 log-y exact % gap", 100 * (exp(a6_b) - 1))

cat("\n########## B. RUN IT ON DATA ##########\n")

# --- B1: wage1 MLR. Change the formula / row / x values --------------------------
b1_fit <- lm(wage ~ educ + exper + tenure, data = wage1)   # SET formula
b1_row <- 6                                                 # SET row for residual
b1_new <- data.frame(educ = 12, exper = 10, tenure = 3)     # SET x values to predict
print(round(coef(b1_fit), 4))
show("B1 coef on educ", coef(b1_fit)["educ"])
show("B1 predicted y at b1_new", predict(b1_fit, b1_new))
show("B1 residual of row", resid(b1_fit)[b1_row])
show("B1 R^2", summary(b1_fit)$r.squared)
show("B1 R^2 in percent", 100 * summary(b1_fit)$r.squared)
show("B1 adjusted R^2", summary(b1_fit)$adj.r.squared)
show("B1 SSR", sum(resid(b1_fit)^2))
show("B1 sigma hat", summary(b1_fit)$sigma)
show("B1 se(educ)", coef(summary(b1_fit))["educ", "Std. Error"])
say ("B1 df = n - k - 1", df.residual(b1_fit))

# --- B2: ceosal1 MLR (log salary) ------------------------------------------------
b2_fit <- lm(log(salary) ~ log(sales) + roe, data = ceosal1)   # SET formula
print(round(coef(b2_fit), 4))
show("B2 elasticity wrt sales", coef(b2_fit)["log(sales)"])
show("B2 %dsalary per +1 roe (approx)", 100 * coef(b2_fit)["roe"])
show("B2 R^2", summary(b2_fit)$r.squared)

# --- B3: your own numbers (a small table typed into the question) -----------------
b3_y  <- c(4, 8, 5, 9, 11, 13)     # SET
b3_x1 <- c(1, 3, 2, 5, 7, 6)       # SET
b3_x2 <- c(2, 1, 3, 2, 1, 4)       # SET
b3_fit <- lm(b3_y ~ b3_x1 + b3_x2)
print(round(coef(b3_fit), 4))
show("B3 R^2", summary(b3_fit)$r.squared)
show("B3 sigma^2 hat = SSR/(n-k-1)", sum(resid(b3_fit)^2) / df.residual(b3_fit))

cat("\n########## C. PARTIALLING OUT / SIMPLE vs MULTIPLE ##########\n")

# --- C1: partialling out (FWL). b1 in the MLR = slope of y on r1, where r1 are the
#         residuals from regressing x1 on the other x's. Same data as B1.
c1_r1 <- resid(lm(educ ~ exper + tenure, data = wage1))   # SET x1 ~ other x's
show("C1 slope of y on r1", sum(c1_r1 * wage1$wage) / sum(c1_r1^2))
show("C1 check: MLR coef", coef(b1_fit)["educ"])

# --- C2: b1_tilde (simple) = b1_hat (multiple) + b2_hat * delta1 ------------------
# delta1 = slope from regressing x2 on x1. Leave the unknown as NA; it solves for it.
c2_b1tilde <- NA       # simple-regression slope on x1
c2_b1hat   <- 0.54     # multiple-regression slope on x1
c2_b2hat   <- 0.8      # multiple-regression slope on x2
c2_delta1  <- 0.3      # slope of x2 on x1
if (is.na(c2_b1tilde)) show("C2 b1_tilde", c2_b1hat + c2_b2hat * c2_delta1)
if (is.na(c2_b1hat))   show("C2 b1_hat",   c2_b1tilde - c2_b2hat * c2_delta1)
if (is.na(c2_b2hat))   show("C2 b2_hat",   (c2_b1tilde - c2_b1hat) / c2_delta1)
if (is.na(c2_delta1))  show("C2 delta1",   (c2_b1tilde - c2_b1hat) / c2_b2hat)
# Simple = multiple exactly when b2_hat = 0 OR x1, x2 uncorrelated in the sample (delta1 = 0).

cat("\n########## D. OMITTED VARIABLE BIAS ##########\n")

# --- D1: sign of the bias in b1_tilde when x2 is left out --------------------------
# Bias = b2 * delta1. Sign = sign(effect of x2 on y) * sign(corr(x1, x2)).
#                 corr(x1,x2) > 0   corr(x1,x2) < 0
#   b2 > 0        UPWARD (+)        DOWNWARD (-)
#   b2 < 0        DOWNWARD (-)      UPWARD (+)
# Upward bias = overstates the effect. If true b1 > 0 and bias is +, b1_tilde is too big.
d1_b2_sign   <- +1     # +1 if omitted x2 RAISES y, -1 if it lowers y
d1_corr_sign <- +1     # +1 if x2 moves WITH x1, -1 if opposite
say("D1 bias direction", ifelse(d1_b2_sign * d1_corr_sign > 0, "UPWARD (positive bias)", "DOWNWARD (negative bias)"))
# Classic: wage ~ educ, omit ability. Ability raises wage (+), corr with educ (+) -> upward.
# No bias if the omitted variable has b2 = 0 or is uncorrelated with x1.
# Including an IRRELEVANT variable: no bias, but can raise Var(b_j).

cat("\n########## E. VARIANCE / STANDARD ERRORS ##########\n")

# --- E1: sigma^2 hat = SSR / (n - k - 1),  k = number of slopes ---------------------
e1_SSR <- 450; e1_n <- 30; e1_k <- 3
show("E1 sigma^2 hat", e1_SSR / (e1_n - e1_k - 1))
show("E1 sigma hat (SER)", sqrt(e1_SSR / (e1_n - e1_k - 1)))

# --- E2: Var(bj) = sigma^2 / (SSTj * (1 - Rj^2)); VIF = 1/(1 - Rj^2) ---------------
# Rj^2 = R^2 from regressing xj on the OTHER x's. Use sigma^2 hat for se.
e2_sigma2 <- 15       # sigma^2 (or sigma^2 hat). If given sigma, square it.
e2_SSTj   <- 120      # SST of xj = sum((xj - mean)^2) = (n-1)*var(xj)
e2_Rj2    <- 0.6
show("E2 VIF", 1 / (1 - e2_Rj2))
show("E2 Var(bj)", e2_sigma2 / (e2_SSTj * (1 - e2_Rj2)))
show("E2 sd/se(bj)", sqrt(e2_sigma2 / (e2_SSTj * (1 - e2_Rj2))))
# Var(bj) goes DOWN with: smaller sigma^2, bigger SSTj (more spread / bigger n), smaller Rj^2.
# Rj^2 -> 1 is multicollinearity; = 1 is PERFECT collinearity (MLR.3 fails, can't estimate).

# --- E3: SSTj from raw x values, or from sample variance --------------------------
e3_x <- c(3, 4, 7, 8, 9)                 # SET (or use e3_n, e3_S2 below)
show("E3 SSTj from x", sum((e3_x - mean(e3_x))^2))
e3_n <- 6; e3_S2 <- 2
show("E3 SSTj = (n-1)*S^2", (e3_n - 1) * e3_S2)

cat("\n########## F. R^2 ##########\n")

# --- F1: R^2 from sums of squares (SSE = EXPLAINED, SSR = RESIDUAL) ----------------
f1_SST <- 300; f1_SSR <- 180; f1_n <- 30; f1_k <- 2
show("F1 R^2 = 1 - SSR/SST", 1 - f1_SSR / f1_SST)
show("F1 SSE = SST - SSR", f1_SST - f1_SSR)
show("F1 adj R^2", 1 - (f1_SSR / (f1_n - f1_k - 1)) / (f1_SST / (f1_n - 1)))
# Adding a regressor NEVER lowers R^2 (SSR can't go up). Adj R^2 can go down.
# R^2 = squared correlation between y and yhat.

cat("\n########## G. CONCEPTS (no math) ##########\n")
say("MLR.1", "linear in parameters")
say("MLR.2", "random sample")
say("MLR.3", "no PERFECT collinearity (e.g. not x and 2x, not shares summing to 1)")
say("MLR.4", "zero conditional mean E[u|x]=0 -> UNBIASED (1-4)")
say("MLR.5", "homoskedasticity Var(u|x)=sigma^2 -> Var formulas")
say("Gauss-Markov", "MLR.1-5 -> OLS is BLUE (Best Linear Unbiased)")
say("Hetero (MLR.5 fails)", "still unbiased; Var/se formulas invalid")
say("Omit relevant + correlated x", "biased (MLR.4 fails)")
say("Add irrelevant x", "unbiased; Var may rise")
say("High (not perfect) collinearity", "allowed; just bigger Var(bj)")
say("Ceteris paribus", "bj = effect of xj holding the other x's FIXED")
say("Units: x times c", "bj becomes bj / c; level y times c -> all b's times c")
say("Units: log(y), y times c", "only intercept changes, by + log(c)")
