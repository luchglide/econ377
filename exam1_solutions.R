# =======================================================================
# ECN 377 - EXAM I, EVERY QUESTION SOLVED IN R
# Same questions as the 'From your Exam I' cards in Lesson 1.
# Run the whole file (Ctrl/Cmd+Shift+Enter) or one question at a time.
# '#>' comments show what R prints.
# =======================================================================
if (requireNamespace("wooldridge", quietly = TRUE)) {
  library(wooldridge)
} else {
  for (d in c("wage1", "ceosal1", "bwght", "gpa1")) assign(d, read.csv(file.path("data", paste0(d, ".csv"))))
}

## ---- Q1: a data type -------------------------------------------------
## The closing price of one company's stock, recorded every trading day from 2015 to
## 2024, is an example of:
## Exam: time-series data   ->   correct: time-series data
# Count the units: one company   [1 unit]
# one row per day, one company
# Count the times: every day for 10 years   [many times]
# 1 unit + many times -> time series

## ---- Q2: correlation vs. causation -----------------------------------
## Across U.S. cities, the number of police officers is positively correlated with the
## number of crimes. Which statement is best?
## Exam: correlation alone can't show causation   ->   correct: The correlation alone cannot tell us that police cause crime. For example, larger cities have more of both.
# A third factor (city size) raises both police and crime   [corr ≠ cause]
# no computation: a confounder drives both

## ---- Q3: percent vs. percentage points (select all) ------------------
## The unemployment rate falls from 5% to 4%. Select all statements that are correct.
## Exam: 20% and 1 percentage point   ->   correct: It fell by 20%. + It fell by 1 percentage point.
# Percentage-point change = the difference   [4 − 5 = −1 pp]
4 - 5
# #> [1] -1
# Percent change divides by the old value   [100 × (4 − 5)/5]
100 * (4 - 5) / 5
# #> [1] -20

## ---- Q4: naming the parts of Y = β₀ + β₁X + U ------------------------
## In Y = β₀ + β₁X + U, what is Y?
## Exam: Y and X swapped (0.4/1)   ->   correct: The dependent variable
# Y depends on X: it's the outcome   [Y = dependent]
# lm(y ~ x): the left of ~ is the dependent variable
# X does the explaining   [X = independent]
# the right of ~

## ---- Q5: whether E[U | x] = 0 holds ----------------------------------
## In yield = β₀ + β₁·fertilizer + U, land quality is part of U. Farmers put more
## fertilizer on better-quality land. Then:
## Exam: zero conditional mean still holds   ->   correct: the zero conditional mean assumption fails, because the average of U changes with fertilizer
# Is something in U correlated with x?   [land quality ↔ fertilizer]
# yes -> E[U | fertilizer] depends on fertilizer
# Then the assumption fails and the slope is biased   [E[U | x] ≠ 0]
# omitted-variable bias (Lesson 2)

## ---- Q6: actual y from fitted + residual -----------------------------
## Observation i has fitted value Ŷᵢ = 12 and residual Ûᵢ = −3. Which is correct?
## Exam: Y = 9, over-predicted   ->   correct: Yᵢ = 9, over-predicted
# Rearrange the residual definition   [yᵢ = ŷᵢ + ûᵢ]
12 + (-3)
# #> [1] 9
# Negative residual = the line was too high   [û < 0 → over-predicted]
# y (9) below yhat (12)

## ---- Q7: a conditional mean (the average within a group) -------------
## Among new cars sold in the U.S., which is larger: E[price | make = Toyota] or E[price
## | make = Rolls-Royce]?
## Exam: Toyota   ->   correct: E[price | Rolls-Royce]
# Conditional mean = average inside one group   [E[Y | X = x]]
# in data: mean(price[make == "Rolls-Royce"])

## ---- Q9: the fit when every point is on the line ---------------------
## In a sample where the y values are not all equal, every observation lies exactly on
## the OLS line. Then:
## Exam: SSR = 0 and R² = 1   ->   correct: SSR = 0 and R² = 1
# Every residual is 0   [SSR = Σûᵢ² = 0]
# no misses
# So R² is 1   [R² = 1 − 0/SST = 1]
1 - 0 / 6
# #> [1] 1

## ---- Q10: the meaning of R² -------------------------------------------
## A regression of house price on square footage has R² = 0.62. Which statement is
## correct?
## Exam: 62% of houses lie on the line   ->   correct: 62% of the sample variation in house price is explained by square footage.
# R² is a share of VARIATION explained   [R² = SSE / SST]
# summary(reg)$r.squared

## ---- Q11: which line is OLS -------------------------------------------
## Four candidate lines: A (Σû = 0.00, Σ|û| = 3.80, Σû² = 3.30), B (0.00, 3.20, 2.40), C
## (−0.50, 3.30, 2.55), D (1.00, 3.00, 3.00). Which is the OLS line?
## Exam: Line B   ->   correct: Line B
# Keep only lines whose residuals sum to 0   [Σûᵢ = 0]
# A and B
# Of those, pick the smallest sum of squares   [min Σûᵢ²]
min(3.30, 2.40)
# #> [1] 2.4   # line B

## ---- Q12: correlation after changing units ----------------------------
## The sample covariance between annual income (in dollars) and years of education is
## 3,200, and their sample correlation is 0.45. If income is measured in thousands of
## dollars instead, what is the sample correlation? Round to hundredths.
## Exam: (blank)   ->   correct: 0.45
# Correlation divides out both standard deviations, so units cancel   [r = s_xy / (s_x s_y)]
# income / 1000: s_xy / 1000 and s_x / 1000 -> they cancel
# So the answer is the same number   [r = 0.45]
0.45

## ---- Q13: a mean ------------------------------------------------------
## A vector of 19 numbers has first element 49, and each of the remaining elements equals
## 5. Find the sample mean. Round to hundredths.
## Exam: (blank)   ->   correct: 7.32
# Build the vector: one 49, then 18 fives   [x = (49, 5, 5, …, 5)]
x <- c(49, rep(5, 18))
length(x)
# #> [1] 19
# Add up and divide by n   [x̄ = (49 + 18·5) / 19 = 139/19]
mean(x)
# #> [1] 7.315789

## ---- Q14: a change with two x's (intercept drops) ---------------------
## Suppose y = 4 + 2.9X₁ − 0.6X₂. If X₁ rises by 1 and X₂ falls by 3, by how much does y
## change? Round to hundredths.
## Exam: (blank)   ->   correct: 4.70
# Write each slope times its change   [Δy = β₁ΔX₁ + β₂ΔX₂]
b1 <- 2.9; b2 <- -0.6
# "Falls by 3" is a change of −3   [ΔX₁ = 1, ΔX₂ = −3]
b1 * 1 + b2 * (-3)
# #> [1] 4.7

## ---- Q15: a percent change --------------------------------------------
## The unemployment rate rises from 5.6% to 6.6%. By what percent does it change? Round
## to hundredths.
## Exam: 17.86   ->   correct: 17.86
# New minus old, over old, times 100   [%Δ = 100(new − old)/old]
100 * (6.6 - 5.6) / 5.6
# #> [1] 17.85714

## ---- Q16: a sample standard deviation ---------------------------------
## Find the sample standard deviation of x = (5, 5, 2, 12). Round to hundredths.
## Exam: 4.24   ->   correct: 4.24
# Center   [x̄ = 24/4 = 6]
x <- c(5, 5, 2, 12)
mean(x)
# #> [1] 6
# Squared deviations, ÷ (n − 1)   [s² = 54/3 = 18]
var(x)
# #> [1] 18
# Square root   [s = √18]
sd(x)
# #> [1] 4.242641

## ---- Q17: a correlation from its pieces (watch: one is a VARIANCE) ----
## A sample has sample covariance S_xy = 11, sample standard deviation S_x = 3, and
## sample variance S_y² = 64. Find the sample correlation. Round to hundredths.
## Exam: (blank)   ->   correct: 0.46
# Turn the variance into a standard deviation   [S_y = √64 = 8]
sqrt(64)
# #> [1] 8
# Divide the covariance by both sds   [r = 11 / (3 · 8)]
11 / (3 * sqrt(64))
# #> [1] 0.4583333

## ---- Q18: sd of aX + b from E[X] and E[X²] ----------------------------
## E[X] = 3 and E[X²] = 27. Find the standard deviation of 3X − 2. Round to hundredths.
## Exam: (blank)   ->   correct: 12.73
# Variance from the two moments   [Var(X) = E[X²] − (E[X])²]
27 - 3^2
# #> [1] 18
# Scaling by a multiplies the sd by |a|; adding b does nothing   [sd(aX + b) = |a|·sd(X)]
3 * sqrt(18)
# #> [1] 12.72792

## ---- Q19: E[aY + b] from a table --------------------------------------
## Given X = x, Y takes the values 6, 14 and 34 with probabilities 0.5, 0.3 and 0.2. Find
## E[3Y + 4 | X = x].
## Exam: (blank)   ->   correct: 46.00
# Weighted average: value × probability, added up   [E[Y] = Σ yⱼ pⱼ]
y <- c(6, 14, 34); p <- c(0.5, 0.3, 0.2)
sum(y * p)
# #> [1] 14
# Expectation passes through a·Y + b   [E[3Y + 4] = 3E[Y] + 4]
3 * sum(y * p) + 4
# #> [1] 46

## ---- Q20: Var(aX + bY) with a covariance ------------------------------
## Var(X) = 8, Var(Y) = 6, Cov(X, Y) = −2.9. Find Var(2X − 2Y).
## Exam: (blank)   ->   correct: 79.20
# The rule   [Var(aX + bY) = a²Var(X) + b²Var(Y) + 2ab·Cov]
a <- 2; b <- -2   # the minus goes INTO b
# Plug in   [4·8 + 4·6 + 2·2·(−2)·(−2.9)]
a^2 * 8 + b^2 * 6 + 2 * a * b * (-2.9)
# #> [1] 79.2

## ---- Q21: a correlation from a JOINT PROBABILITY table ----------------
## X and Y have the joint distribution (x, y, P): (1, 4, 0.1), (4, 7, 0.4), (5, 4, 0.3),
## (6, 2, 0.2). Find Cor(X, Y). Round to hundredths.
## Exam: -0.37   ->   correct: -0.43
# Type the table as three vectors   [x, y, p]
x <- c(1, 4, 5, 6); y <- c(4, 7, 4, 2); p <- c(.1, .4, .3, .2)
# Means, weighted by probability   [E[X] = Σxp, E[Y] = Σyp]
EX <- sum(x * p); EY <- sum(y * p); c(EX, EY)
# #> [1] 4.4 4.8
# Covariance   [Cov = E[XY] − E[X]E[Y]]
cv <- sum(x * y * p) - EX * EY; cv
# #> [1] -1.12
# Variances   [Var = E[X²] − (E[X])²]
vx <- sum(x^2 * p) - EX^2; vy <- sum(y^2 * p) - EY^2
# Correlation   [Cor = Cov / (sd_x sd_y)]
cv / sqrt(vx * vy)
# #> [1] -0.4258

## ---- Q22: an OLS slope ------------------------------------------------
## For x = (1, 2, 4, 9, 10), y = (1, 1, 10, 5, 9), find the OLS slope β̂₁. Round to
## hundredths.
## Exam: 0.64   ->   correct: 0.64
# Type the data   [—]
x <- c(1, 2, 4, 9, 10); y <- c(1, 1, 10, 5, 9)
# Slope = covariance / variance of x   [β̂₁ = cov(x, y) / var(x)]
cov(x, y) / var(x)
# #> [1] 0.6407186
coef(lm(y ~ x))[2]   # same

## ---- Q23: ONE residual (not the sum of all of them) -------------------
## For x = (4, 6, 7, 8, 10), y = (4, 6, 7, 1, 8), regress y on x by OLS. Find the
## residual of the third observation, (7, 7). Round to hundredths.
## Exam: 0   ->   correct: 1.80
# Fit the line   [ŷ = β̂₀ + β̂₁x]
x <- c(4, 6, 7, 8, 10); y <- c(4, 6, 7, 1, 8)
reg <- lm(y ~ x); reg$coefficients
# #> (Intercept) 2.75   x 0.35
# Fitted value at observation 3   [ŷ₃ = 2.75 + 0.35(7)]
reg$fitted.values[3]
# #> 5.2
# Residual = actual − fitted   [û₃ = 7 − 5.2]
reg$residuals[3]
# #> 1.8

## ---- Q24: SST from a sample variance ----------------------------------
## A sample of n = 44 observations has sample variance S_y² = 7. Find SST.
## Exam: 301   ->   correct: 301.00
# The sample variance is SST divided by n − 1, so undo that   [SST = (n − 1)·S²_y]
(44 - 1) * 7
# #> [1] 301

## ---- Q25: SSR from SSE and R² -----------------------------------------
## A regression has explained sum of squares SSE = 135 and R² = 0.18. Find the sum of
## squared residuals, SSR.
## Exam: (blank)   ->   correct: 615.00
# Get the total from R² = SSE/SST   [SST = SSE / R²]
SST <- 135 / 0.18; SST
# #> [1] 750
# The rest is unexplained   [SSR = SST − SSE]
SST - 135
# #> [1] 615

## ---- Q26: ȳ from the line (means sit on the line) ---------------------
## An OLS line has intercept β̂₀ = 4 and slope β̂₁ = 1.2. The sample mean of x is 10.
## What is the sample mean of y?
## Exam: (blank)   ->   correct: 16.00
# Plug x̄ into the line   [ȳ = β̂₀ + β̂₁x̄]
4 + 1.2 * 10
# #> [1] 16

## ---- Q27: a missing residual ------------------------------------------
## An OLS regression on five observations has residuals −0.7, 2.3, 2.3, 1.8, and one
## more. What is the fifth residual?
## Exam: (blank)   ->   correct: -5.70
# OLS residuals add to zero   [Σûᵢ = 0]
# so the missing one = minus the sum of the rest
# Compute it   [û₅ = −(−0.7 + 2.3 + 2.3 + 1.8)]
-sum(c(-0.7, 2.3, 2.3, 1.8))
# #> [1] -5.7

## ---- Q28: Σxᵢûᵢ (an OLS property: always 0) ---------------------------
## For x = (1, 2, 5, 10, 11, 15), y = (5, 8, 6, 10, 8, 14), compute Σ xᵢûᵢ, where ûᵢ are
## the OLS residuals.
## Exam: 0.49   ->   correct: 0.00
# Property: x and the residuals don't move together   [Σxᵢûᵢ = 0]
# true for every OLS regression
# Check in R   [—]
x <- c(1, 2, 5, 10, 11, 15); y <- c(5, 8, 6, 10, 8, 14)
sum(x * lm(y ~ x)$residuals)
# #> [1] 7.8e-16   # = 0

## ---- Q29: n = rows of THIS dataset ------------------------------------
## Data: ceosal1. How many CEOs are in the sample?
## Exam: 526   ->   correct: 209.00
# Load the course data   [—]
library(wooldridge)
# One CEO = one row, so count the rows of ceosal1 (not wage1)   [n = number of rows]
nrow(ceosal1)
# #> [1] 209

## ---- Q30: a sample mean of one column ---------------------------------
## Data: ceosal1. What is the sample mean of return on equity (roe)? Round to hundredths.
## Exam: (blank)   ->   correct: 17.18
# Pull out the roe column with $   [x = roe]
ceosal1$roe
# Average it   [x̄ = Σxᵢ / n]
mean(ceosal1$roe)
# #> [1] 17.18421

## ---- Q31: a correlation from data (must be between −1 and 1!) ---------
## Data: ceosal1. What is the sample correlation between salary and return on equity?
## Round to hundredths.
## Exam: 963.19   ->   correct: 0.11
# Correlation of two columns: no regression needed   [r = s_xy / (s_x s_y)]
cor(ceosal1$salary, ceosal1$roe)
# #> [1] 0.1148417
# Sanity check: is it between −1 and 1?   [−1 ≤ r ≤ 1]
# 0.11 yes. 963.19 is impossible for a correlation

## ---- Q32: the slope (the x row's Estimate) ----------------------------
## Data: wage1. Run the OLS regression of wage on tenure. What is the OLS slope? Round to
## hundredths.
## Exam: (blank)   ->   correct: 0.18
# Run it   [—]
reg <- lm(wage ~ tenure, data = wage1)
# Slope = the 2nd coefficient (the tenure row)   [β̂₁]
reg$coefficients[2]
# #> 0.1773271

## ---- Q33: a prediction (keep the intercept) ---------------------------
## Using the same regression, what is the predicted hourly wage of a worker with 10 years
## of tenure? Round to hundredths.
## Exam: (blank)   ->   correct: 6.76
# Save the coefficients   [β̂₀, β̂₁]
b <- reg$coefficients
# Plug in tenure = 10   [ŷ = β̂₀ + β̂₁(10)]
b[1] + b[2] * 10
# #> 6.764196

## ---- Q34: a change from 3 to 16 (drop the intercept) ------------------
## Using the same regression, by how much does predicted wage change when tenure rises
## from 3 to 16 years? Round to hundredths.
## Exam: 7.04   ->   correct: 2.31
# The change in x   [Δx = 16 − 3 = 13]
16 - 3
# #> [1] 13
# Slope × change, no intercept   [Δŷ = β̂₁Δx]
b[2] * (16 - 3)
# #> 2.305252

## ---- Q35: R² as a percent ---------------------------------------------
## What percentage of the sample variation in wage is explained by tenure? Round to
## hundredths.
## Exam: (blank)   ->   correct: 12.03
# R² from summary, times 100   [100 · R²]
100 * summary(reg)$r.squared
# #> [1] 12.03324

## ---- Q36: the residual of one row -------------------------------------
## What is the OLS residual of the worker in the second row of wage1? Round to
## hundredths.
## Exam: (blank)   ->   correct: -2.11
# Residual of row 2   [û₂ = y₂ − ŷ₂]
reg$residuals[2]
# #> -2.106
# Check by hand   [3.24 − 5.35]
wage1$wage[2] - reg$fitted.values[2]
# #> -2.106

## ---- Q37: SSE (EXPLAINED) from data -----------------------------------
## Data: bwght. Run the OLS regression of birth weight on family income. What is the
## explained sum of squares, SSE? Round to hundredths.
## Exam: (blank)   ->   correct: 6819.05
# Run the regression   [ŷ = β̂₀ + β̂₁·faminc]
reg <- lm(bwght ~ faminc, data = bwght)
# Explained = fitted values' spread around ȳ   [SSE = Σ(ŷᵢ − ȳ)²]
sum((reg$fitted.values - mean(bwght$bwght))^2)
# #> [1] 6819.05

## ---- Q38: a change (slope × change) -----------------------------------
## Data: bwght. Regress birth weight on family income. By how many ounces does predicted
## birth weight change when family income rises by 17 ($17,000)? Round to hundredths.
## Exam: (blank)   ->   correct: 2.01
# Run it and take the slope   [β̂₁]
reg <- lm(bwght ~ faminc, data = bwght)
reg$coefficients[2]
# #> 0.1183234
# Slope × 17   [Δŷ = β̂₁ × 17]
reg$coefficients[2] * 17
# #> 2.011498

