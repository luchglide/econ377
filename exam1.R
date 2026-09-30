## ECN 377 Midterm I lookup script. Days 1-12 and Problem Sets 1-6.
## Tyler Lucchi. Open in RStudio. This file is your notes plus your calculator.
##
## ON THE EXAM
## 1. When you open the file, run the r2 line once (the function under this header).
## 2. Ctrl+F the word in the question.
##    A true/false or definition is in CLICKS, near the top. Read the CLICK line.
##    A number is in the block the FINDER names. Change the # SET lines and run it.
## 3. Highlight ONLY that block (the ## header through its last line). Ctrl+Enter.
##    Do not source the whole file during the exam. Later blocks reuse names.
## 4. Change only the lines marked # SET. Run the block again.
## 5. Canvas wants hundredths: 5.90, not 5.9. The r2() line prints that.
## 6. Leave the worked lines in this file. Partial credit requires the script
##    you submit to already contain a nearly complete solution.
## 7. "That same sample" can still print a NEW list. Use the numbers in THAT question.
## 8. No Copilot. No internet. Get this file onto the lab PC before the exam starts.
##
## THE TRAP
## A SAMPLE is a list of observed points. No probabilities.
##   mean() var() sd() cov() cor()     all divide by n-1 where that applies.
## A PROBABILITY TABLE gives each outcome a probability p. Rows are not a sample.
##   Do NOT call var() or cov() on a table. Those ignore p and divide by n-1.
##   E[X] = sum(x * p).  Var(X) = E[X^2] - (E[X])^2.
## Check that the probabilities add to 1 before you trust the table.
##
## TWO MORE TRAPS
## A CHANGE in y ignores the intercept.  delta_y = b1*delta_x1 + b2*delta_x2 + ...
## A PREDICTION keeps the intercept.     yhat = b0 + b1*x
## Square the values first for E[X^2]. Square the mean for (E[X])^2. Different numbers.

r2 <- function(z) {
  z <- as.numeric(z)
  z[abs(z) < 1e-8] <- 0
  formatC(round(z, 2), format = "f", digits = 2)
}

## ============================================================
## FINDER   Ctrl+F the word on the question
## ============================================================
## mean, average, sum, length, n ............... MEAN
## percent change, percentage point, % ......... PERCENT
## ceteris paribus, holding fixed .............. CETERIS
## delta, Dy, change, rises by ................. DELTA
## predict, plug in, at x = ................... PREDICT
## sample variance, Sx^2, n-1 .................. SAMPLE VAR
## sample sd, standard deviation ............... SAMPLE SD
## sample covariance, Sxy ...................... SAMPLE COV
## sample correlation, cor, rho ................ SAMPLE COR
## E[X], expected value, probability ........... EXPECTATION
## E[X^2] ...................................... E X2
## Var(X), E[X^2] - (E[X])^2 ................... POP VAR
## Var(aX+b), sd ............................... VAR SCALE
## Cov(X,Y), E[XY] ............................. POP COV
## Cov(a1 X + b1, a2 Y + b2) ................... COV SCALE
## Cor(X,Y), unitless .......................... POP COR
## independent, Var(X+Y), Var(aX+bY) ........... LINEAR VAR
## conditional mean, E[Y|X], subgroup .......... COND MEAN
## conditional variance ........................ COND VAR
## dependent, error U, E[U|X] .................. MODEL
## OLS slope, beta1 hat, cov/var ............... OLS SLOPE
## OLS intercept, beta0 hat .................... OLS INTERCEPT
## fitted, y hat, residual, u hat .............. FITTED
## sum of residuals, xbar ybar on the line ..... OLS PROPERTIES
## R^2, SST, SSR, SSE, unexplained ............. R SQUARED
## units, dollars, rescale, salary, roe ........ UNITS
## cross-section, time-series, panel ........... DATA TYPE
## population, sample, $, summary, hist ........ WORDS
## log, exp .................................... LOG
## omitted, bias, Monday ....................... MONDAY
## true, false, does the intercept affect ...... CLICKS


## ============================================================
## CLICKS
## Concepts from the printed sheet. No code. Ctrl+F the word in the question.
## The first CLICK line under that word is the answer.
## If the question also has numbers, the block name tells you where to scroll.
## ============================================================
##
## CETERIS
## CLICK: ceteris paribus means holding other factors fixed.
## CLICK: in y = b0 + b1*X1 + b2*X2, b1 is the effect of X1 on y, holding X2 fixed.
## CLICK: b0 is predicted y when every x is 0.
## CLICK: correlation is not causation. Ice cream and drownings rise together because summer drives both.
## CLICK: False. A strong correlation does not prove that X causes Y.
##
## DELTA
## CLICK: False. The intercept b0 does not affect the change in y when x changes.
## CLICK: delta y = b1*dX1 + b2*dX2 + b3*dX3. The intercept cancels, so leave b0 out.
## CLICK: "rises by 2" is a change of 2, not a level of 2.
##
## PREDICT
## CLICK: a prediction keeps the intercept. yhat = b0 + b1*x.
##
## FITTED
## CLICK: the fitted value is the model's prediction of Y at that X. Not the actual Y, not U, not the residual.
## CLICK: the residual equals actual Y minus fitted Y. Not fitted minus actual.
## CLICK: a positive residual means OLS under-predicted Y. Actual is above the line.
## CLICK: a negative residual means OLS over-predicted Y.
##
## OLS PROPERTIES
## CLICK: the sum of the OLS residuals is always 0. Not SSR, not 1, not always positive.
## CLICK: X and the residuals are uncorrelated. sum(x * residual) is 0.
## CLICK: the point (xbar, ybar) always lies on the OLS line.
##
## R SQUARED
## CLICK: R^2 is the fraction of the sample variation in Y explained by X. Not the slope. Not always 1.
## CLICK: SST = SSE + SSR.
## CLICK: SST is total variation. SSE is explained. SSR is unexplained, the squared residuals.
## CLICK: R^2 = SSE / SST = 1 - SSR/SST. Unexplained fraction = SSR / SST.
## CLICK: an R^2 close to 0 means the line explains little of Y. Common, and not automatically a bad model.
## CLICK: an R^2 close to 0 does not mean the slope is 0, and it does not mean the regression is invalid.
##
## SAMPLE
## CLICK: the sample variance divides by n-1. In R that command is var(x). Do not divide again.
## CLICK: True. sd(x) is the sample standard deviation. It divides by n-1.
## CLICK: True. mean(x) gives the same result as sum(x) / length(x).
## CLICK: if two variables rise and fall together, their sample covariance is positive.
## CLICK: correlation is always between -1 and 1, and it has no units.
##
## EXPECTATION
## CLICK: E[c] = c. A constant comes out unchanged.
## CLICK: E[X] equals the sum of each value times its probability. Not mean() on a table.
## CLICK: E[X^2] equals the sum of each squared value times its probability. Square the values first.
## CLICK: Var(X) = E[X^2] - (E[X])^2. Square the mean only in the second term.
## CLICK: if X and Y are independent, Cov(X,Y) = 0.
## CLICK: if X and Y are independent, Var(X+Y) = Var(X) + Var(Y).
## CLICK: Var(aX+b) = a^2 * Var(X). The added constant does not change the variance.
##
## CONDITIONAL
## CLICK: E[Y | X = x] is the average of Y among the observations with X = x.
## CLICK: a list of Y values, no probabilities: use mean(y). A probability table: use sum(y * p).
## CLICK: E[U | X] = 0 means the average of U does not depend on X. It does not mean every U is 0.
## CLICK: under that assumption, E[Y | X = x] = b0 + b1*x. Do not leave + U in the conditional mean.
## CLICK: E[X | X] = X.
##
## MODEL
## CLICK: the dependent variable is Y. X is the explanatory variable.
## CLICK: U is every factor other than X that affects Y. Not the slope. Not the average of Y.
## CLICK: b1 is the ceteris paribus effect of X on Y. A slope can be any number. A correlation stays between -1 and 1.
## CLICK: b0 + b1*X is the part of Y explained by X.
## CLICK: we estimate b0 and b1 because they are population constants and we only see a sample.
## CLICK: the OLS slope is cov(x,y) / var(x). Covariance on top, variance of X on the bottom.
##
## DATA TYPE
## CLICK: cross-section is many units at one time. Wages and education for 526 workers, all in 1976.
## CLICK: time-series is one unit over many times. The U.S. unemployment rate each year from 2000 to 2024.
## CLICK: panel is many units over many times. GDP for all 50 states, every year from 2015 to 2020.
##
## WORDS
## CLICK: the population is the whole group you care about and usually cannot fully observe.
## CLICK: the sample is the part you actually collect.
## CLICK: True. You use the sample to learn about the population.
## CLICK: dataset$variable pulls one column out of a dataset. wage1$wage is the wage column.
## CLICK: summary() is the snapshot of every variable (min, mean, max, and so on).
## CLICK: center, spread, and shape, in that order, are mean(), sd(), and hist().
## CLICK: econometrics combines economics, data, and statistics.
## CLICK: on practice only, AI writes, you verify. AI is off on the exam.
##
## LOG
## CLICK: log and exp undo each other. exp(log(3)) is 3, and log(exp(3)) is 3.
## CLICK: log needs a positive input. This is not a log-wage percent interpretation yet.
##
## UNITS
## CLICK: multiply Y by c and both the intercept and the slope multiply by c. R^2 does not change.
##        Salary in dollars = 1000 times salary in thousands.
## CLICK: multiply X by c and the slope divides by c. The intercept stays. R^2 does not change.
##        Roe as a decimal is roe/100, so the slope multiplies by 100 and the intercept stays.
##
## MONDAY
## CLICK: not on the exam until he says so. An omitted variable biases OLS if it affects Y AND is correlated with X.


## ============================================================
## MEAN
## SEARCH: mean, average, sum, how many, length
## RULE: mean = sum / n.  mean(x) is the same as sum(x) / length(x).
## TOY: 0, 0, 6, 2, 1  ->  sum 9, n 5, mean 1.80
## ============================================================
x <- c(0, 0, 6, 2, 1)          # SET
c(sum = sum(x), n = length(x), mean = mean(x))
r2(mean(x))

## If they give the sum and n, skip the list.
total <- 90                    # SET
n <- 5                         # SET
r2(total / n)


## ============================================================
## PERCENT
## SEARCH: percent change, percentage point, interest rate, %
## RULE: percent change = 100 * (new - old) / old.
##       percentage points = new - old.   4% to 6% is 2 points, and a 50% increase.
## TOY: $20 to $25 is 25.00 percent.
##      3% to 5% is 2.00 points and 66.67 percent.
## ============================================================
old <- 20                      # SET
new <- 25                      # SET
r2(100 * (new - old) / old)

old_rate <- 3                  # SET   already in percent, not a decimal
new_rate <- 5                  # SET
c(points = r2(new_rate - old_rate),
  percent = r2(100 * (new_rate - old_rate) / old_rate))


## ============================================================
## CETERIS
## SEARCH: ceteris paribus, holding other factors fixed
## RULE: ceteris paribus = holding the other factors fixed.
##       In y = b0 + b1*X1 + b2*X2, b1 is the effect of X1 on y, holding X2 fixed.
##       b0 is the intercept: predicted y when every x is 0.
##       Correlation is not causation. Ice cream and drownings rise together
##       because summer drives both.
## A strong correlation does not prove X causes Y.
## ============================================================


## ============================================================
## DELTA
## SEARCH: delta, Dy, change, rises by, intercept, affect, true, false
## CLICK: False. The intercept b0 does not affect the change in y when x changes.
## RULE: the intercept does not enter a change. It cancels.
##       delta_y = b1*delta_x1 + b2*delta_x2 + b3*delta_x3 + ...
##       "Rises by 2" is a change of 2, not a level of 2.
## TOY: quantity = 120 - 9.8*price + 0.03*income
##      price up $1, income fixed -> -9.80
##      price down $2 and income up $300 -> 28.60
## ============================================================
b1 <- -9.8                     # SET  slope on the variable that changes
b2 <- 0.03                     # SET  0 if the question has only one slope
b3 <- 0                        # SET
dx1 <- 1                       # SET
dx2 <- 0                       # SET
dx3 <- 0                       # SET
r2(b1 * dx1 + b2 * dx2 + b3 * dx3)

## Slope from a rise and a run: b1 = delta_y / delta_x
dy <- 27                       # SET
dx <- 3                        # SET
r2(dy / dx)


## ============================================================
## PREDICT
## SEARCH: predict, y at x, plug in, evaluate the line, conditional mean line
## RULE: keep the intercept. yhat = b0 + b1*x + b2*x2 + ...
##       Read a fraction like 7/10 as 0.7. Type 7/10 in R.
## TOY: b0 = 1, b1 = 7, x = 1  ->  8.00
##      E[colGPA|hsGPA] = 15/10 + (3/10)*hsGPA at 36/10  ->  2.58
## ============================================================
b0 <- 1                        # SET
b1 <- 7                        # SET
b2 <- 0                        # SET
x_new <- 1                     # SET
x2_new <- 0                    # SET
r2(b0 + b1 * x_new + b2 * x2_new)

## Day 8 line. Change the fractions to the ones printed on the question.
b0 <- 15/10                    # SET
b1 <- 3/10                     # SET
x_new <- 36/10                 # SET
r2(b0 + b1 * x_new)


## ============================================================
## SAMPLE VAR
## SEARCH: sample variance, Sx^2, divide by, n-1
## RULE: sample variance divides by n-1. var(x) already does that. Do not divide again.
##       var(x) = sum((x - mean(x))^2) / (length(x) - 1)
## TOY: x = (3, 4, 5) -> 1.00
## ============================================================
x <- c(3, 4, 5)                # SET
r2(var(x))


## ============================================================
## SAMPLE SD
## SEARCH: sample standard deviation, sd, sqrt of variance
## RULE: sd(x) = sqrt(var(x)). sd() is the sample sd. It divides by n-1.
## TOY: x = (9, 2, 2) -> 4.04
## ============================================================
x <- c(9, 2, 2)                # SET
r2(sd(x))

## If they hand you the variance already:
var_x <- 10                    # SET
r2(sqrt(var_x))


## ============================================================
## SAMPLE COV
## SEARCH: sample covariance, Sxy, rise and fall together
## RULE: cov(x, y) divides by n-1. Rise and fall together means positive covariance.
## TOY: x = (2, 2, 0), y = (4, 4, 2) -> 1.33
## ============================================================
x <- c(2, 2, 0)                # SET
y <- c(4, 4, 2)                # SET
r2(cov(x, y))


## ============================================================
## SAMPLE COR
## SEARCH: sample correlation, cor, rho, Sxy / (Sx Sy)
## RULE: cor = cov / (sd_x * sd_y). Always between -1 and 1. No units.
##       cor(x, y) if they give the lists. Or just divide the three numbers.
## TOY: Sxy = 4, Sx = 3, Sy = 2 -> 0.67
## ============================================================
sxy <- 4                       # SET
sx <- 3                        # SET
sy <- 2                        # SET
r2(sxy / (sx * sy))

x <- c(3, 4, 7)                # SET  only if they give the raw lists
y <- c(3, 6, 7)                # SET
r2(cor(x, y))


## ============================================================
## EXPECTATION
## SEARCH: E[X], expected value, probability, weighted average
## RULE: E[X] = sum(x * p). E[c] = c. A constant comes out unchanged.
##       E[aX + b] = a*E[X] + b
##       E[aX + bY] = a*E[X] + b*E[Y]
##       E[aX + bY - c] = a*E[X] + b*E[Y] - c
##       Probabilities must sum to 1. Do not use mean() on a probability table.
## TOY: values 1,2,3 with p 0.2, 0.5, 0.3 -> E[X] = 2.10
##      E[4X + 5Y - 3] with E[X]=2, E[Y]=3 -> 20.00
## ============================================================
x <- c(1, 2, 3)                # SET
p <- c(0.2, 0.5, 0.3)          # SET
sum(p)                         # must print 1
r2(sum(x * p))

EX <- 2                        # SET
EY <- 3                        # SET
a <- 4                         # SET
b <- 5                         # SET
c0 <- 3                        # SET  the constant being subtracted
r2(a * EX + b * EY - c0)


## ============================================================
## E X2
## SEARCH: E[X^2], squared value times probability
## RULE: square each value FIRST, then weight by p. This is not (E[X])^2.
## TOY: values 1,2,3 with p 0.2, 0.5, 0.3 -> 4.90
## ============================================================
x <- c(1, 2, 3)                # SET
p <- c(0.2, 0.5, 0.3)          # SET
r2(sum(x^2 * p))


## ============================================================
## POP VAR
## SEARCH: Var(X) = E[X^2] - (E[X])^2, population variance
## RULE: population variance from moments, or from a table.
##       (E[X])^2 means square the mean. E[X^2] means square first, then average.
##       For a 0/1 variable, X^2 = X, so E[X^2] = E[X].
## TOY: E[X]=4, E[X^2]=83 -> 67.00
##      values 1,2,3 with p 0.2, 0.5, 0.3 -> Var = 0.49, sd = 0.70
## ============================================================
EX <- 4                        # SET
EX2 <- 83                      # SET
r2(EX2 - EX^2)

x <- c(1, 2, 3)                # SET  table version
p <- c(0.2, 0.5, 0.3)          # SET
EX <- sum(x * p)
EX2 <- sum(x^2 * p)
r2(EX2 - EX^2)
r2(sqrt(EX2 - EX^2))           # population sd


## ============================================================
## VAR SCALE
## SEARCH: Var(aX+b), standard deviation from a variance
## RULE: Var(aX + b) = a^2 * Var(X). The added constant b does not change the variance.
##       sd = sqrt(Var).
## TOY: Var(X)=4, a=2 -> 16.00
## ============================================================
VarX <- 4                      # SET
a <- 2                         # SET
r2(a^2 * VarX)


## ============================================================
## POP COV
## SEARCH: Cov(X,Y), E[XY], joint probability, pairs
## RULE: Cov = E[XY] - E[X]*E[Y].
##       E[XY] = sum(x * y * p). Multiply x and y first, then weight by p.
##       E[XY] is not E[X]*E[Y]. That gap is the covariance.
##       Do not call cov() on a probability table.
##       If they already give E[XY], E[X], and E[Y], just subtract.
## TOY: E[XY]=17, E[X]=1, E[Y]=3 -> 14.00
##      pairs (1,2), (0,2), (0,1), each prob 1/3 -> 0.11
## ============================================================
EXY <- 17                      # SET
EX <- 1                        # SET
EY <- 3                        # SET
r2(EXY - EX * EY)

x <- c(1, 0, 0)                # SET  joint table
y <- c(2, 2, 1)                # SET
p <- c(1/3, 1/3, 1/3)          # SET
sum(p)
EX <- sum(x * p)
EY <- sum(y * p)
EXY <- sum(x * y * p)
r2(EXY - EX * EY)

## Joint table when the question asks only for E[X]. Ignore the y column.
x <- c(1, 5, 1)                # SET
p <- c(0.2, 0.3, 0.5)          # SET
r2(sum(x * p))                 # 2.20


## ============================================================
## COV SCALE
## SEARCH: Cov(a1 X + b1, a2 Y + b2)
## RULE: Cov(a1*X + b1, a2*Y + b2) = a1 * a2 * Cov(X,Y).
##       Added constants do nothing. The two slopes multiply.
## TOY: Cov = -1, a1 = 3, a2 = 5 -> -15.00
## ============================================================
CovXY <- -1                    # SET
a1 <- 3                        # SET
a2 <- 5                        # SET
r2(a1 * a2 * CovXY)


## ============================================================
## POP COR
## SEARCH: Cor(X,Y), correlation from covariance and two sds
## RULE: Cor = Cov / (sdX * sdY). Between -1 and 1. Unitless.
##       Correlation is the unitless version of covariance.
## TOY: Cov=3, sdX=3, sdY=3 -> 0.33
## ============================================================
CovXY <- 3                     # SET
sdX <- 3                       # SET
sdY <- 3                       # SET
r2(CovXY / (sdX * sdY))


## ============================================================
## LINEAR VAR
## SEARCH: independent, Var(X+Y), Var(aX+bY)
## RULE: Independent implies Cov(X,Y) = 0, and Var(X+Y) = Var(X) + Var(Y).
##       General formula, even when they are not independent:
##       Var(aX + bY) = a^2*Var(X) + b^2*Var(Y) + 2*a*b*Cov(X,Y)
##       If Cov is 0, the last term drops out.
## TOY: independent, VarX=6, VarY=6 -> 12.00
##      a=b=3, VarX=6, VarY=5, Cov=0 -> 99.00
## ============================================================
VarX <- 6                      # SET
VarY <- 6                      # SET
r2(VarX + VarY)                # only if the question says independent

a <- 3                         # SET
b <- 3                         # SET
VarX <- 6                      # SET
VarY <- 5                      # SET
CovXY <- 0                     # SET
r2(a^2 * VarX + b^2 * VarY + 2 * a * b * CovXY)


## ============================================================
## COND MEAN
## SEARCH: conditional expectation, E[Y | X = x], subgroup, among observations
## RULE: E[Y | X = x] is the average of Y inside the group where X equals x.
##       A list of Y values, no probabilities: mean(y).
##       Values with probabilities: sum(y * p). Not mean().
##       E[aY + b | X = x] = a * (that conditional mean) + b.
##       E[X | X] = X. Conditioning on X leaves nothing to average.
##       Under E[U|X] = 0, E[Y|X = x] = b0 + b1*x. Do not leave + U in it.
## TOY: Y values 1,3,5,10 -> 4.75
##      Y is 9,9,9 with p 0.2, 0.3, 0.5 -> 9.00
##      conditional mean 2, a=3, b=9 -> 15.00
## ============================================================
y <- c(1, 3, 5, 10)            # SET  list inside the subgroup
r2(mean(y))

y <- c(9, 9, 9)                # SET  weighted version
p <- c(0.2, 0.3, 0.5)          # SET
r2(sum(y * p))

cond <- 2                      # SET
a <- 3                         # SET
b <- 9                         # SET
r2(a * cond + b)


## ============================================================
## COND VAR
## SEARCH: conditional variance, spread within the subgroup
## RULE: Var(Y | X = x) is the spread of Y inside that same subgroup.
##       List of Y values: var(y), which is the SAMPLE variance (n-1).
##       Probability table: E[Y^2] - (E[Y])^2 inside that group. Not var().
## ============================================================
y <- c(1, 3, 5, 10)            # SET
r2(var(y))


## ============================================================
## MODEL
## SEARCH: dependent variable, error term, U, E[U|X], ceteris paribus effect
## RULE: Y = b0 + b1*X + U
##       Y is the dependent variable, the outcome (wage, colGPA).
##       X is the explanatory variable (educ, hsGPA).
##       U is every factor other than X that affects Y. Not the slope. Not the mean of Y.
##       b1 is the ceteris paribus effect of X on Y. It is not the correlation.
##         A slope has units of Y per unit of X and can be any number.
##         A correlation is unitless and stays between -1 and 1.
##       E[U|X] = 0 means the average of U does not depend on X.
##         It does not mean every U is 0.
##       b0 + b1*X is the part of Y explained by X (the conditional mean).
##       We estimate b0 and b1 because they are population constants and we only see a sample.
##         Estimates wear hats and change from sample to sample.
## ============================================================


## ============================================================
## OLS SLOPE
## SEARCH: OLS slope, beta1 hat, cov/var, sum (x - xbar)(y - ybar)
## RULE: b1_hat = cov(x, y) / var(x)
##       Covariance on top, variance of X on the bottom.
##       n-1 is on the top and the bottom, so it cancels.
##       Same answer as sum((x-xbar)*(y-ybar)) / sum((x-xbar)^2)
##       A negative slope is allowed. It means y tends to fall as x rises.
##       Population slope from a probability table uses Cov/Var, NOT cov()/var().
##         See POP COV, then divide by POP VAR.
## TOY: cov=4, var(x)=7 -> 0.57
##      sample x=(1,2,3), y=(2,2,5) -> 1.50
## ============================================================
cov_xy <- 4                    # SET  they already computed it
var_x <- 7                     # SET
r2(cov_xy / var_x)

x <- c(1, 2, 3)                # SET  raw sample
y <- c(2, 2, 5)                # SET
r2(cov(x, y) / var(x))
r2(coef(lm(y ~ x))[2])         # same number. [2] is the slope.


## ============================================================
## OLS INTERCEPT
## SEARCH: OLS intercept, beta0 hat, ybar - b1 xbar
## RULE: get the slope first. Then b0_hat = mean(y) - b1_hat * mean(x)
## TOY: ybar=10, xbar=8, b1=7/10 -> 4.40
##      sample x=(1,2,3), y=(2,2,5) -> slope 1.50, intercept 0.00
## ============================================================
ybar <- 10                     # SET
xbar <- 8                      # SET
b1 <- 7/10                     # SET
r2(ybar - b1 * xbar)

x <- c(1, 2, 3)                # SET
y <- c(2, 2, 5)                # SET
b1 <- cov(x, y) / var(x)
r2(mean(y) - b1 * mean(x))
r2(coef(lm(y ~ x))[1])         # [1] is the intercept


## ============================================================
## FITTED
## SEARCH: fitted value, residual, predict at a new x, over, under
## RULE: fitted yhat = b0 + b1*x. That is the model's prediction, not the actual y.
##       residual uhat = actual y - fitted y. Not the other way around.
##       Positive residual: actual > fitted. The point is above the line.
##         OLS under-predicted.
##       Negative residual: OLS over-predicted.
##       If they give the line, plug in. If they give a sample, slope, then intercept, then plug in.
##       The new x does not have to be one of the data points.
## TOY: line yhat = -0.90 + 0.54*x at x=12, actual y=9 -> fitted 5.58, residual 3.42, under
##      sample x=(1,2,3), y=(2,2,5), predict at x=4 -> 6.00
## ============================================================
b0 <- -0.90                    # SET
b1 <- 0.54                     # SET
x_new <- 12                    # SET
y_actual <- 9                  # SET  only if they ask for the residual
yhat <- b0 + b1 * x_new
r2(yhat)
r2(y_actual - yhat)            # positive means under-predicted

x <- c(1, 2, 3)                # SET
y <- c(2, 2, 5)                # SET
x_new <- 4                     # SET
b1 <- cov(x, y) / var(x)
b0 <- mean(y) - b1 * mean(x)
r2(b0 + b1 * x_new)


## ============================================================
## OLS PROPERTIES
## SEARCH: sum of residuals, uncorrelated, xbar, ybar, on the line
## RULE: these hold on ANY OLS sample.
##   1. The residuals sum to 0. Not SSR, not 1, not always positive.
##   2. X and the residuals are uncorrelated. sum(x * uhat) is 0.
##   3. The point (xbar, ybar) is on the fitted line.
##      mean(y) equals b0 + b1*mean(x).
## ============================================================
x <- c(1, 2, 3)                # SET
y <- c(2, 2, 5)                # SET
fit <- lm(y ~ x)
uhat <- resid(fit)
c(sum_resid = r2(sum(uhat)),
  x_times_resid = r2(sum(x * uhat)),
  ybar = r2(mean(y)),
  on_the_line = r2(coef(fit)[1] + coef(fit)[2] * mean(x)))


## ============================================================
## R SQUARED
## SEARCH: R^2, SST, SSR, SSE, unexplained, goodness of fit
## RULE: Loh's names (Day 12).
##       SST = total variation in Y = sum( (y - ybar)^2 )
##       SSR = unexplained = sum of squared residuals = sum( (y - yhat)^2 )
##       SSE = explained = SST - SSR
##       SST = SSE + SSR
##       R^2 = SSE / SST = 1 - SSR / SST
##       Unexplained fraction = SSR / SST
##       R^2 is the fraction of the sample variation in Y explained by X.
##       R^2 near 0 means the line explains little. Common. Not automatically a bad model.
##       The slope can still be nonzero. R^2 is not the slope, and it is not always 1.
## TOY: SST=200, SSR=150 -> SSE 50.00, R^2 0.25, unexplained 0.75
## ============================================================
SST <- 200                     # SET
SSR <- 150                     # SET  if they gave SSR. Otherwise compute SSE first.
SSE <- SST - SSR
r2(SSE)                        # explained
r2(SSE / SST)                  # R^2
r2(SSR / SST)                  # unexplained fraction
r2(1 - SSR / SST)              # R^2 again, from SSR

## If they give SSE and SST instead:
SSE <- 60                      # SET
SST <- 315                     # SET
r2(SSE / SST)

## If they give SST and R^2 and ask for SSR:
SST <- 358                     # SET
R2 <- 50/100                   # SET
r2(SST * (1 - R2))             # SSR = SST * (1 - R^2)

## From a sample, if you have to build SST and SSR yourself:
x <- c(1, 2, 3)                # SET
y <- c(2, 2, 5)                # SET
yhat <- fitted(lm(y ~ x))
SST <- sum((y - mean(y))^2)
SSR <- sum((y - yhat)^2)
SSE <- SST - SSR
r2(SSE / SST)


## ============================================================
## UNITS
## SEARCH: units, dollars, thousands, rescale, measurement
## RULE: R^2 does not change when you rescale X or Y.
##       Multiply Y by c (salary in dollars = 1000 * salary in thousands):
##         intercept and slope BOTH multiply by c.
##       Multiply X by c:
##         slope DIVIDES by c. Intercept stays. R^2 stays.
##       Day 12 check: roe as a decimal is roe/100, so the slope multiplies by 100
##         and the intercept stays.
## TOY: y = 1,2,3 on x = 1,2,3. Slope 1, intercept 0, R^2 1.
##      Y * 1000 -> slope 1000, intercept 0.
##      X / 100  -> slope 100, intercept 0.
## ============================================================
x <- c(1, 2, 3)                # SET
y <- c(1, 2, 3)                # SET
c_y <- 1000                    # SET  what they multiplied Y by
c_x <- 1/100                   # SET  what they multiplied X by
orig <- suppressWarnings(coef(lm(y ~ x)))
y_scaled <- suppressWarnings(coef(lm(I(c_y * y) ~ x)))
x_scaled <- suppressWarnings(coef(lm(y ~ I(c_x * x))))
rbind(original = round(orig, 2),
      y_times_c = round(y_scaled, 2),
      x_times_c = round(x_scaled, 2))
r2_of <- function(fit) r2(summary(fit)$r.squared)
suppressWarnings(c(
  R2_original = r2_of(lm(y ~ x)),
  R2_y = r2_of(lm(I(c_y * y) ~ x)),
  R2_x = r2_of(lm(y ~ I(c_x * x)))
))


## ============================================================
## DATA TYPE
## SEARCH: cross-section, time-series, time series, panel
## RULE:
##   Cross-section: many units, one time.
##     Wages and education for 526 workers, all in 1976. wage1 is this.
##   Time-series: one unit, many times.
##     U.S. unemployment each year from 2000 to 2024.
##   Panel: many units, many times.
##     GDP for all 50 states, every year from 2015 to 2020.
## ============================================================


## ============================================================
## WORDS
## SEARCH: population, sample, dollar sign, summary, center, spread, shape
## RULE:
##   Population: the whole group you care about and usually cannot fully observe.
##   Sample: the part you actually collect. You use the sample to learn about the population.
##   dataset$variable pulls ONE column out of a dataset. wage1$wage is the wage column.
##   summary(dataset) is the snapshot of every variable (min, mean, max, and so on).
##   Center, spread, shape, in that order: mean(), sd(), hist().
##   Course AI rule, on practice only: AI writes, you verify.
##   Econometrics combines economics, data, and statistics.
## ============================================================


## ============================================================
## LOG
## SEARCH: log, exp, nonlinear
## RULE: log() and exp() undo each other. exp(log(3)) is 3. log(exp(3)) is 3.
##       log flattens as the input grows. exp grows faster and faster.
##       The Day 5 log is R's log(), which needs a positive input.
##       This is not yet a log-wage regression. Do not turn a slope into a percent
##       unless the question is about percent change (see PERCENT).
## ============================================================
c(exp_log = exp(log(3)), log_exp = log(exp(3)))


## ============================================================
## MONDAY
## Day 13 is Monday Oct 5. Not on this sheet as an exam fact until he says so.
## The starter's one sentence: an omitted variable biases OLS if it
## (1) affects Y AND (2) is correlated with X.
## Fill the direction (up or down) in class. Do not guess it on Wednesday
## unless he puts Day 13 on the exam.
## ============================================================
