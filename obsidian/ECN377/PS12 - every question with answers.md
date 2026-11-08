# Problem Set 12 (optional practice): every question verbatim, with answers

Submitted Nov 8: **15 / 15**. Questions are copied word for word from Canvas; math is shown as LaTeX.

> Canvas description: *"Exam II (Wed 11/11) will have about five questions that closely follow problems 2, 4, 6, 9 and 12."* Those five are marked ⭐.

exam2.R blocks: given numbers → **[S2]**; by hand on data → **[D14]**; concepts → **[K18]**.

## Intro
Problem Set 12 is optional and is worth half the usual extra-credit points. It is practice for the upcoming Exam II. It walks through the standard error of a multiple-regression coefficient, \(\mathrm{se}(\hat\beta_j)=\hat\sigma/\sqrt{\mathrm{SST}_j\,(1-R_j^2)}\), one piece at a time: first with given numbers (problems 1-7), then by hand in R (problems 8-12), then the quick way with summary(reg) (problems 13-15). Exam II (Wed 11/11) will have about five questions that closely follow problems 2, 4, 6, 9 and 12. Round every numeric answer to the hundredths place.

## Problem 1
In the formula \(\mathrm{se}(\hat\beta_j)=\hat\sigma/\sqrt{\mathrm{SST}_j\,(1-R_j^2)}\), what is \(X_j\)?
Hint: \(j\) indexes the coefficient whose standard error you want.
- The dependent variable \(Y\).
- The residuals from the regression.
- The independent variable whose coefficient \(\hat\beta_j\) we want the standard error of.
- Whichever independent variable has the largest coefficient.

**Answer:** The independent variable whose coefficient β̂ⱼ we want the standard error of.

## Problem 2 ⭐ (exam)
In \(\mathrm{wage}=\beta_0+\beta_1\,\mathrm{educ}+\beta_2\,\mathrm{exper}+\beta_3\,\mathrm{tenure}+U\), you want \(\mathrm{se}(\hat\beta_2)\), the standard error of the exper coefficient. Which regression gives \(R_j^2\)?
Hint: \(R_j^2\) measures how well the other independent variables explain \(X_j\). \(Y\) is not involved.
- The regression of wage on exper alone: lm(wage ~ exper)
- The regression of exper on wage: lm(exper ~ wage)
- The regression of exper on educ and tenure: lm(exper ~ educ + tenure)
- The regression of wage on educ, exper and tenure (its own \(R^2\))

**Answer:** The regression of exper on educ and tenure: lm(exper ~ educ + tenure)
Script: [K18]

## Problem 3
The standard error of the regression is \(\hat\sigma=\sqrt{\mathrm{SSR}/(n-K-1)}\). What does \(\hat\sigma\) estimate?
Hint: it is built from the residuals, which stand in for the errors.
- The standard deviation of \(\hat\beta_j\)
- The \(R^2\) of the regression
- \(\sigma\), the standard deviation of the error \(U\)
- The standard deviation of \(Y\)

**Answer:** σ, the standard deviation of the error U
Script: [K18]

## Problem 4 ⭐ (exam)
A multiple regression with \(K=2\) independent variables, estimated on \(n=42\) observations, has \(\mathrm{SSR}=2,857\). Find the standard error of the regression, \(\hat\sigma\). (round to the hundredths)
Hint: \(\mathrm{df}=n-K-1\), then \(\hat\sigma=\sqrt{\mathrm{SSR}/\mathrm{df}}\).
- 

**Answer:** 8.56
```r
sqrt(2857 / (42 - 2 - 1))   # [S2]: s2_SSR = 2857, s2_n = 42, s2_k = 2
```

## Problem 5
In a sample of \(n=62\) observations, the independent variable \(X_j\) has sample standard deviation \(S_{X_j}=3.1\). Find \(\mathrm{SST}_j\). (round to the hundredths)
Hint: \(\mathrm{SST}_j=\sum_i(X_{ij}-\bar X_j)^2=(n-1)\,S_{X_j}^2\). Square the standard deviation.
- 

**Answer:** 586.21
```r
(62 - 1) * 3.1^2            # [S2]: s2_n = 62, s2_SX = 3.1 (it squares it)
```

## Problem 6 ⭐ (exam)
A multiple regression has \(\hat\sigma=5.1\). For the independent variable \(X_j\), \(\mathrm{SST}_j=363\), and regressing \(X_j\) on the other independent variables gives \(R_j^2=0.74\). Find \(\mathrm{se}(\hat\beta_j)\). (round to the hundredths)
Hint: \(\mathrm{se}(\hat\beta_j)=\hat\sigma/\sqrt{\mathrm{SST}_j\,(1-R_j^2)}\). Note the \(1-R_j^2\).
- 

**Answer:** 0.52
```r
5.1 / sqrt(363 * (1 - 0.74))  # [S2]: s2_sigma = 5.1, s2_SSTx = 363, s2_Rj2 = 0.74
```

## Problem 7
Holding \(\hat\sigma\) and \(\mathrm{SST}_j\) fixed, what happens to \(\mathrm{se}(\hat\beta_j)\) as \(R_j^2\) gets close to 1 (that is, as \(X_j\) becomes nearly a linear function of the other independent variables)?
Hint: look at \(1-R_j^2\) in the denominator.
- It approaches \(\hat\sigma\).
- It shrinks toward 0.
- It does not change.
- It grows without bound (multicollinearity).

**Answer:** It grows without bound (multicollinearity).
Script: [K18]

## Problem 8
Data: hprice1 (price = house price in thousands of dollars; sqrft = size of the house in square feet; bdrms = number of bedrooms; lotsize = size of the lot in square feet). Run reg <- lm(price ~ sqrft + bdrms + lotsize, data = hprice1). You will find the standard error of the bdrms coefficient by hand, so here \(X_j\) = bdrms. First, how many degrees of freedom does the regression have, \(\mathrm{df}=n-K-1\)?
Hint: the number of observations is nrow(hprice1). Count \(K\), the independent variables (not the intercept).

**Answer:** 84
```r
reg <- lm(price ~ sqrft + bdrms + lotsize, data = hprice1)
reg$df.residual          # [D14]
```

## Problem 9 ⭐ (exam)
Data: hprice1 (price = house price in thousands of dollars; sqrft = size of the house in square feet; bdrms = number of bedrooms; lotsize = size of the lot in square feet). Using the same regression reg, compute the standard error of the regression, \(\hat\sigma=\sqrt{\mathrm{SSR}/\mathrm{df}}\). (round to the hundredths)
Hint: SSR <- sum(reg$residuals^2), then sigma_hat <- sqrt(SSR / 84).

**Answer:** 59.83
```r
sqrt(sum(reg$residuals^2) / 84)   # [D14] sigma-hat line
```

## Problem 10
Data: hprice1 (price = house price in thousands of dollars; sqrft = size of the house in square feet; bdrms = number of bedrooms; lotsize = size of the lot in square feet). Compute \(\mathrm{SST}_j\) for \(X_j\) = bdrms, the total variation of bdrms around its mean. (round to the hundredths)
Hint: SST_j <- sum((hprice1$bdrms - mean(hprice1$bdrms))^2).

**Answer:** 61.59
```r
sum((hprice1$bdrms - mean(hprice1$bdrms))^2)   # [D14] SST_j line
```

## Problem 11
Data: hprice1 (price = house price in thousands of dollars; sqrft = size of the house in square feet; bdrms = number of bedrooms; lotsize = size of the lot in square feet). Compute \(R_j^2\) for \(X_j\) = bdrms: the \(R^2\) from regressing bdrms on the other independent variables. (round to the hundredths)
Hint: R2_j <- summary(lm(bdrms ~ sqrft + lotsize, data = hprice1))$r.squared. The dependent variable price is not in this regression.

**Answer:** 0.28
```r
summary(lm(bdrms ~ sqrft + lotsize, data = hprice1))$r.squared   # [D14] R_j^2 line
```

## Problem 12 ⭐ (exam)
Data: hprice1 (price = house price in thousands of dollars; sqrft = size of the house in square feet; bdrms = number of bedrooms; lotsize = size of the lot in square feet). Put the pieces together: compute \(\mathrm{se}(\hat\beta_j)=\hat\sigma/\sqrt{\mathrm{SST}_j\,(1-R_j^2)}\) for the bdrms coefficient. (round to the hundredths)
Hint: use the unrounded objects from problems 9-11: sigma_hat / sqrt(SST_j * (1 - R2_j)).

**Answer:** 9.01
```r
sigma_hat / sqrt(SST_j * (1 - R2_j))   # [D14] se line
```

## Problem 13
Data: hprice1 (price = house price in thousands of dollars; sqrft = size of the house in square feet; bdrms = number of bedrooms; lotsize = size of the lot in square feet). Now the quick way. In summary(reg)$coefficients, the "Std. Error" column holds every standard error. What is the standard error of the bdrms coefficient there? (It should match problem 12.) (round to the hundredths)
Hint: summary(reg)$coefficients is a table with one row per coefficient (the intercept is row 1, then sqrft, bdrms, lotsize) and four columns (Estimate, Std. Error, and two we will use with t-tests). Pull out one entry with [row, column]: bdrms is row 3 and Std. Error is column 2, so summary(reg)$coefficients[3, 2].

**Answer:** 9.01
```r
summary(reg)$coefficients[3, 2]   # bdrms row, Std. Error column
```

## Problem 14
Print summary(reg). Near the bottom is a line "Residual standard error: ... on 84 degrees of freedom". Which of your answers does it match?
Hint: compare the number with problems 8 and 9.
- None of them
- Problem 9 (\(\hat\sigma\)), and its degrees of freedom match problem 8
- Problem 12 (the standard error of the bdrms coefficient)
- Problem 10 (\(\mathrm{SST}_j\))

**Answer:** Problem 9 (σ̂), and its degrees of freedom match problem 8
Script: [K18]

## Problem 15
A warning about missing data. Some datasets have missing values (NA). lm() silently drops every row with an NA in any variable of the regression. Suppose \(Y\) (or another independent variable) has missing values but \(X_j\) does not, and you compute \(\mathrm{SST}_j\) by hand from all the rows of \(X_j\). What happens?
Hint: which rows does the regression use, and which rows does your \(\mathrm{SST}_j\) use? The same issue affects sample means and standard deviations.
- Your hand-computed standard error can differ from summary(reg), because \(\mathrm{SST}_j\) uses rows the regression dropped. Compute every piece on the same rows the regression used.
- Only \(R^2\) is affected, never the standard errors.
- R stops with an error, so you notice right away.
- Nothing: missing values never change any statistic.

**Answer:** Your hand-computed standard error can differ from summary(reg), because SST_j uses rows the regression dropped. Compute every piece on the same rows the regression used.
Script: [K18]
