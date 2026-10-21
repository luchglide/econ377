# ECN 377 - Quiz 8 / PS9 R script (Wooldridge Ch. 2). Round answers to hundredths.
# HOW TO USE: change the numbers under "INPUTS" in a block, then re-run the whole
# file (Ctrl+Shift+Enter / Cmd+Shift+Enter in RStudio). Each block prints its answer.
# Pull the repo BEFORE the quiz (closed internet). Open it as an RStudio project so
# the working directory is the repo root and data/ is found.
# Data: uses the wooldridge package if installed, otherwise the CSV copies in data/,
# so it runs offline on the classroom desktops either way.
if (requireNamespace("wooldridge", quietly = TRUE)) {
  data("ceosal1", package = "wooldridge"); data("wage1", package = "wooldridge")
} else {
  ceosal1 <- read.csv("data/ceosal1.csv")
  wage1   <- read.csv("data/wage1.csv")
}
show <- function(label, x) cat(sprintf("%-34s %s\n", label, format(round(unname(x), 2), nsmall = 2)))
say  <- function(label, x) cat(sprintf("%-34s %s\n", label, x))

cat("\n########## QUIZ 8 ITEMS ##########\n")

# --- PS8 #14: x divided by k -> new slope = b1 * k -----------------------------
ps8_14_b1 <- 0.58     # original slope
ps8_14_k  <- 1000     # x is DIVIDED by this (if x is MULTIPLIED by c, use k = 1/c)
show("PS8 #14 new slope", ps8_14_b1 * ps8_14_k)

# --- PS8 #17: log-level, %dy = 100 * b1 * dx ---------------------------------
ps8_17_b1 <- 0.02     # slope on x
ps8_17_dx <- 2        # change in x (in x's units)
show("PS8 #17 % change in y", 100 * ps8_17_b1 * ps8_17_dx)

# --- PS8 #19: level-log, dy = (b1/100) * %dx ---------------------------------
ps8_19_b1   <- 11.3   # slope on log(x)
ps8_19_pctx <- 13     # % change in x (negative if x falls)
show("PS8 #19 change in y (units)", (ps8_19_b1 / 100) * ps8_19_pctx)

# --- PS9 Q1 (conceptual): log(c*y) = log(c) + log(y) ---------------------------
# Log-log or log-level, y rescaled -> slope unchanged, only intercept shifts by log(c).
# (If X were rescaled in a log-log model, slope is also unchanged; intercept shifts.)
say("Q1", "(c) b1 does not change; only b0 changes")

# --- PS9 Q5: log-log, %dy = b1 * %dx -----------------------------------------
q5_b1   <- 0.94       # elasticity (slope)
q5_pctx <- -8         # % change in x (FALL -> negative)
show("Q5 % change in y", q5_b1 * q5_pctx)

# --- PS9 Q6: ceosal1, lm(log(salary) ~ roe), %dy = 100 * b1 * droe ----------
q6_droe <- 5          # change in roe (points)
q6_fit  <- lm(log(salary) ~ roe, data = ceosal1)
say("Q6 slope (unrounded used)", signif(coef(q6_fit)["roe"], 6))
show("Q6 % change in salary", 100 * coef(q6_fit)["roe"] * q6_droe)

# --- PS9 Q9 (conceptual): omitted-variable bias ------------------------------
# Needs a variable that (1) affects y AND (2) is correlated with x. Random/ID/day = no.
say("Q9", "(a) ability")

# --- PS9 Q13 (conceptual): Var(b1) = sigma^2 / SSTx --------------------------
# Smaller Var: larger SSTx (more spread in x), larger n, smaller sigma^2. b0 irrelevant.
say("Q13", "(a) larger SSTx / more spread-out X")

# --- PS9 Q14: sd(b1) = sigma / sqrt(SSTx), SSTx from raw x --------------------
q14_sigma <- 6
q14_x     <- c(3, 4, 7, 8, 9)
q14_SSTx  <- sum((q14_x - mean(q14_x))^2)
show("Q14 SSTx", q14_SSTx)
show("Q14 sd(b1hat)", q14_sigma / sqrt(q14_SSTx))

# --- PS9 Q15: sigma2hat = SSR / (n - 2) --------------------------------------
q15_SSR <- 268
q15_n   <- 14
show("Q15 sigma^2 hat", q15_SSR / (q15_n - 2))

# --- PS9 Q16: se(b1) = sqrt(SSR/(n-2)) / sqrt(SSTx) --------------------------
q16_SSR  <- 437
q16_n    <- 13
q16_SSTx <- 12
q16_sig  <- sqrt(q16_SSR / (q16_n - 2))
show("Q16 sigma hat", q16_sig)
show("Q16 se(b1hat)", q16_sig / sqrt(q16_SSTx))

cat("\n########## OTHER PS9 QUESTIONS ##########\n")
# Q2: log-level, x in months, one year = 12 months
q2_b1 <- 0.0062; q2_dx <- 12
show("Q2 % change in wage per year", 100 * q2_b1 * q2_dx)
# Q3: y multiplied by c in a log(y) model -> new b0 = b0 + log(c)
q3_b0 <- 3.36; q3_c <- 1000
show("Q3 new intercept", q3_b0 + log(q3_c))
say("Q4", "(a) log-level")
# Q7: ceosal1, lm(salary ~ log(sales)), dy = (b1/100) * %dx
q7_pctx <- 10
q7_fit  <- lm(salary ~ log(sales), data = ceosal1)
show("Q7 slope", coef(q7_fit)[2])
show("Q7 change in salary ($000s)", (coef(q7_fit)[2] / 100) * q7_pctx)
say("Q8", "(d) averaged over many samples, b1hat = b1")
say("Q10", "(d) SLR3 fails: no variation in x")
# Q11: Var(b1) = sigma^2 / SSTx
q11_sigma2 <- 66; q11_SSTx <- 53
show("Q11 Var(b1hat)", q11_sigma2 / q11_SSTx)
# Q12: SSTx = (n-1)*S2x, sd = sigma / sqrt(SSTx)
q12_sigma <- 20; q12_n <- 6; q12_S2x <- 2
show("Q12 sd(b1hat)", q12_sigma / sqrt((q12_n - 1) * q12_S2x))
say("Q17", "(a) SLR5 fails (heteroskedasticity); still unbiased")
# Q18: sigma hat from lm(wage ~ educ, wage1)
q18_fit <- lm(wage ~ educ, data = wage1)
show("Q18 sigma hat", sqrt(sum(resid(q18_fit)^2) / (nrow(wage1) - 2)))
show("Q18 check summary()$sigma", summary(q18_fit)$sigma)
# Q19: SSTx for educ
show("Q19 SSTx(educ)", sum((wage1$educ - mean(wage1$educ))^2))
