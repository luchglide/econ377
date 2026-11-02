# Lesson 1 — Foundations

Interactive version (checks save your answers): https://claude.ai/artifact/2wixtDbG5DgR6EBLVvAdAG

Data → one variable → two variables → lines → OLS → fit → reading R output → omitted-variable bias. Every step: idea, equation, R. Exam I questions on each topic: [[Exam I - every question solved]].

## A dataset is a table
*Step by step: getting at the data*

| # | The idea | The equation |
|---|---|---|
| 1 | Load the course datasets | — |
| 2 | Each row is one observation (one CEO). Count the rows to get the sample size. | n = number of rows |
| 3 | Each column is one variable. $ pulls one column out of the dataset. | x = the roe column |
| 4 | Make your own small dataset by typing numbers into a vector | x = (2, 1, 3) |

```r
# Load the course datasets   [—]
library(wooldridge)
data("ceosal1")
# Each row is one observation (one CEO). Count the rows to get the sample size.   [n = number of rows]
nrow(ceosal1)
#> [1] 209
# Each column is one variable. $ pulls one column out of the dataset.   [x = the roe column]
ceosal1$roe
#> 14.1 10.9 23.5 ...
# Make your own small dataset by typing numbers into a vector   [x = (2, 1, 3)]
x <- c(2, 1, 3)
length(x)
#> [1] 3
```

## Center and spread: mean, variance, standard deviation
*Step by step on x = (2, 1, 3)*

| # | The idea | The equation |
|---|---|---|
| 1 | Find the center: add up, divide by how many | x̄ = Σxᵢ / n = 6/3 = 2 |
| 2 | How far is each value from the center? | xᵢ − x̄ |
| 3 | Square them, so negatives don't cancel positives | (xᵢ − x̄)² |
| 4 | Add them up and divide by n − 1: that's the sample variance | s² = Σ(xᵢ − x̄)² / (n − 1) = 2/2 = 1 |
| 5 | Take the square root to get back to the original units: the standard deviation | s = √s² = 1 |

```r
# Find the center: add up, divide by how many   [x̄ = Σxᵢ / n = 6/3 = 2]
x <- c(2, 1, 3)
mean(x)
#> [1] 2
# How far is each value from the center?   [xᵢ − x̄]
x - mean(x)
#> [1]  0 -1  1
# Square them, so negatives don't cancel positives   [(xᵢ − x̄)²]
(x - mean(x))^2
#> [1] 0 1 1
# Add them up and divide by n − 1: that's the sample variance   [s² = Σ(xᵢ − x̄)² / (n − 1) = 2/2 = 1]
sum((x - mean(x))^2) / (length(x) - 1)
#> [1] 1
var(x)          # same thing, one step
#> [1] 1
# Take the square root to get back to the original units: the standard deviation   [s = √s² = 1]
sd(x)
#> [1] 1
```

## Do they move together? Covariance and correlation
*Step by step on x = (7, 0, 8), y = (1, 1, 4)*

| # | The idea | The equation |
|---|---|---|
| 1 | Find both centers | x̄ = 5,  ȳ = 2 |
| 2 | How far is each point from each center? | xᵢ − x̄,  yᵢ − ȳ |
| 3 | Multiply each pair: a + means "move together", a − means "move opposite" | (xᵢ − x̄)(yᵢ − ȳ) |
| 4 | Add the votes and divide by n − 1: the covariance (direction) | s_xy = Σ(xᵢ − x̄)(yᵢ − ȳ) / (n − 1) = 9/2 |
| 5 | Divide by both standard deviations to strip the units: the correlation (direction AND strength, −1 to 1) | r = s_xy / (s_x · s_y) = 4.5 / (4.36 × 1.73) |

```r
# Find both centers   [x̄ = 5,  ȳ = 2]
x <- c(7, 0, 8); y <- c(1, 1, 4)
mean(x); mean(y)
#> [1] 5
#> [1] 2
# How far is each point from each center?   [xᵢ − x̄,  yᵢ − ȳ]
x - mean(x)
#> [1]  2 -5  3
y - mean(y)
#> [1] -1 -1  2
# Multiply each pair: a + means "move together", a − means "move opposite"   [(xᵢ − x̄)(yᵢ − ȳ)]
(x - mean(x)) * (y - mean(y))
#> [1] -2  5  6
# Add the votes and divide by n − 1: the covariance (direction)   [s_xy = Σ(xᵢ − x̄)(yᵢ − ȳ) / (n − 1) = 9/2]
sum((x - mean(x)) * (y - mean(y))) / (length(x) - 1)
#> [1] 4.5
cov(x, y)       # same thing
#> [1] 4.5
# Divide by both standard deviations to strip the units: the correlation (direction AND strength, −1 to 1)   [r = s_xy / (s_x · s_y) = 4.5 / (4.36 × 1.73)]
cov(x, y) / (sd(x) * sd(y))
#> [1] 0.5960396
cor(x, y)       # same thing
#> [1] 0.5960396
```

## Predictions keep the intercept. Changes drop it.
*Step by step on ŷ = 3 + 2x*

| # | The idea | The equation |
|---|---|---|
| 1 | The intercept: y when x = 0 | β₀ = 3 |
| 2 | The slope: how much y moves when x goes up by 1 | β₁ = 2 |
| 3 | A PREDICTION plugs in x and KEEPS the intercept | ŷ = β₀ + β₁x = 3 + 2(4) |
| 4 | A CHANGE uses only the slope: the intercept is in both before and after, so it cancels | Δŷ = β₁Δx = 2(7 − 4) |
| 5 | With two x's, add each slope × its change. "Falls" = negative; "held fixed" = 0 | Δŷ = β₁Δx₁ + β₂Δx₂ |
| 6 | Percent change divides by the OLD value | %Δ = 100 × (new − old) / old |
| 7 | Percentage-point change is just the difference | new − old |

```r
# The intercept: y when x = 0   [β₀ = 3]
b0 <- 3
# The slope: how much y moves when x goes up by 1   [β₁ = 2]
b1 <- 2
# A PREDICTION plugs in x and KEEPS the intercept   [ŷ = β₀ + β₁x = 3 + 2(4)]
b0 + b1 * 4
#> [1] 11
# A CHANGE uses only the slope: the intercept is in both before and after, so it cancels   [Δŷ = β₁Δx = 2(7 − 4)]
b1 * (7 - 4)
#> [1] 6
# With two x's, add each slope × its change. "Falls" = negative; "held fixed" = 0   [Δŷ = β₁Δx₁ + β₂Δx₂]
-9.8 * (-2) + 0.03 * 300
#> [1] 28.6
# Percent change divides by the OLD value   [%Δ = 100 × (new − old) / old]
100 * (4 - 5) / 5
#> [1] -20
# Percentage-point change is just the difference   [new − old]
4 - 5
#> [1] -1
```

## The regression line, residuals, and why it's "least squares"
*Step by step on x = (1, 2, 3), y = (2, 2, 5)*

| # | The idea | The equation |
|---|---|---|
| 1 | Slope: how x and y move together, scaled by how much x moves | β̂₁ = cov(x, y) / var(x) |
| 2 | Intercept: forces the line through the point (x̄, ȳ) | β̂₀ = ȳ − β̂₁x̄ |
| 3 | R does both in one step. This is what you'll use on the exam | ŷ = β̂₀ + β̂₁x |
| 4 | Fitted value: the line's prediction at each xᵢ | ŷᵢ = β̂₀ + β̂₁xᵢ |
| 5 | Residual: actual minus fitted (+ = under-predicted) | ûᵢ = yᵢ − ŷᵢ |
| 6 | Property 1: residuals add up to zero | Σûᵢ = 0 |
| 7 | Property 2: x and the residuals don't move together | Σxᵢûᵢ = 0 |
| 8 | Property 3: the means sit on the line | ȳ = β̂₀ + β̂₁x̄ |

```r
# Slope: how x and y move together, scaled by how much x moves   [β̂₁ = cov(x, y) / var(x)]
x <- c(1, 2, 3); y <- c(2, 2, 5)
b1 <- cov(x, y) / var(x); b1
#> [1] 1.5
# Intercept: forces the line through the point (x̄, ȳ)   [β̂₀ = ȳ − β̂₁x̄]
b0 <- mean(y) - b1 * mean(x); b0
#> [1] 0
# R does both in one step. This is what you'll use on the exam   [ŷ = β̂₀ + β̂₁x]
reg <- lm(y ~ x)
reg$coefficients
#> (Intercept)   x
#>         0.0 1.5
# Fitted value: the line's prediction at each xᵢ   [ŷᵢ = β̂₀ + β̂₁xᵢ]
reg$fitted.values
#> [1] 1.5 3.0 4.5
# Residual: actual minus fitted (+ = under-predicted)   [ûᵢ = yᵢ − ŷᵢ]
reg$residuals
#> [1]  0.5 -1.0  0.5
# Property 1: residuals add up to zero   [Σûᵢ = 0]
sum(reg$residuals)
#> [1] 0
# Property 2: x and the residuals don't move together   [Σxᵢûᵢ = 0]
sum(x * reg$residuals)
#> [1] 0
# Property 3: the means sit on the line   [ȳ = β̂₀ + β̂₁x̄]
b0 + b1 * mean(x)
#> [1] 3      # = mean(y)
```

## How much does the line explain? SST, SSE, SSR, R²
*Step by step, same data: x = (1, 2, 3), y = (2, 2, 5), reg <- lm(y ~ x)*

| # | The idea | The equation |
|---|---|---|
| 1 | Total variation: how far y is from its own mean, squared and added | SST = Σ(yᵢ − ȳ)² |
| 2 | Explained part: how far the line's predictions move away from ȳ | SSE = Σ(ŷᵢ − ȳ)² |
| 3 | Unexplained part: the squared residuals | SSR = Σûᵢ² |
| 4 | The pieces always add up | SST = SSE + SSR |
| 5 | R²: the share of y's variation the line explains | R² = SSE/SST = 1 − SSR/SST |
| 6 | Shortcut when they give you the sample variance of y | SST = (n − 1) · s²_y |

```r
# Total variation: how far y is from its own mean, squared and added   [SST = Σ(yᵢ − ȳ)²]
sum((y - mean(y))^2)
#> [1] 6
# Explained part: how far the line's predictions move away from ȳ   [SSE = Σ(ŷᵢ − ȳ)²]
sum((reg$fitted.values - mean(y))^2)
#> [1] 4.5
# Unexplained part: the squared residuals   [SSR = Σûᵢ²]
sum(reg$residuals^2)
#> [1] 1.5
# The pieces always add up   [SST = SSE + SSR]
4.5 + 1.5
#> [1] 6
# R²: the share of y's variation the line explains   [R² = SSE/SST = 1 − SSR/SST]
4.5 / 6
#> [1] 0.75
summary(reg)$r.squared
#> [1] 0.75
# Shortcut when they give you the sample variance of y   [SST = (n − 1) · s²_y]
(length(y) - 1) * var(y)
#> [1] 6
```

## Which number answers the question?
*Where each answer lives (reg <- lm(wage ~ tenure, data = wage1))*

| # | The idea | The equation |
|---|---|---|
| 1 | Sample size: rows of THIS dataset | n |
| 2 | Intercept: the (Intercept) row | β̂₀ |
| 3 | Slope: the row named after the x variable | β̂₁ |
| 4 | Prediction at tenure = 10: keep the intercept | ŷ = β̂₀ + β̂₁(10) |
| 5 | Change from 3 to 16 years: slope × change, no intercept | Δŷ = β̂₁ × (16 − 3) |
| 6 | % of variation explained | 100 × R² |
| 7 | Standard error of the slope (next lesson) | se(β̂₁) |

```r
# Sample size: rows of THIS dataset   [n]
nrow(wage1)
#> [1] 526
# Intercept: the (Intercept) row   [β̂₀]
b <- reg$coefficients
b[1]
#> 4.99090
# Slope: the row named after the x variable   [β̂₁]
b[2]
#> 0.17733
# Prediction at tenure = 10: keep the intercept   [ŷ = β̂₀ + β̂₁(10)]
b[1] + b[2] * 10
#> 6.764196
# Change from 3 to 16 years: slope × change, no intercept   [Δŷ = β̂₁ × (16 − 3)]
b[2] * (16 - 3)
#> 2.305252
# % of variation explained   [100 × R²]
100 * summary(reg)$r.squared
#> [1] 12.03324
# Standard error of the slope (next lesson)   [se(β̂₁)]
summary(reg)$coefficients[2, 2]
#> [1] 0.02094486
```

## Adding a variable can change a slope: omitted-variable bias
*Step by step on gpa1 (x₁ = ACT, x₂ = hsGPA)*

| # | The idea | The equation |
|---|---|---|
| 1 | Simple regression: ACT alone (hsGPA hiding in u) | β̃₁ |
| 2 | Multiple regression: hold hsGPA fixed | β̂₁ (ACT),  β̂₂ (hsGPA) |
| 3 | How the omitted variable moves with the included one | δ̃₁ = slope of x₂ on x₁ |
| 4 | Simple = multiple + (effect of omitted) × (its link to x₁) | β̃₁ = β̂₁ + β̂₂ · δ̃₁ |
| 5 | Direction: sign of β₂ times sign of the correlation | sign(β₂) × sign(corr(x₁, x₂)) |

```r
# Simple regression: ACT alone (hsGPA hiding in u)   [β̃₁]
coef(lm(colGPA ~ ACT, data = gpa1))[2]
#>   ACT
#> 0.02706
# Multiple regression: hold hsGPA fixed   [β̂₁ (ACT),  β̂₂ (hsGPA)]
coef(lm(colGPA ~ ACT + hsGPA, data = gpa1))
#> (Intercept)    ACT  hsGPA
#>      1.2863 0.0094 0.4535
# How the omitted variable moves with the included one   [δ̃₁ = slope of x₂ on x₁]
coef(lm(hsGPA ~ ACT, data = gpa1))[2]
#>     ACT
#> 0.03890
# Simple = multiple + (effect of omitted) × (its link to x₁)   [β̃₁ = β̂₁ + β̂₂ · δ̃₁]
0.0094 + 0.4535 * 0.0389
#> [1] 0.02704
# Direction: sign of β₂ times sign of the correlation   [sign(β₂) × sign(corr(x₁, x₂))]
cor(gpa1$ACT, gpa1$hsGPA)
#> [1] 0.3458   # (+)(+) → biased UP
```
