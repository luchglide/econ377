## ECN 377 Midterm I property sheet. Days 1-12.
## Same content as exam1-properties.html. This file is comments only.
## Ctrl+F a word. The runnable version, with # SET lines, is exam1.R.
## Numbers here are the toys in exam1.R. Round exam answers to hundredths (5.90).
## Day 13 (Monday) is not on this sheet.

## ---- Before any arithmetic ----
## Sample list (no probabilities): mean(), var(), sd(), cov(), cor().
##   Variance, sd, and covariance divide by n-1. Do not divide again.
## Probability table: sum(x * p). Never var() or cov() on a table.
##   Those ignore p. Check that p adds to 1.
## A CHANGE ignores the intercept. A PREDICTION keeps it.
## E[X^2] squares each value, then weights. (E[X])^2 squares the mean.
## "That same sample" can still be a new list. Use THIS question's numbers.
## A fraction like 7/10 is 0.7. Type 7/10.

## ---- Mean, percent, ceteris paribus ----
## Mean = sum / n. mean(x) equals sum(x)/length(x).
##   Toy 0,0,6,2,1 -> 1.80. Sum 90 and n 5 -> 18.00.
## Percent change = 100 * (new - old) / old. $20 to $25 -> 25.00.
## Percentage points = new - old.
##   4% to 6% is 2 points and a 50% increase.
##   3% to 5% is 2 points and 66.67%.
## Ceteris paribus = holding the other factors fixed.
##   In y = b0 + b1*X1 + b2*X2, b1 is the effect of X1 holding X2 fixed.
##   b0 is predicted y when every x is 0.
## Correlation is not causation. Ice cream and drownings: summer drives both.
## A strong correlation does not prove X causes Y.

## ---- A change vs a prediction ----
## delta y = b1*dX1 + b2*dX2 + b3*dX3. Intercept cancels.
## "Rises by 2" is a change of 2, not a level of 2.
## Toy: quantity = 120 - 9.8*price + 0.03*income.
##   Price +$1, income fixed -> -9.80.
##   Price -$2 and income +$300 -> 28.60.
## Slope from a rise over a run: b1 = dy / dx. 27 over 3 -> 9.00.
## Prediction: yhat = b0 + b1*x. b0=1, b1=7, x=1 -> 8.00.
## Line they already wrote: 15/10 + (3/10)*hsGPA at 36/10 -> 2.58.
##   Read their fractions. Do not memorize 0.5.

## ---- Sample spread (lists) ----
## var(x) = sum((x-xbar)^2) / (n-1). x=(3,4,5) -> 1.00.
## sd(x) = sqrt(var(x)). x=(9,2,2) -> 4.04. Given Var=10, sd -> 3.16.
## cov(x,y) divides by n-1. Rise and fall together means positive.
##   x=(2,2,0), y=(4,4,2) -> 1.33.
## cor = cov / (sdx * sdy) = cor(x,y). Between -1 and 1. No units.
##   4/(3*2) -> 0.67.

## ---- Expectation and population moments ----
## E[g(X)] = sum(g(x) * p). E[c] = c.
## E[aX+b] = a*E[X] + b.
## E[aX+bY-c] = a*EX + b*EY - c.
##   E[4X+5Y-3] with EX=2, EY=3 -> 20.00.
## E[X^2] = sum(x^2 * p).
##   Values 1,2,3 with p 0.2, 0.5, 0.3 -> E[X] 2.10, E[X^2] 4.90.
## Var(X) = E[X^2] - (E[X])^2.
##   E[X]=4, E[X^2]=83 -> 67.00. Same table -> Var 0.49, sd 0.70.
## Var(aX+b) = a^2 * Var(X). The added constant does nothing.
##   a=2, Var=4 -> 16.00.
## Cov(X,Y) = E[XY] - E[X]*E[Y]. E[XY] = sum(x*y*p).
##   Given 17, 1, 3 -> 14.00.
##   Pairs (1,2),(0,2),(0,1) each 1/3 -> 0.11.
## Joint table, asked only for E[X]: ignore y.
##   x=1,5,1 with p 0.2, 0.3, 0.5 -> 2.20.
## Cov(a1*X+b1, a2*Y+b2) = a1*a2*Cov. Constants drop.
##   Cov=-1, a1=3, a2=5 -> -15.00.
## Cor = Cov / (sdX * sdY). Unitless, between -1 and 1. 3/(3*3) -> 0.33.
## Independent means Cov = 0, and Var(X+Y) = Var(X)+Var(Y). 6 and 6 -> 12.00.
## Always: Var(aX+bY) = a^2*VarX + b^2*VarY + 2*a*b*Cov.
##   a=b=3, vars 6 and 5, Cov 0 -> 99.00.
## A 0/1 variable has X^2 = X, so E[X^2] = E[X].

## ---- Conditional mean and variance ----
## E[Y|X=x] = average of Y in the subgroup where X = x.
## List, no probabilities: mean(y). 1,3,5,10 -> 4.75.
## With probabilities: sum(y*p). Three 9s with 0.2, 0.3, 0.5 -> 9.00.
## E[aY+b | X=x] = a*(conditional mean) + b. Mean 2, a=3, b=9 -> 15.00.
## E[X|X] = X.
## Conditional variance is the spread inside that same subgroup.
##   A list uses var(y) (sample, n-1). A table uses E[Y^2]-(E[Y])^2.

## ---- The regression model ----
## Y = b0 + b1*X + U.
## Y is dependent (wage, colGPA). X is explanatory (educ, hsGPA).
## U is every other factor that affects Y. Not the slope. Not the average of Y.
## b1 is the ceteris paribus effect of X on Y.
##   Units of Y per unit of X. Any size. Not the correlation.
## E[U|X]=0 means the average of U does not depend on X. People still differ.
##   Then E[Y|X=x] = b0 + b1*x. Do not leave +U in the conditional mean.
## b0 + b1*X is the part of Y explained by X.
## Hats are estimates: b0 and b1 are population constants and you only see a sample.

## ---- OLS ----
## Slope b1 = cov(x,y) / var(x).
##   Covariance on top, variance of X on the bottom.
##   n-1 cancels, so this matches the sum formula. Negative is allowed.
##   cov=4, var=7 -> 0.57. x=(1,2,3), y=(2,2,5) -> 1.50.
## Population slope from a table is Cov/Var. Not cov()/var().
## Intercept, after the slope: b0 = ybar - b1*xbar.
##   ybar 10, xbar 8, slope 7/10 -> 4.40. The 1,2,3 toy intercept is 0.00.
## lm(y ~ x): coefficient [1] is the intercept, [2] is the slope.
##   Fitted values fitted(). Residuals resid().
## Fitted value = prediction = b0 + b1*x. Not the actual y, not U.
## Residual = actual - fitted.
##   Positive residual: actual is above the line. OLS under-predicted.
##   Negative residual: OLS over-predicted.
## Toy line -0.90 + 0.54*x at x=12, actual y=9:
##   fitted 5.58, residual 3.42, under.
## Predict the 1,2,3 line at x=4 -> 6.00.

## ---- Three OLS properties (any sample) ----
## 1. Residuals sum to 0. Not SSR, not 1.
## 2. X and the residuals are uncorrelated. sum(x * uhat) is 0.
## 3. (xbar, ybar) lies on the line. mean(y) = b0 + b1*mean(x).

## ---- R^2 and units ----
## SST = total variation = sum((y-ybar)^2).
## SSR = unexplained = sum((y-yhat)^2).
## SSE = explained = SST - SSR.
## SST = SSE + SSR.
## R^2 = SSE / SST = 1 - SSR/SST.
## Unexplained fraction = SSR / SST.
## SST 200, SSR 150 -> SSE 50.00, R^2 0.25, unexplained 0.75.
## R^2 is the fraction of sample variation in Y explained by X.
##   Near 0 is common and not automatically a bad model.
##   The slope can still be nonzero.
## Multiply Y by c: intercept and slope both multiply by c. R^2 unchanged.
##   Salary in dollars = 1000 times salary in thousands.
## Multiply X by c: slope divides by c. Intercept unchanged. R^2 unchanged.
##   Roe as a decimal is roe/100, so the slope multiplies by 100.

## ---- Words, data, log ----
## Population: the whole group, usually not fully observed.
## Sample: what you collected. You use the sample to learn about the population.
## Cross-section: many units, one time. 526 workers in 1976 (wage1).
## Time-series: one unit, many times. U.S. unemployment each year, 2000-2024.
## Panel: many units, many times. GDP for 50 states, every year 2015-2020.
## wage1$wage pulls one column. summary() snapshots every variable.
## Center, spread, shape: mean(), sd(), hist().
## Econometrics combines economics, data, and statistics.
## log and exp undo each other. exp(log(3)) is 3.
##   log needs a positive input.
##   This is not a log-wage percent interpretation yet.
## Practice rule only: AI writes, you verify. Off on the exam.
