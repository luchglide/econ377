# Exam I — every question solved

Score 11.4 / 38 in 70 minutes. Most points lost were **blank**, not wrong. Runnable R: `exam1_solutions.R` in the econ377 repo.

Back to [[00 Start here]] · Lessons: [[Lesson 1 - Foundations]]

## Data (Lesson 1 §1)
### Q1 — a data type

> The closing price of one company's stock, recorded every trading day from 2015 to 2024, is an example of:

Choices: panel data · cross-sectional data · time-series data · a population

- **On the exam:** ✅ right — you answered *time-series data*
- **Correct:** time-series data
- **Why:** One unit (one company) over many times = time series.

| # | The idea | The equation |
|---|---|---|
| 1 | Count the units: one company | 1 unit |
| 2 | Count the times: every day for 10 years | many times |

```r
# Count the units: one company   [1 unit]
# one row per day, one company
# Count the times: every day for 10 years   [many times]
# 1 unit + many times -> time series
```

### Q29 — n = rows of THIS dataset

> Data: ceosal1. How many CEOs are in the sample?

- **On the exam:** ❌ missed — you answered *526*
- **Correct:** 209.00
- **Why:** Each CEO is one row of ceosal1: nrow(ceosal1) = 209. The 526 on the exam is the number of rows in wage1, a different dataset.

| # | The idea | The equation |
|---|---|---|
| 1 | Load the course data | — |
| 2 | One CEO = one row, so count the rows of ceosal1 (not wage1) | n = number of rows |

```r
# Load the course data   [—]
library(wooldridge)
# One CEO = one row, so count the rows of ceosal1 (not wage1)   [n = number of rows]
nrow(ceosal1)
#> [1] 209
```

### Q30 — a sample mean of one column

> Data: ceosal1. What is the sample mean of return on equity (roe)? Round to hundredths.

- **On the exam:** ⬜ left blank
- **Correct:** 17.18
- **Why:** mean(ceosal1$roe) = 17.18. Pull the column with $, then take its mean.

| # | The idea | The equation |
|---|---|---|
| 1 | Pull out the roe column with $ | x = roe |
| 2 | Average it | x̄ = Σxᵢ / n |

```r
# Pull out the roe column with $   [x = roe]
ceosal1$roe
# Average it   [x̄ = Σxᵢ / n]
mean(ceosal1$roe)
#> [1] 17.18421
```

## One variable (Lesson 1 §2)
### Q13 — a mean

> A vector of 19 numbers has first element 49, and each of the remaining elements equals 5. Find the sample mean. Round to hundredths.

- **On the exam:** ⬜ left blank
- **Correct:** 7.32
- **Why:** Sum = 49 + 18 × 5 = 139, and n = 19, so the mean is 139/19 = 7.32. In R, build the vector and take mean().

| # | The idea | The equation |
|---|---|---|
| 1 | Build the vector: one 49, then 18 fives | x = (49, 5, 5, …, 5) |
| 2 | Add up and divide by n | x̄ = (49 + 18·5) / 19 = 139/19 |

```r
# Build the vector: one 49, then 18 fives   [x = (49, 5, 5, …, 5)]
x <- c(49, rep(5, 18))
length(x)
#> [1] 19
# Add up and divide by n   [x̄ = (49 + 18·5) / 19 = 139/19]
mean(x)
#> [1] 7.315789
```

### Q16 — a sample standard deviation

> Find the sample standard deviation of x = (5, 5, 2, 12). Round to hundredths.

- **On the exam:** ✅ right — you answered *4.24*
- **Correct:** 4.24
- **Why:** Mean 6; deviations −1, −1, −4, 6; squares sum to 54; ÷ 3 = 18; √18 = 4.24.

| # | The idea | The equation |
|---|---|---|
| 1 | Center | x̄ = 24/4 = 6 |
| 2 | Squared deviations, ÷ (n − 1) | s² = 54/3 = 18 |
| 3 | Square root | s = √18 |

```r
# Center   [x̄ = 24/4 = 6]
x <- c(5, 5, 2, 12)
mean(x)
#> [1] 6
# Squared deviations, ÷ (n − 1)   [s² = 54/3 = 18]
var(x)
#> [1] 18
# Square root   [s = √18]
sd(x)
#> [1] 4.242641
```

## Covariance & correlation (Lesson 1 §3)
### Q2 — correlation vs. causation

> Across U.S. cities, the number of police officers is positively correlated with the number of crimes. Which statement is best?

Choices: Because the correlation is positive, adding police to a city would increase its crime, holding all else equal. · The correlation alone cannot tell us that police cause crime. For example, larger cities have more of both. · The correlation must be close to 1. · Hiring police causes crime.

- **On the exam:** ✅ right — you answered *correlation alone can't show causation*
- **Correct:** The correlation alone cannot tell us that police cause crime. For example, larger cities have more of both.
- **Why:** City size is a confounder that drives both. Correlation is not causation.

| # | The idea | The equation |
|---|---|---|
| 1 | A third factor (city size) raises both police and crime | corr ≠ cause |

```r
# A third factor (city size) raises both police and crime   [corr ≠ cause]
# no computation: a confounder drives both
```

### Q12 — correlation after changing units

> The sample covariance between annual income (in dollars) and years of education is 3,200, and their sample correlation is 0.45. If income is measured in thousands of dollars instead, what is the sample correlation? Round to hundredths.

- **On the exam:** ⬜ left blank
- **Correct:** 0.45
- **Why:** Correlation has no units, so rescaling income doesn't change it: 0.45. Only the covariance changes (3,200 → 3.2). No computation needed.

| # | The idea | The equation |
|---|---|---|
| 1 | Correlation divides out both standard deviations, so units cancel | r = s_xy / (s_x s_y) |
| 2 | So the answer is the same number | r = 0.45 |

```r
# Correlation divides out both standard deviations, so units cancel   [r = s_xy / (s_x s_y)]
# income / 1000: s_xy / 1000 and s_x / 1000 -> they cancel
# So the answer is the same number   [r = 0.45]
0.45
```

### Q17 — a correlation from its pieces (watch: one is a VARIANCE)

> A sample has sample covariance S_xy = 11, sample standard deviation S_x = 3, and sample variance S_y² = 64. Find the sample correlation. Round to hundredths.

- **On the exam:** ⬜ left blank
- **Correct:** 0.46
- **Why:** S_y² is a variance, so S_y = √64 = 8. r = 11 / (3 × 8) = 0.46.

| # | The idea | The equation |
|---|---|---|
| 1 | Turn the variance into a standard deviation | S_y = √64 = 8 |
| 2 | Divide the covariance by both sds | r = 11 / (3 · 8) |

```r
# Turn the variance into a standard deviation   [S_y = √64 = 8]
sqrt(64)
#> [1] 8
# Divide the covariance by both sds   [r = 11 / (3 · 8)]
11 / (3 * sqrt(64))
#> [1] 0.4583333
```

### Q31 — a correlation from data (must be between −1 and 1!)

> Data: ceosal1. What is the sample correlation between salary and return on equity? Round to hundredths.

- **On the exam:** ❌ missed — you answered *963.19*
- **Correct:** 0.11
- **Why:** cor(ceosal1$salary, ceosal1$roe) = 0.11. The 963.19 on the exam is the intercept of lm(salary ~ roe). A correlation can never be outside −1 to 1, so that alone flags it.

| # | The idea | The equation |
|---|---|---|
| 1 | Correlation of two columns: no regression needed | r = s_xy / (s_x s_y) |
| 2 | Sanity check: is it between −1 and 1? | −1 ≤ r ≤ 1 |

```r
# Correlation of two columns: no regression needed   [r = s_xy / (s_x s_y)]
cor(ceosal1$salary, ceosal1$roe)
#> [1] 0.1148417
# Sanity check: is it between −1 and 1?   [−1 ≤ r ≤ 1]
# 0.11 yes. 963.19 is impossible for a correlation
```

## Lines & percents (Lesson 1 §4)
### Q3 — percent vs. percentage points (select all)

> The unemployment rate falls from 5% to 4%. Select all statements that are correct.

Choices: It fell by 1%. · It fell by 20 percentage points. · It fell by 20%. · It fell by 25%. · It fell by 1 percentage point.

- **On the exam:** ✅ right — you answered *20% and 1 percentage point*
- **Correct:** It fell by 20%. + It fell by 1 percentage point.
- **Why:** Percentage points: 4 − 5 = −1 point. Percent: (4 − 5)/5 × 100 = −20%. Divide by the OLD value (5), not 4.

| # | The idea | The equation |
|---|---|---|
| 1 | Percentage-point change = the difference | 4 − 5 = −1 pp |
| 2 | Percent change divides by the old value | 100 × (4 − 5)/5 |

```r
# Percentage-point change = the difference   [4 − 5 = −1 pp]
4 - 5
#> [1] -1
# Percent change divides by the old value   [100 × (4 − 5)/5]
100 * (4 - 5) / 5
#> [1] -20
```

### Q14 — a change with two x's (intercept drops)

> Suppose y = 4 + 2.9X₁ − 0.6X₂. If X₁ rises by 1 and X₂ falls by 3, by how much does y change? Round to hundredths.

- **On the exam:** ⬜ left blank
- **Correct:** 4.70
- **Why:** Δy = 2.9(1) + (−0.6)(−3) = 2.9 + 1.8 = 4.70. The 4 never enters a change, and "falls by 3" means ΔX₂ = −3.

| # | The idea | The equation |
|---|---|---|
| 1 | Write each slope times its change | Δy = β₁ΔX₁ + β₂ΔX₂ |
| 2 | "Falls by 3" is a change of −3 | ΔX₁ = 1, ΔX₂ = −3 |

```r
# Write each slope times its change   [Δy = β₁ΔX₁ + β₂ΔX₂]
b1 <- 2.9; b2 <- -0.6
# "Falls by 3" is a change of −3   [ΔX₁ = 1, ΔX₂ = −3]
b1 * 1 + b2 * (-3)
#> [1] 4.7
```

### Q15 — a percent change

> The unemployment rate rises from 5.6% to 6.6%. By what percent does it change? Round to hundredths.

- **On the exam:** ✅ right — you answered *17.86*
- **Correct:** 17.86
- **Why:** (6.6 − 5.6)/5.6 × 100 = 17.86%.

| # | The idea | The equation |
|---|---|---|
| 1 | New minus old, over old, times 100 | %Δ = 100(new − old)/old |

```r
# New minus old, over old, times 100   [%Δ = 100(new − old)/old]
100 * (6.6 - 5.6) / 5.6
#> [1] 17.85714
```

## OLS (Lesson 1 §5)
### Q4 — naming the parts of Y = β₀ + β₁X + U

> In Y = β₀ + β₁X + U, what is Y?

Choices: The independent variable · The dependent variable · The error term · The fitted value

- **On the exam:** 🟨 partial credit — you answered *Y and X swapped (0.4/1)*
- **Correct:** The dependent variable
- **Why:** Y is the dependent variable (the outcome being explained). X is the independent (explanatory) variable, U the error, β₁ the slope, β₀ the intercept. On Exam I, Y and X were swapped.

| # | The idea | The equation |
|---|---|---|
| 1 | Y depends on X: it's the outcome | Y = dependent |
| 2 | X does the explaining | X = independent |

```r
# Y depends on X: it's the outcome   [Y = dependent]
# lm(y ~ x): the left of ~ is the dependent variable
# X does the explaining   [X = independent]
# the right of ~
```

### Q6 — actual y from fitted + residual

> Observation i has fitted value Ŷᵢ = 12 and residual Ûᵢ = −3. Which is correct?

Choices: Yᵢ = 15, over-predicted · Yᵢ = 15, under-predicted · Yᵢ = 9, over-predicted · Yᵢ = 9, under-predicted

- **On the exam:** ✅ right — you answered *Y = 9, over-predicted*
- **Correct:** Yᵢ = 9, over-predicted
- **Why:** û = y − ŷ, so y = ŷ + û = 12 − 3 = 9. The line said 12 but the truth was 9: over-predicted.

| # | The idea | The equation |
|---|---|---|
| 1 | Rearrange the residual definition | yᵢ = ŷᵢ + ûᵢ |
| 2 | Negative residual = the line was too high | û < 0 → over-predicted |

```r
# Rearrange the residual definition   [yᵢ = ŷᵢ + ûᵢ]
12 + (-3)
#> [1] 9
# Negative residual = the line was too high   [û < 0 → over-predicted]
# y (9) below yhat (12)
```

### Q11 — which line is OLS

> Four candidate lines: A (Σû = 0.00, Σ|û| = 3.80, Σû² = 3.30), B (0.00, 3.20, 2.40), C (−0.50, 3.30, 2.55), D (1.00, 3.00, 3.00). Which is the OLS line?

Choices: Line A · Line B · Line C · Line D

- **On the exam:** ✅ right — you answered *Line B*
- **Correct:** Line B
- **Why:** OLS residuals sum to 0 (A or B) and OLS minimizes the sum of SQUARED residuals: B's 2.40 < A's 3.30.

| # | The idea | The equation |
|---|---|---|
| 1 | Keep only lines whose residuals sum to 0 | Σûᵢ = 0 |
| 2 | Of those, pick the smallest sum of squares | min Σûᵢ² |

```r
# Keep only lines whose residuals sum to 0   [Σûᵢ = 0]
# A and B
# Of those, pick the smallest sum of squares   [min Σûᵢ²]
min(3.30, 2.40)
#> [1] 2.4   # line B
```

### Q22 — an OLS slope

> For x = (1, 2, 4, 9, 10), y = (1, 1, 10, 5, 9), find the OLS slope β̂₁. Round to hundredths.

- **On the exam:** ✅ right — you answered *0.64*
- **Correct:** 0.64
- **Why:** β̂₁ = cov(x, y)/var(x) = 0.64.

| # | The idea | The equation |
|---|---|---|
| 1 | Type the data | — |
| 2 | Slope = covariance / variance of x | β̂₁ = cov(x, y) / var(x) |

```r
# Type the data   [—]
x <- c(1, 2, 4, 9, 10); y <- c(1, 1, 10, 5, 9)
# Slope = covariance / variance of x   [β̂₁ = cov(x, y) / var(x)]
cov(x, y) / var(x)
#> [1] 0.6407186
coef(lm(y ~ x))[2]   # same
```

### Q23 — ONE residual (not the sum of all of them)

> For x = (4, 6, 7, 8, 10), y = (4, 6, 7, 1, 8), regress y on x by OLS. Find the residual of the third observation, (7, 7). Round to hundredths.

- **On the exam:** ❌ missed — you answered *0*
- **Correct:** 1.80
- **Why:** The line is ŷ = 2.75 + 0.35x, so at x = 7 the fitted value is 5.2 and the residual is 7 − 5.2 = 1.80. The 0 on the exam is the SUM of all the residuals (always 0), not one residual.

| # | The idea | The equation |
|---|---|---|
| 1 | Fit the line | ŷ = β̂₀ + β̂₁x |
| 2 | Fitted value at observation 3 | ŷ₃ = 2.75 + 0.35(7) |
| 3 | Residual = actual − fitted | û₃ = 7 − 5.2 |

```r
# Fit the line   [ŷ = β̂₀ + β̂₁x]
x <- c(4, 6, 7, 8, 10); y <- c(4, 6, 7, 1, 8)
reg <- lm(y ~ x); reg$coefficients
#> (Intercept) 2.75   x 0.35
# Fitted value at observation 3   [ŷ₃ = 2.75 + 0.35(7)]
reg$fitted.values[3]
#> 5.2
# Residual = actual − fitted   [û₃ = 7 − 5.2]
reg$residuals[3]
#> 1.8
```

### Q26 — ȳ from the line (means sit on the line)

> An OLS line has intercept β̂₀ = 4 and slope β̂₁ = 1.2. The sample mean of x is 10. What is the sample mean of y?

- **On the exam:** ⬜ left blank
- **Correct:** 16.00
- **Why:** (x̄, ȳ) is always on the OLS line: ȳ = 4 + 1.2 × 10 = 16. No data needed.

| # | The idea | The equation |
|---|---|---|
| 1 | Plug x̄ into the line | ȳ = β̂₀ + β̂₁x̄ |

```r
# Plug x̄ into the line   [ȳ = β̂₀ + β̂₁x̄]
4 + 1.2 * 10
#> [1] 16
```

### Q27 — a missing residual

> An OLS regression on five observations has residuals −0.7, 2.3, 2.3, 1.8, and one more. What is the fifth residual?

- **On the exam:** ⬜ left blank
- **Correct:** -5.70
- **Why:** Residuals always sum to 0. The four known ones sum to 5.7, so the fifth is −5.70.

| # | The idea | The equation |
|---|---|---|
| 1 | OLS residuals add to zero | Σûᵢ = 0 |
| 2 | Compute it | û₅ = −(−0.7 + 2.3 + 2.3 + 1.8) |

```r
# OLS residuals add to zero   [Σûᵢ = 0]
# so the missing one = minus the sum of the rest
# Compute it   [û₅ = −(−0.7 + 2.3 + 2.3 + 1.8)]
-sum(c(-0.7, 2.3, 2.3, 1.8))
#> [1] -5.7
```

### Q28 — Σxᵢûᵢ (an OLS property: always 0)

> For x = (1, 2, 5, 10, 11, 15), y = (5, 8, 6, 10, 8, 14), compute Σ xᵢûᵢ, where ûᵢ are the OLS residuals.

- **On the exam:** ❌ missed — you answered *0.49*
- **Correct:** 0.00
- **Why:** For ANY OLS fit, Σxᵢûᵢ = 0: x and the residuals are uncorrelated. No computing needed, and R confirms it.

| # | The idea | The equation |
|---|---|---|
| 1 | Property: x and the residuals don't move together | Σxᵢûᵢ = 0 |
| 2 | Check in R | — |

```r
# Property: x and the residuals don't move together   [Σxᵢûᵢ = 0]
# true for every OLS regression
# Check in R   [—]
x <- c(1, 2, 5, 10, 11, 15); y <- c(5, 8, 6, 10, 8, 14)
sum(x * lm(y ~ x)$residuals)
#> [1] 7.8e-16   # = 0
```

## Fit / R² (Lesson 1 §6)
### Q9 — the fit when every point is on the line

> In a sample where the y values are not all equal, every observation lies exactly on the OLS line. Then:

Choices: R² = 0 · SST = 0 · SST = SSR · SSR = 0 and R² = 1

- **On the exam:** ✅ right — you answered *SSR = 0 and R² = 1*
- **Correct:** SSR = 0 and R² = 1
- **Why:** All residuals are 0, so SSR = 0, and R² = 1 − SSR/SST = 1.

| # | The idea | The equation |
|---|---|---|
| 1 | Every residual is 0 | SSR = Σûᵢ² = 0 |
| 2 | So R² is 1 | R² = 1 − 0/SST = 1 |

```r
# Every residual is 0   [SSR = Σûᵢ² = 0]
# no misses
# So R² is 1   [R² = 1 − 0/SST = 1]
1 - 0 / 6
#> [1] 1
```

### Q10 — the meaning of R²

> A regression of house price on square footage has R² = 0.62. Which statement is correct?

Choices: 62% of the houses lie exactly on the regression line. · 62% of the sample variation in house price is explained by square footage. · Square footage causes 62% of a house's price. · One more square foot raises the predicted price by 0.62.

- **On the exam:** ❌ missed — you answered *62% of houses lie on the line*
- **Correct:** 62% of the sample variation in house price is explained by square footage.
- **Why:** R² = SSE/SST: the share of the variation in y that x explains. It says nothing about how many points are on the line, about causation, or about the slope.

| # | The idea | The equation |
|---|---|---|
| 1 | R² is a share of VARIATION explained | R² = SSE / SST |

```r
# R² is a share of VARIATION explained   [R² = SSE / SST]
summary(reg)$r.squared
```

### Q24 — SST from a sample variance

> A sample of n = 44 observations has sample variance S_y² = 7. Find SST.

- **On the exam:** ✅ right — you answered *301*
- **Correct:** 301.00
- **Why:** SST = (n − 1)·S_y² = 43 × 7 = 301.

| # | The idea | The equation |
|---|---|---|
| 1 | The sample variance is SST divided by n − 1, so undo that | SST = (n − 1)·S²_y |

```r
# The sample variance is SST divided by n − 1, so undo that   [SST = (n − 1)·S²_y]
(44 - 1) * 7
#> [1] 301
```

### Q25 — SSR from SSE and R²

> A regression has explained sum of squares SSE = 135 and R² = 0.18. Find the sum of squared residuals, SSR.

- **On the exam:** ⬜ left blank
- **Correct:** 615.00
- **Why:** SST = SSE/R² = 135/0.18 = 750. SSR = SST − SSE = 750 − 135 = 615.

| # | The idea | The equation |
|---|---|---|
| 1 | Get the total from R² = SSE/SST | SST = SSE / R² |
| 2 | The rest is unexplained | SSR = SST − SSE |

```r
# Get the total from R² = SSE/SST   [SST = SSE / R²]
SST <- 135 / 0.18; SST
#> [1] 750
# The rest is unexplained   [SSR = SST − SSE]
SST - 135
#> [1] 615
```

### Q37 — SSE (EXPLAINED) from data

> Data: bwght. Run the OLS regression of birth weight on family income. What is the explained sum of squares, SSE? Round to hundredths.

- **On the exam:** ⬜ left blank
- **Correct:** 6819.05
- **Why:** SSE = Σ(ŷᵢ − ȳ)² = 6819.05. Remember: SSE = EXPLAINED, SSR = residual.

| # | The idea | The equation |
|---|---|---|
| 1 | Run the regression | ŷ = β̂₀ + β̂₁·faminc |
| 2 | Explained = fitted values' spread around ȳ | SSE = Σ(ŷᵢ − ȳ)² |

```r
# Run the regression   [ŷ = β̂₀ + β̂₁·faminc]
reg <- lm(bwght ~ faminc, data = bwght)
# Explained = fitted values' spread around ȳ   [SSE = Σ(ŷᵢ − ȳ)²]
sum((reg$fitted.values - mean(bwght$bwght))^2)
#> [1] 6819.05
```

## Reading R output (Lesson 1 §7)
### Q32 — the slope (the x row's Estimate)

> Data: wage1. Run the OLS regression of wage on tenure. What is the OLS slope? Round to hundredths.

- **On the exam:** ⬜ left blank
- **Correct:** 0.18
- **Why:** reg$coefficients[2] = 0.1773 → 0.18.

| # | The idea | The equation |
|---|---|---|
| 1 | Run it | — |
| 2 | Slope = the 2nd coefficient (the tenure row) | β̂₁ |

```r
# Run it   [—]
reg <- lm(wage ~ tenure, data = wage1)
# Slope = the 2nd coefficient (the tenure row)   [β̂₁]
reg$coefficients[2]
#> 0.1773271
```

### Q33 — a prediction (keep the intercept)

> Using the same regression, what is the predicted hourly wage of a worker with 10 years of tenure? Round to hundredths.

- **On the exam:** ⬜ left blank
- **Correct:** 6.76
- **Why:** 4.9909 + 0.1773 × 10 = 6.76.

| # | The idea | The equation |
|---|---|---|
| 1 | Save the coefficients | β̂₀, β̂₁ |
| 2 | Plug in tenure = 10 | ŷ = β̂₀ + β̂₁(10) |

```r
# Save the coefficients   [β̂₀, β̂₁]
b <- reg$coefficients
# Plug in tenure = 10   [ŷ = β̂₀ + β̂₁(10)]
b[1] + b[2] * 10
#> 6.764196
```

### Q34 — a change from 3 to 16 (drop the intercept)

> Using the same regression, by how much does predicted wage change when tenure rises from 3 to 16 years? Round to hundredths.

- **On the exam:** ❌ missed — you answered *7.04*
- **Correct:** 2.31
- **Why:** Δŷ = 0.1773 × (16 − 3) = 2.31. The intercept cancels in a change, and the Δx is 13, not 16.

| # | The idea | The equation |
|---|---|---|
| 1 | The change in x | Δx = 16 − 3 = 13 |
| 2 | Slope × change, no intercept | Δŷ = β̂₁Δx |

```r
# The change in x   [Δx = 16 − 3 = 13]
16 - 3
#> [1] 13
# Slope × change, no intercept   [Δŷ = β̂₁Δx]
b[2] * (16 - 3)
#> 2.305252
```

### Q35 — R² as a percent

> What percentage of the sample variation in wage is explained by tenure? Round to hundredths.

- **On the exam:** ⬜ left blank
- **Correct:** 12.03
- **Why:** 100 × R² = 12.03.

| # | The idea | The equation |
|---|---|---|
| 1 | R² from summary, times 100 | 100 · R² |

```r
# R² from summary, times 100   [100 · R²]
100 * summary(reg)$r.squared
#> [1] 12.03324
```

### Q36 — the residual of one row

> What is the OLS residual of the worker in the second row of wage1? Round to hundredths.

- **On the exam:** ⬜ left blank
- **Correct:** -2.11
- **Why:** reg$residuals[2] = −2.11: actual 3.24 minus fitted 5.35.

| # | The idea | The equation |
|---|---|---|
| 1 | Residual of row 2 | û₂ = y₂ − ŷ₂ |
| 2 | Check by hand | 3.24 − 5.35 |

```r
# Residual of row 2   [û₂ = y₂ − ŷ₂]
reg$residuals[2]
#> -2.106
# Check by hand   [3.24 − 5.35]
wage1$wage[2] - reg$fitted.values[2]
#> -2.106
```

### Q38 — a change (slope × change)

> Data: bwght. Regress birth weight on family income. By how many ounces does predicted birth weight change when family income rises by 17 ($17,000)? Round to hundredths.

- **On the exam:** ⬜ left blank
- **Correct:** 2.01
- **Why:** β̂₁ = 0.1183, so Δŷ = 0.1183 × 17 = 2.01.

| # | The idea | The equation |
|---|---|---|
| 1 | Run it and take the slope | β̂₁ |
| 2 | Slope × 17 | Δŷ = β̂₁ × 17 |

```r
# Run it and take the slope   [β̂₁]
reg <- lm(bwght ~ faminc, data = bwght)
reg$coefficients[2]
#> 0.1183234
# Slope × 17   [Δŷ = β̂₁ × 17]
reg$coefficients[2] * 17
#> 2.011498
```

## Probability & assumptions (Lesson 1 §9)
### Q5 — whether E[U | x] = 0 holds

> In yield = β₀ + β₁·fertilizer + U, land quality is part of U. Farmers put more fertilizer on better-quality land. Then:

Choices: the zero conditional mean assumption fails, because the average of U changes with fertilizer · the zero conditional mean assumption E[U | fertilizer] = 0 still holds · U is always equal to zero · β₁ must equal zero

- **On the exam:** ❌ missed — you answered *zero conditional mean still holds*
- **Correct:** the zero conditional mean assumption fails, because the average of U changes with fertilizer
- **Why:** Land quality is in U and moves with fertilizer, so the average of U changes with x: E[U | x] ≠ 0. Lesson 2 covers this in depth.

| # | The idea | The equation |
|---|---|---|
| 1 | Is something in U correlated with x? | land quality ↔ fertilizer |
| 2 | Then the assumption fails and the slope is biased | E[U | x] ≠ 0 |

```r
# Is something in U correlated with x?   [land quality ↔ fertilizer]
# yes -> E[U | fertilizer] depends on fertilizer
# Then the assumption fails and the slope is biased   [E[U | x] ≠ 0]
# omitted-variable bias (Lesson 2)
```

### Q7 — a conditional mean (the average within a group)

> Among new cars sold in the U.S., which is larger: E[price | make = Toyota] or E[price | make = Rolls-Royce]?

Choices: E[price | Toyota] · Neither: both are cars · Neither: a conditional expectation doesn't depend on the group · E[price | Rolls-Royce]

- **On the exam:** ❌ missed — you answered *Toyota*
- **Correct:** E[price | Rolls-Royce]
- **Why:** E[Y | X = x] is just the average Y within that group. The average Rolls-Royce costs far more than the average Toyota.

| # | The idea | The equation |
|---|---|---|
| 1 | Conditional mean = average inside one group | E[Y | X = x] |

```r
# Conditional mean = average inside one group   [E[Y | X = x]]
# in data: mean(price[make == "Rolls-Royce"])
```

### Q18 — sd of aX + b from E[X] and E[X²]

> E[X] = 3 and E[X²] = 27. Find the standard deviation of 3X − 2. Round to hundredths.

- **On the exam:** ⬜ left blank
- **Correct:** 12.73
- **Why:** Var(X) = 27 − 3² = 18. sd(X) = √18 = 4.24. sd(3X − 2) = |3| × 4.24 = 12.73. The −2 doesn't change spread.

| # | The idea | The equation |
|---|---|---|
| 1 | Variance from the two moments | Var(X) = E[X²] − (E[X])² |
| 2 | Scaling by a multiplies the sd by |a|; adding b does nothing | sd(aX + b) = |a|·sd(X) |

```r
# Variance from the two moments   [Var(X) = E[X²] − (E[X])²]
27 - 3^2
#> [1] 18
# Scaling by a multiplies the sd by |a|; adding b does nothing   [sd(aX + b) = |a|·sd(X)]
3 * sqrt(18)
#> [1] 12.72792
```

### Q19 — E[aY + b] from a table

> Given X = x, Y takes the values 6, 14 and 34 with probabilities 0.5, 0.3 and 0.2. Find E[3Y + 4 | X = x].

- **On the exam:** ⬜ left blank
- **Correct:** 46.00
- **Why:** E[Y] = 6(.5) + 14(.3) + 34(.2) = 14. Then E[3Y + 4] = 3(14) + 4 = 46.

| # | The idea | The equation |
|---|---|---|
| 1 | Weighted average: value × probability, added up | E[Y] = Σ yⱼ pⱼ |
| 2 | Expectation passes through a·Y + b | E[3Y + 4] = 3E[Y] + 4 |

```r
# Weighted average: value × probability, added up   [E[Y] = Σ yⱼ pⱼ]
y <- c(6, 14, 34); p <- c(0.5, 0.3, 0.2)
sum(y * p)
#> [1] 14
# Expectation passes through a·Y + b   [E[3Y + 4] = 3E[Y] + 4]
3 * sum(y * p) + 4
#> [1] 46
```

### Q20 — Var(aX + bY) with a covariance

> Var(X) = 8, Var(Y) = 6, Cov(X, Y) = −2.9. Find Var(2X − 2Y).

- **On the exam:** ⬜ left blank
- **Correct:** 79.20
- **Why:** a = 2, b = −2: 4(8) + 4(6) + 2(2)(−2)(−2.9) = 32 + 24 + 23.2 = 79.2.

| # | The idea | The equation |
|---|---|---|
| 1 | The rule | Var(aX + bY) = a²Var(X) + b²Var(Y) + 2ab·Cov |
| 2 | Plug in | 4·8 + 4·6 + 2·2·(−2)·(−2.9) |

```r
# The rule   [Var(aX + bY) = a²Var(X) + b²Var(Y) + 2ab·Cov]
a <- 2; b <- -2   # the minus goes INTO b
# Plug in   [4·8 + 4·6 + 2·2·(−2)·(−2.9)]
a^2 * 8 + b^2 * 6 + 2 * a * b * (-2.9)
#> [1] 79.2
```

### Q21 — a correlation from a JOINT PROBABILITY table

> X and Y have the joint distribution (x, y, P): (1, 4, 0.1), (4, 7, 0.4), (5, 4, 0.3), (6, 2, 0.2). Find Cor(X, Y). Round to hundredths.

- **On the exam:** ❌ missed — you answered *-0.37*
- **Correct:** -0.43
- **Why:** It's a probability table, not a sample, so weight by p (never cor()). E[X] = 4.4, E[Y] = 4.8, E[XY] = 20, Cov = −1.12, Var(X) = 1.84, Var(Y) = 3.76, Cor = −1.12/√(1.84 × 3.76) = −0.43.

| # | The idea | The equation |
|---|---|---|
| 1 | Type the table as three vectors | x, y, p |
| 2 | Means, weighted by probability | E[X] = Σxp, E[Y] = Σyp |
| 3 | Covariance | Cov = E[XY] − E[X]E[Y] |
| 4 | Variances | Var = E[X²] − (E[X])² |
| 5 | Correlation | Cor = Cov / (sd_x sd_y) |

```r
# Type the table as three vectors   [x, y, p]
x <- c(1, 4, 5, 6); y <- c(4, 7, 4, 2); p <- c(.1, .4, .3, .2)
# Means, weighted by probability   [E[X] = Σxp, E[Y] = Σyp]
EX <- sum(x * p); EY <- sum(y * p); c(EX, EY)
#> [1] 4.4 4.8
# Covariance   [Cov = E[XY] − E[X]E[Y]]
cv <- sum(x * y * p) - EX * EY; cv
#> [1] -1.12
# Variances   [Var = E[X²] − (E[X])²]
vx <- sum(x^2 * p) - EX^2; vy <- sum(y^2 * p) - EY^2
# Correlation   [Cor = Cov / (sd_x sd_y)]
cv / sqrt(vx * vy)
#> [1] -0.4258
```
