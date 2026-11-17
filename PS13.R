# ECN 377 PS13 / Quiz 11 — plug-and-play. Change INPUTS at the top of each block, re-run that block.
# install.packages("wooldridge")   # once
# Round to the hundredths (keep trailing zeros: 1.70 not 1.7). Keep unrounded coefficients until the last step.
#
# Quiz 11 (Wed 11/18) is drawn from this set with new numbers.
#   Quiz instructions list (7 items): #1, #3, #4, #7, #14, #17, #20
#   Spacer on the PS13 page also lists: #6, #8, #9, #16
# Those items are first. Then the remaining PS13 questions. Walkthrough is at the end.

library(wooldridge)
r2  <- function(x) round(x, 2)
fmt <- function(x) format(round(x, 2), nsmall = 2, trim = TRUE)

######## QUIZ 11 ITEMS FIRST (instructions: #1, #3, #4, #7, #14, #17, #20) ########

## ---- Q1: why (bhat - beta) / se has a t distribution (not N(0,1)) ----
# se uses sigma-hat, which changes from sample to sample; sd uses the unknown sigma.
cat("Q1:", "The standard error replaces the unknown σ with the estimate σ-hat, which varies from sample to sample.", "\n")

## ---- Q3: df for t-statistic ----
n <- 99   # SET
K <- 5    # SET  number of independent variables (slopes)
df <- n - K - 1
cat("Q3 df =", df, "\n")                 # 93

## ---- Q4: t-statistic for H0: beta_j = 0 ----
bhat <- -2.31   # SET
se   <- 1.09    # SET
tstat <- bhat / se
cat("Q4 t =", fmt(tstat), "\n")          # -2.12

## ---- Q7: H1: beta > 0, compare t to c ----
c_crit <- 1.71   # SET
tstat  <- 1.52   # SET
# Reject only if t > c.
cat("Q7:", ifelse(tstat > c_crit,
                  "Reject H0, because t>c.",
                  "Fail to reject H0, because t<c."), "\n")   # Fail to reject, t<c

## ---- Q14: bwght, t-statistic for cigs (H1: beta_cigs < 0) ----
# INPUTS are the regression; cigs is row 2, "t value" is column 3
data(bwght)
reg14 <- lm(bwght ~ cigs + faminc, data = bwght)
s14 <- summary(reg14)$coefficients
t_cigs <- s14["cigs", 3]                 # also s14[2, 1] / s14[2, 2]
cat("Q14 t =", fmt(t_cigs), "\n")        # -5.06

## ---- Q17: rescale the slope when x goes from percent to decimal ----
slope_percent <- 0.049   # SET  slope when x is in percent (40 means 40%)
# Measuring x as a decimal divides every x by 100, so the slope is multiplied by 100.
cat("Q17 slope =", fmt(slope_percent * 100), "\n")   # 4.90

## ---- Q20: hprice1 predicted price (thousands of dollars) ----
sqrft0 <- 2000   # SET
bdrms0 <- 3      # SET
data(hprice1)
reg20 <- lm(log(price) ~ log(sqrft) + bdrms, data = hprice1)
b20 <- coef(reg20)
# Plug in log(sqrft), not sqrft, then exp() to get price in thousands.
pred20 <- exp(b20[1] + b20["log(sqrft)"] * log(sqrft0) + b20["bdrms"] * bdrms0)
cat("Q20 predicted price ($000s) =", fmt(pred20), "\n")   # 279.89

######## ADDITIONAL QUIZ-POOL ITEMS FROM THE PS13 SPACER (#6, #8, #9, #16) ########

## ---- Q6: right-tail critical value, H1: beta > 0 ----
alpha <- 0.05   # SET
df    <- 28     # SET
c_right <- qt(1 - alpha, df = df)        # qt(0.95, 28); do not use 1.64
cat("Q6 c =", fmt(c_right), "\n")        # 1.70

## ---- Q8: left-tail critical value, H1: beta < 0 ----
alpha <- 0.05   # SET
df    <- 32     # SET
c_left <- qt(alpha, df = df)             # negative
cat("Q8 c =", fmt(c_left), "\n")         # -1.69

## ---- Q9: H1: beta < 0, two samples ----
c_crit <- -1.70   # SET
t_A    <- -2.10   # SET
t_B    <- -1.20   # SET
# Reject only if t < c.
dec <- function(t) if (t < c_crit) "Reject" else "Fail to reject"
cat("Q9:", paste0(dec(t_A), " H0 when t=", fmt(t_A), "; ",
                  tolower(dec(t_B)), " when t=", fmt(t_B), "."), "\n")
# Reject H0 when t=-2.10; fail to reject when t=-1.20.

## ---- Q16: bwght conclusion at 1%, using Q14 t and Q15 c ----
# Rebuild t and c from the same regression as Q14–Q15, then apply t < c.
data(bwght)
reg16 <- lm(bwght ~ cigs + faminc, data = bwght)
t16 <- summary(reg16)$coefficients["cigs", 3]
c16 <- qt(0.01, df = nrow(bwght) - 2 - 1)
cat("Q16 t =", fmt(t16), " c =", fmt(c16), " t<c?", t16 < c16, "\n")
cat("Q16:", if (t16 < c16) {
  "Reject H0, because t<c: more cigarettes per day are associated with a lower birth weight, holding family income fixed."
} else {
  "Fail to reject H0."
}, "\n")

######## REMAINING PS13 ########

## ---- Q2: Day 22 simulation, what happens as n grows? ----
# bhat is unbiased and its histogram tightens around the true beta.
# t = (bhat - beta) / se keeps its width and looks more like N(0,1).
cat("Q2:", "The histogram of β-hat_1 concentrated around the true β_1, while the histogram of t kept its width and looked more and more like N(0,1).", "\n")

## ---- Q5: wage1, t-statistic for tenure (Example 4.1) ----
data(wage1)
reg5 <- lm(log(wage) ~ educ + exper + tenure, data = wage1)
s5 <- summary(reg5)$coefficients
# tenure is row 4 (intercept, educ, exper, tenure). t = s[4,1]/s[4,2] = s[4,3].
t_tenure <- s5[4, 1] / s5[4, 2]
cat("Q5 t =", fmt(t_tenure), "  check s[4,3] =", fmt(s5[4, 3]), "\n")   # 7.13

## ---- Q10: meaning of alpha = 0.05 ----
cat("Q10:", "If H0 is true, there is a 5% chance that the test rejects it.", "\n")

## ---- Q11: ceosal1, t-statistic for roe (H1: beta_roe > 0) ----
data(ceosal1)
reg11 <- lm(log(salary) ~ log(sales) + roe, data = ceosal1)
s11 <- summary(reg11)$coefficients
t_roe <- s11["roe", 3]
cat("Q11 t =", fmt(t_roe), "\n")         # 4.52

## ---- Q12: ceosal1, 5% right-tail critical value ----
# SET (defaults match the Q11 regression)
n <- nrow(ceosal1)
K <- 2
alpha <- 0.05
c12 <- qt(1 - alpha, df = n - K - 1)    # qt(0.95, df)
cat("Q12 c =", fmt(c12), "  df =", n - K - 1, "\n")   # 1.65

## ---- Q13: ceosal1 conclusion at 5%, using Q11 t and Q12 c ----
data(ceosal1)
reg13 <- lm(log(salary) ~ log(sales) + roe, data = ceosal1)
t13 <- summary(reg13)$coefficients["roe", 3]
c13 <- qt(0.95, df = nrow(ceosal1) - 2 - 1)
cat("Q13 t =", fmt(t13), " c =", fmt(c13), " t>c?", t13 > c13, "\n")
cat("Q13:", if (t13 > c13) {
  "Reject H0, because t>c: a higher roe is associated with a higher salary, holding sales fixed."
} else {
  "Fail to reject H0."
}, "\n")

## ---- Q15: bwght, 1% left-tail critical value ----
# SET (defaults match the Q14 regression)
n <- nrow(bwght)
K <- 2
alpha <- 0.01
c15 <- qt(alpha, df = n - K - 1)        # left tail, negative
cat("Q15 c =", fmt(c15), "  df =", n - K - 1, "\n")   # -2.33

## ---- Q18: how sd(bhat) changes when SST_1 is 4 times as large ----
sd_b1 <- 0.74   # SET
sst_factor <- 4 # SET  SST_1 becomes this many times as large; R_1^2 and sigma unchanged
# sd = sigma / sqrt(SST_1 * (1-R_1^2)), so it is divided by sqrt(sst_factor).
cat("Q18 sd =", fmt(sd_b1 / sqrt(sst_factor)), "\n")   # 0.37

## ---- Q19: wage1, R_j^2 for tenure in log(wage) ~ educ + exper + tenure ----
data(wage1)
# Regress tenure on the other independent variables (the R^2 that enters the se formula).
aux19 <- lm(tenure ~ educ + exper, data = wage1)
Rj2 <- summary(aux19)$r.squared
cat("Q19 R_j^2 =", fmt(Rj2), "\n")       # 0.26

## ---- Q21: omitted-variable bias ----
beta2  <- -2.4   # SET  coefficient on the omitted variable (job)
delta1 <- -0.24  # SET  slope from regressing the omitted variable on the included one (hours)
# Bias(β~1) = β2 * δ~1. Keep both signs.
cat("Q21 Bias =", fmt(beta2 * delta1), "\n")   # 0.58

## ---- Q22: ability is in U and moves with hours ----
# MLR3 is about the independent variables in the model (no perfect collinearity).
# MLR4 is E[U|X]=0. Ability is in U and is correlated with hours, so MLR4 fails.
cat("Q22:", "MLR4 fails, because ability is in U and moves with hours, so E[U|hours]≠0.", "\n")

######## WALKTHROUGH ########
# Q1  se uses σ-hat, which is random, so (bhat-beta)/se is t, not N(0,1).
# Q2  Day 22: bhat tightens around the truth; t stays width-fixed and becomes N(0,1).
# Q3  df = n-K-1 = 99-5-1 = 93.
# Q4  t = -2.31/1.09 = -2.12 (same sign as bhat).
# Q5  tenure t = estimate/se = 7.13 (matches summary column 3).
# Q6  Right tail: qt(0.95, 28) = 1.70 (not 1.64).
# Q7  H1: beta>0 rejects only if t>c. 1.52 < 1.71, so fail to reject.
# Q8  Left tail: qt(0.05, 32) = -1.69.
# Q9  Reject if t<c. -2.10 < -1.70 (reject); -1.20 is not (fail to reject).
# Q10 Type I error: if H0 is true, the test rejects 5% of the time.
# Q11 roe t = 4.52.
# Q12 n=209, K=2, df=206, c=qt(0.95,206)=1.65.
# Q13 4.52 > 1.65, so reject: higher roe, higher salary, holding sales fixed.
# Q14 cigs t = -5.06.
# Q15 n=1388, K=2, df=1385, c=qt(0.01,1385)=-2.33.
# Q16 -5.06 < -2.33, so reject: more cigarettes, lower birth weight, holding faminc fixed.
# Q17 Decimal x = percent x / 100, so slope * 100 = 4.90.
# Q18 sd shrinks by 1/sqrt(4) = 1/2, so 0.74/2 = 0.37.
# Q19 R_j^2 from tenure ~ educ + exper is 0.26 (checks against the se formula).
# Q20 exp(b0 + b1*log(2000) + b2*3) = 279.89 (thousands of dollars).
# Q21 Bias = (-2.4)*(-0.24) = 0.576 → 0.58 (upward).
# Q22 Ability is in U and correlated with hours, so MLR4 fails (not MLR3).
