# Lesson 2 — Unbiasedness, omitted-variable bias, standard errors

Interactive version (checks save your answers): https://claude.ai/artifact/PmkGSC2TyoCZdppG49vQQZ

Covers D15, D16, D20 (Nov 2). See also [[Key tables (2.3 and 3.2)]].

## The truth is fixed. Our estimate moves.
*Step by step: truth vs. estimate*

| # | The idea | The equation |
|---|---|---|
| 1 | The truth for the whole population. Fixed, but never seen | y = β₀ + β₁x + u |
| 2 | Our estimate from the one sample we have | ŷ = β̂₀ + β̂₁x |
| 3 | The residual is our stand-in for the unseen error | ûᵢ = yᵢ − ŷᵢ  (estimates uᵢ) |
| 4 | A different sample gives a different estimate: β̂₁ is random | β̂₁ changes; β₁ doesn't |

```r
# The truth for the whole population. Fixed, but never seen   [y = β₀ + β₁x + u]
# no R code: we never observe β₀, β₁ or u
# Our estimate from the one sample we have   [ŷ = β̂₀ + β̂₁x]
reg <- lm(wage ~ educ, data = wage1)
reg$coefficients
#> (Intercept)   educ
#>     -0.9049 0.5414
# The residual is our stand-in for the unseen error   [ûᵢ = yᵢ − ŷᵢ  (estimates uᵢ)]
head(reg$residuals)
#> -1.95  -2.35  -2.05 ...
# A different sample gives a different estimate: β̂₁ is random   [β̂₁ changes; β₁ doesn't]
sub <- wage1[sample(nrow(wage1), 100), ]
lm(wage ~ educ, data = sub)$coefficients[2]
#> a slightly different number every run
```

## When is OLS right on average?
*Step by step: what the simulator does, in R*

| # | The idea | The equation |
|---|---|---|
| 1 | Draw one sample from a population where the true slope is 2 | y = 1 + 2x + u,  u ~ N(0, 3²) |
| 2 | Estimate the slope from that sample | β̂₁ |
| 3 | Repeat 1,000 times and average the estimates | E[β̂₁] ≈ average of many β̂₁ |
| 4 | Hide something correlated with x inside u: E[u | x] = 0 fails | u = 0.5x + noise |

```r
# Draw one sample from a population where the true slope is 2   [y = 1 + 2x + u,  u ~ N(0, 3²)]
x <- runif(20, 0, 10)
y <- 1 + 2 * x + rnorm(20, 0, 3)
# Estimate the slope from that sample   [β̂₁]
coef(lm(y ~ x))[2]
#> around 2, but not exactly
# Repeat 1,000 times and average the estimates   [E[β̂₁] ≈ average of many β̂₁]
b <- replicate(1000, {
  x <- runif(20, 0, 10); y <- 1 + 2*x + rnorm(20, 0, 3)
  coef(lm(y ~ x))[2] })
mean(b)
#> [1] 1.998   # ≈ 2: UNBIASED
# Hide something correlated with x inside u: E[u | x] = 0 fails   [u = 0.5x + noise]
b <- replicate(1000, {
  x <- runif(20, 0, 10); y <- 1 + 2*x + 0.5*x + rnorm(20, 0, 3)
  coef(lm(y ~ x))[2] })
mean(b)
#> [1] 2.498   # ≈ 2.5: BIASED up
```

## Which way is the estimate pushed?
*Step by step: Table 3.2 in R (x₁ = educ, omitted x₂ = exper)*

| # | The idea | The equation |
|---|---|---|
| 1 | Does the omitted variable affect y? Look at its sign in the multiple regression | β̂₂ (exper) |
| 2 | Is it correlated with the included x? Look at the sign | corr(x₁, x₂) |
| 3 | Read the table: (+) × (−) = downward | sign(β₂) × sign(corr) |
| 4 | The size of the bias: effect × link | bias = β̂₂ · δ̃₁ |
| 5 | Check: simple slope = multiple slope + bias | β̃₁ = β̂₁ + β̂₂δ̃₁ |

```r
# Does the omitted variable affect y? Look at its sign in the multiple regression   [β̂₂ (exper)]
coef(lm(wage ~ educ + exper, data = wage1))["exper"]
#>  exper
#> 0.0701    # positive
# Is it correlated with the included x? Look at the sign   [corr(x₁, x₂)]
cor(wage1$educ, wage1$exper)
#> [1] -0.2995   # negative
# Read the table: (+) × (−) = downward   [sign(β₂) × sign(corr)]
# + times -  ->  biased DOWN
# The size of the bias: effect × link   [bias = β̂₂ · δ̃₁]
delta1 <- coef(lm(exper ~ educ, data = wage1))[2]
0.0701 * delta1
#> -0.1029
# Check: simple slope = multiple slope + bias   [β̃₁ = β̂₁ + β̂₂δ̃₁]
0.6443 + (-0.1029)
#> [1] 0.5414
coef(lm(wage ~ educ, data = wage1))[2]
#>   educ
#> 0.5414
```

## How wide is the pile? Variance and standard errors
*Step by step: σ = 4, n = 26, S²_x = 4 (D16), then real data*

| # | The idea | The equation |
|---|---|---|
| 1 | Total spread in x. More data or more spread → bigger | SST_x = (n − 1) · S²_x = Σ(xᵢ − x̄)² |
| 2 | Variance of the slope: noise on top, spread of x on the bottom | Var(β̂₁) = σ² / SST_x |
| 3 | Standard deviation: the square root, in the slope's units | sd(β̂₁) = σ / √SST_x |
| 4 | We don't know σ, so estimate it from the residuals | σ̂ = √(SSR / (n − k − 1)) |
| 5 | Plug σ̂ into the sd formula: that's the standard error | se(β̂₁) = σ̂ / √SST_x |
| 6 | R prints the same number in the Std. Error column | se(β̂₁) |

```r
# Total spread in x. More data or more spread → bigger   [SST_x = (n − 1) · S²_x = Σ(xᵢ − x̄)²]
SST <- (26 - 1) * 4; SST
#> [1] 100
# from raw data: sum((x - mean(x))^2)
# Variance of the slope: noise on top, spread of x on the bottom   [Var(β̂₁) = σ² / SST_x]
4^2 / SST
#> [1] 0.16
# Standard deviation: the square root, in the slope's units   [sd(β̂₁) = σ / √SST_x]
4 / sqrt(SST)
#> [1] 0.4
# We don't know σ, so estimate it from the residuals   [σ̂ = √(SSR / (n − k − 1))]
reg <- lm(wage ~ educ, data = wage1)
sqrt(sum(reg$residuals^2) / reg$df.residual)
#> [1] 3.378
summary(reg)$sigma        # same thing
# Plug σ̂ into the sd formula: that's the standard error   [se(β̂₁) = σ̂ / √SST_x]
SSTx <- sum((wage1$educ - mean(wage1$educ))^2)
summary(reg)$sigma / sqrt(SSTx)
#> [1] 0.05325
# R prints the same number in the Std. Error column   [se(β̂₁)]
summary(reg)$coefficients["educ", "Std. Error"]
#> [1] 0.05325
```

## How wide is the pile? Variance and standard errors
*Step by step: Theorem 3.2 in multiple regression (wage on educ + exper)*

| # | The idea | The equation |
|---|---|---|
| 1 | How much does educ overlap with the other x's? Regress it on them and take the R² | Rⱼ² = R² of xⱼ on the other x's |
| 2 | The variance inflation factor: how much the overlap blows up the variance (1 = none) | VIF = 1 / (1 − Rⱼ²) |
| 3 | The MLR standard error: same formula, with the (1 − Rⱼ²) on the bottom | se(β̂ⱼ) = σ̂ / √[SSTⱼ(1 − Rⱼ²)] |
| 4 | R prints the same number | se(β̂_educ) |

```r
# How much does educ overlap with the other x's? Regress it on them and take the R²   [Rⱼ² = R² of xⱼ on the other x's]
Rj2 <- summary(lm(educ ~ exper, data = wage1))$r.squared; Rj2
#> [1] 0.0897
# The variance inflation factor: how much the overlap blows up the variance (1 = none)   [VIF = 1 / (1 − Rⱼ²)]
1 / (1 - Rj2)
#> [1] 1.0986   # small: educ and exper barely overlap
# The MLR standard error: same formula, with the (1 − Rⱼ²) on the bottom   [se(β̂ⱼ) = σ̂ / √[SSTⱼ(1 − Rⱼ²)]]
reg <- lm(wage ~ educ + exper, data = wage1)
SSTj <- sum((wage1$educ - mean(wage1$educ))^2)
summary(reg)$sigma / sqrt(SSTj * (1 - Rj2))
#> [1] 0.05381
# R prints the same number   [se(β̂_educ)]
summary(reg)$coefficients["educ", "Std. Error"]
#> [1] 0.05381
```
