# ★ Exam II real-data drill

Priority before Exam II. Interactive version: Lesson 1 §7b, https://claude.ai/artifact/2wixtDbG5DgR6EBLVvAdAG

**Routine:** (1) name what you're solving for → (2) run the lm() the question describes → (3) read/compute from `b` → (4) sanity check (cor in [−1, 1]; % vs units; exp() for a logged y).

See also [[R script guide]] · [[Key tables (2.3 and 3.2)]] · [[Exam I - every question solved]]

## D2-01 — one MLR coefficient, by name

> Data: wage1. Run lm(wage ~ educ + exper + tenure). What is the coefficient on educ? Round to hundredths.

**Answer:** 0.60  
**Why:** 0.599: one more year of education raises predicted wage by about $0.60/hr, holding exper and tenure fixed.

| # | The idea | The equation |
|---|---|---|
| 1 | Run the multiple regression: add x's with + | ŵage = β̂₀ + β̂₁educ + β̂₂exper + β̂₃tenure |
| 2 | Grab one coefficient by its NAME (safer than counting positions) | β̂_educ |

```r
# Run the multiple regression: add x's with +   [ŵage = β̂₀ + β̂₁educ + β̂₂exper + β̂₃tenure]
reg <- lm(wage ~ educ + exper + tenure, data = wage1)
# Grab one coefficient by its NAME (safer than counting positions)   [β̂_educ]
reg$coefficients["educ"]
#>      educ
#> 0.5989651
```

## D2-02 — an MLR prediction (keep the intercept, plug in every x)

> Same regression. Predicted hourly wage for educ = 14, exper = 10, tenure = 5? Round to hundredths.

**Answer:** 6.58  
**Why:** b[1] + b[2]·14 + b[3]·10 + b[4]·5 = 6.58. Exactly like simple regression, just more terms (PS10 #14).

| # | The idea | The equation |
|---|---|---|
| 1 | Save the coefficients: b[1] intercept, then one per x in the order you typed them | β̂₀, β̂₁, β̂₂, β̂₃ |
| 2 | Plug in every x and keep the intercept | ŷ = β̂₀ + β̂₁(14) + β̂₂(10) + β̂₃(5) |

```r
# Save the coefficients: b[1] intercept, then one per x in the order you typed them   [β̂₀, β̂₁, β̂₂, β̂₃]
b <- reg$coefficients
# Plug in every x and keep the intercept   [ŷ = β̂₀ + β̂₁(14) + β̂₂(10) + β̂₃(5)]
b[1] + b[2]*14 + b[3]*10 + b[4]*5
#> 6.582515
```

## D2-03 — an MLR change holding the others fixed

> Same regression. Change in predicted wage when tenure rises by 3, holding educ and exper fixed? Round to hundredths.

**Answer:** 0.51  
**Why:** Held fixed means Δ = 0 for those, so only tenure's slope counts: 0.1693 × 3 = 0.51 (PS10 #15).

| # | The idea | The equation |
|---|---|---|
| 1 | Fixed x's have Δ = 0, and the intercept cancels | Δŷ = β̂₃·Δtenure |

```r
# Fixed x's have Δ = 0, and the intercept cancels   [Δŷ = β̂₃·Δtenure]
reg$coefficients["tenure"] * 3
#>    tenure
#> 0.507806
```

## D2-04 — a log-level slope as a percent

> Data: wage1. Run lm(log(wage) ~ educ). By about what percent does wage change per extra year of educ? Round to hundredths.

**Answer:** 8.27  
**Why:** Log on the LEFT → percent change in y: 100 × 0.0827 = 8.27% per year (Table 2.3, log-level).

| # | The idea | The equation |
|---|---|---|
| 1 | Put log() right inside the formula | log(wage) = β₀ + β₁educ + u |
| 2 | Log-level: multiply the slope by 100 for a percent | %Δy ≈ 100·β̂₁·Δx |

```r
# Put log() right inside the formula   [log(wage) = β₀ + β₁educ + u]
reg <- lm(log(wage) ~ educ, data = wage1)
# Log-level: multiply the slope by 100 for a percent   [%Δy ≈ 100·β̂₁·Δx]
100 * reg$coefficients[2]
#> 8.274437
```

## D2-05 — a prediction from a log(y) model, back in dollars

> Data: wage1. Run lm(log(wage) ~ educ + exper + tenure). Predicted WAGE (in dollars) for educ = 16, exper = 4, tenure = 2? Round to hundredths.

**Answer:** 6.16  
**Why:** The line predicts log(wage) = 1.817. Undo the log with exp(): exp(1.817) = $6.16 (Example 3.2).

| # | The idea | The equation |
|---|---|---|
| 1 | Run it with log(y) | log(ŵage) = β̂₀ + β̂₁educ + β̂₂exper + β̂₃tenure |
| 2 | The plug-in gives log(wage), not wage | log(ŵage) = 1.817 |
| 3 | exp() undoes log() to get dollars | ŵage = exp(1.817) |

```r
# Run it with log(y)   [log(ŵage) = β̂₀ + β̂₁educ + β̂₂exper + β̂₃tenure]
reg <- lm(log(wage) ~ educ + exper + tenure, data = wage1)
b <- reg$coefficients
# The plug-in gives log(wage), not wage   [log(ŵage) = 1.817]
b[1] + b[2]*16 + b[3]*4 + b[4]*2
#> 1.817442
# exp() undoes log() to get dollars   [ŵage = exp(1.817)]
exp(b[1] + b[2]*16 + b[3]*4 + b[4]*2)
#> 6.156092
```

## D2-06 — a log-log elasticity

> Data: bwght. Run lm(log(bwght) ~ log(faminc)). By about what percent does birth weight change when family income rises 20%? Round to hundredths.

**Answer:** 0.41  
**Why:** Log on both sides: the slope is an elasticity. %Δy = 0.0206 × 20 = 0.41% (PS10 #3). No ×100.

| # | The idea | The equation |
|---|---|---|
| 1 | Log on both sides | log(y) = β₀ + β₁log(x) + u |
| 2 | Elasticity × % change in x | %Δy ≈ β̂₁·%Δx |

```r
# Log on both sides   [log(y) = β₀ + β₁log(x) + u]
reg <- lm(log(bwght) ~ log(faminc), data = bwght)
# Elasticity × % change in x   [%Δy ≈ β̂₁·%Δx]
reg$coefficients[2] * 20
#> 0.4122057
```

## D2-07 — a level-log change

> Data: ceosal1. Run lm(salary ~ log(sales)). By how much does salary (in $000s) change when sales rise 10%? Round to hundredths.

**Answer:** 26.29  
**Why:** Log on the RIGHT only: Δy = (β̂₁/100) × %Δx = (262.9/100) × 10 = 26.29 (PS9 Q7).

| # | The idea | The equation |
|---|---|---|
| 1 | Log only on x | y = β₀ + β₁log(x) + u |
| 2 | Level-log: divide the slope by 100, times the % change | Δy ≈ (β̂₁/100)·%Δx |

```r
# Log only on x   [y = β₀ + β₁log(x) + u]
reg <- lm(salary ~ log(sales), data = ceosal1)
# Level-log: divide the slope by 100, times the % change   [Δy ≈ (β̂₁/100)·%Δx]
reg$coefficients[2] / 100 * 10
#> 26.29015
```

## D2-08 — a slope after changing units (make a new column)

> Data: ceosal1. Make roedec = roe/100 (a decimal instead of percent). What is the slope from lm(salary ~ roedec)? Round to hundredths.

**Answer:** 1850.12  
**Why:** x was divided by 100, so the slope is multiplied by 100: 18.50 × 100 = 1850.12. The intercept and R² don't change (D13).

| # | The idea | The equation |
|---|---|---|
| 1 | Create a new column inside the dataset with $ and <- | roedec = roe / 100 |
| 2 | Rerun with the new column | salary = β₀ + β₁roedec |
| 3 | Check the rule: x ÷ 100 → slope × 100 | 18.50 × 100 |

```r
# Create a new column inside the dataset with $ and <-   [roedec = roe / 100]
ceosal1$roedec <- ceosal1$roe / 100
# Rerun with the new column   [salary = β₀ + β₁roedec]
coef(lm(salary ~ roedec, data = ceosal1))[2]
#>   roedec
#> 1850.119
# Check the rule: x ÷ 100 → slope × 100   [18.50 × 100]
coef(lm(salary ~ roe, data = ceosal1))[2] * 100
#> 1850.119
```

## D2-09 — σ̂ (residual standard error)

> Data: wage1. Run lm(wage ~ educ). What is σ̂? Round to hundredths.

**Answer:** 3.38  
**Why:** σ̂ = √(SSR/(n − 2)) = 3.38, the "Residual standard error" line in summary() (PS9 Q18).

| # | The idea | The equation |
|---|---|---|
| 1 | R stores it as sigma | σ̂ = √(SSR/(n − k − 1)) |
| 2 | Same thing by hand | √(Σû² / df) |

```r
# R stores it as sigma   [σ̂ = √(SSR/(n − k − 1))]
reg <- lm(wage ~ educ, data = wage1)
summary(reg)$sigma
#> [1] 3.37839
# Same thing by hand   [√(Σû² / df)]
sqrt(sum(reg$residuals^2) / reg$df.residual)
#> [1] 3.37839
```

## D2-10 — a standard error from the output

> Data: ceosal1. Run lm(salary ~ roe). What is se(β̂₁), the standard error of the roe slope? Round to hundredths.

**Answer:** 11.12  
**Why:** The Std. Error column in the roe row: 11.12 (PS10 #10). By hand: σ̂/√SST_roe.

| # | The idea | The equation |
|---|---|---|
| 1 | Pull the Std. Error by [row name, column name] | se(β̂₁) |
| 2 | Check by hand | se = σ̂ / √SST_x |

```r
# Pull the Std. Error by [row name, column name]   [se(β̂₁)]
reg <- lm(salary ~ roe, data = ceosal1)
summary(reg)$coefficients["roe", "Std. Error"]
#> [1] 11.12325
# Check by hand   [se = σ̂ / √SST_x]
summary(reg)$sigma / sqrt(sum((ceosal1$roe - mean(ceosal1$roe))^2))
#> [1] 11.12325
```

## D2-11 — omitted-variable bias in data: simple minus multiple

> Data: wage1. Compute (educ slope from lm(wage ~ educ)) minus (educ slope from lm(wage ~ educ + exper)). Round to hundredths.

**Answer:** -0.10  
**Why:** 0.5414 − 0.6443 = −0.10 = β̂₂·δ̃₁. Leaving exper out biases the educ slope DOWN (PS10 #21, D20).

| # | The idea | The equation |
|---|---|---|
| 1 | Simple regression | β̃₁ |
| 2 | Multiple regression | β̂₁ |
| 3 | The difference is the bias piece | β̃₁ − β̂₁ = β̂₂δ̃₁ |

```r
# Simple regression   [β̃₁]
s <- coef(lm(wage ~ educ, data = wage1))["educ"]
# Multiple regression   [β̂₁]
m <- coef(lm(wage ~ educ + exper, data = wage1))["educ"]
# The difference is the bias piece   [β̃₁ − β̂₁ = β̂₂δ̃₁]
s - m
#> -0.1029128
```

## D2-12 — a change holding another x fixed (Example 3.1)

> Data: gpa1. Run lm(colGPA ~ ACT + hsGPA). Change in predicted colGPA from +10 ACT points, holding hsGPA fixed? Round to hundredths.

**Answer:** 0.09  
**Why:** 0.0094 × 10 = 0.094 → 0.09. Under a tenth of a GPA point for a huge ACT jump (D19).

| # | The idea | The equation |
|---|---|---|
| 1 | Run it | colGPA = β₀ + β₁ACT + β₂hsGPA |
| 2 | Only ACT's slope moves; hsGPA fixed means Δ = 0 | Δŷ = β̂_ACT × 10 |

```r
# Run it   [colGPA = β₀ + β₁ACT + β₂hsGPA]
reg <- lm(colGPA ~ ACT + hsGPA, data = gpa1)
# Only ACT's slope moves; hsGPA fixed means Δ = 0   [Δŷ = β̂_ACT × 10]
reg$coefficients["ACT"] * 10
#>        ACT
#> 0.09426012
```

## D2-13 — a t-statistic from the output

> Data: wage1. Run lm(log(wage) ~ educ + exper + tenure). What is the t-statistic on exper? Round to hundredths.

**Answer:** 2.39  
**Why:** t = estimate / se = 0.0041 / 0.0017 = 2.39, the "t value" column (Example 4.1, D21–D22).

| # | The idea | The equation |
|---|---|---|
| 1 | Run it and save the coefficient table | — |
| 2 | t = estimate / standard error | t = β̂ / se(β̂) |
| 3 | R prints it in the t value column | — |

```r
# Run it and save the coefficient table   [—]
reg <- lm(log(wage) ~ educ + exper + tenure, data = wage1)
s <- summary(reg)$coefficients
# t = estimate / standard error   [t = β̂ / se(β̂)]
s["exper", "Estimate"] / s["exper", "Std. Error"]
#> [1] 2.391437
# R prints it in the t value column   [—]
s["exper", "t value"]
#> [1] 2.391437
```

## D2-14 — a one-sided test decision

> Same regression. Test H0: β_exper = 0 against H1: β_exper > 0 at 5%. What do you conclude?

**Answer:** Reject H0: t = 2.39 > c = 1.65  
**Why:** One-sided 5% critical value with df = 522: c = qt(0.95, 522) = 1.65. t = 2.39 > 1.65, so reject: the return to experience is positive (D22). A small coefficient can still be significant.

| # | The idea | The equation |
|---|---|---|
| 1 | Degrees of freedom = n − k − 1 | df = 526 − 3 − 1 = 522 |
| 2 | One-sided 5% critical value | c = qt(1 − α, df) |
| 3 | Reject if t > c (for H1: β > 0) | 2.39 > 1.65 → reject |

```r
# Degrees of freedom = n − k − 1   [df = 526 − 3 − 1 = 522]
reg$df.residual
#> [1] 522
# One-sided 5% critical value   [c = qt(1 − α, df)]
qt(0.95, df = 522)
#> [1] 1.647778
# Reject if t > c (for H1: β > 0)   [2.39 > 1.65 → reject]
s["exper", "t value"] > qt(0.95, 522)
#> [1] TRUE
```
