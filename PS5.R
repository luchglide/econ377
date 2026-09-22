## ECN 377 — Problem Set 5  (Canvas attempt 1, Sep 22)
## Quiz 5 is the same QUESTION TYPES with NEW numbers.
##
## HOW TO USE THIS ON THE QUIZ
## 1. On the lab PC, BEFORE you open the quiz, pull this file and open it in RStudio.
##    Quizzes are closed-internet, so GitHub will not load once the quiz has started.
## 2. Do not turn on Copilot. The quiz is closed-AI. This script is notes you already wrote.
## 3. Find the block that matches the question. Replace only the numbers. Run that block.
##    Highlight the lines and press Ctrl+Enter (Windows lab) or Cmd+Enter (Mac).
## 4. Canvas says "round to the hundredths." Type the printed number with two decimals,
##    including trailing zeros (4.40, not 4.4). A negative slope stays negative.
## 5. If a question says "that same sample" but prints a NEW list of numbers, use the
##    numbers printed in THAT question. The phrase is leftover wording.
##
## THE ONE TRAP: sample list vs probability table
##
## A SAMPLE is just a list of observed points, no probabilities.
##   mean(x)   average, divides by n
##   var(x)    sample variance, divides by n - 1
##   cov(x,y)  sample covariance, divides by n - 1
##   Use these for OLS on a list of points (Q11, Q12, Q14) and for "sample covariance" (Q20).
##
## A PROBABILITY TABLE gives each outcome a probability p. Those rows are NOT a sample.
##   Do NOT call var() or cov() on them. Those functions ignore p and divide by n - 1.
##   E[X]     = sum(x * p)
##   E[Y]     = sum(y * p)
##   E[XY]    = sum(x * y * p)          multiply x and y FIRST, then weight by p
##   E[X^2]   = sum(x^2 * p)            square the values FIRST, then weight by p
##   Var(X)   = E[X^2] - (E[X])^2       population variance
##   Cov(X,Y) = E[XY] - E[X] * E[Y]
##
## OLS (ordinary least squares) on a sample of points:
##   b1 = cov(x, y) / var(x)            slope. n - 1 is in BOTH, so it cancels.
##                                      same answer as sum((x-xbar)*(y-ybar)) / sum((x-xbar)^2)
##   b0 = mean(y) - b1 * mean(x)        intercept
##   yhat = b0 + b1 * x_new             prediction at a new x
##
## Population regression slope (a probability table, not a sample):
##   beta1 = Cov(X,Y) / Var(X)          use the population formulas above, not cov()/var()

rm(list = ls())

## ============================================================
## Q1–Q8  concepts. No calculator. Same ideas every time.
## ============================================================
##
## Model:  Y = b0 + b1 * X + U
##
## Q1  The DEPENDENT variable is Y.
##     Y is the outcome you are trying to explain (wage, colGPA).
##     X is the independent / explanatory variable (educ, hsGPA).
##     b0 and b1 are unknown constants. U is the error, not a variable you chose.
##
## Q2  U is every factor OTHER than X that affects Y.
##     In wage = b0 + b1*educ + U, U holds ability, motivation, and anything else
##     that moves wage but is not education. U is not the slope, not the average
##     of Y, and not the prediction.
##
## Q3  The slope b1 is the ceteris-paribus effect of X on Y.
##     "Ceteris paribus" means "other things held fixed."
##     If X rises by 1 and the stuff inside U does not change, Y changes by b1.
##     b1 is not "Y when X = 0" (that is the intercept b0).
##     b1 is not the correlation. Correlation has no units and stays between -1 and 1.
##     A slope is in units of Y per unit of X and can be any number.
##
## Q4  E[U | X] = 0 means: the average of U is 0 no matter what X is.
##     The average omitted factors do not systematically rise or fall with X.
##     It does NOT mean every single U is exactly 0. People still differ.
##     It does NOT mean Y equals b0 + b1*X with no error. The error is still there;
##     it just averages to 0 at every X.
##     Best answer: "The average of U does not depend on X."
##
## Q5  Under that assumption, E[Y | X = x] = b0 + b1 * x.
##     Start from Y = b0 + b1*X + U.
##     Take E[ . | X = x]. A constant stays. X is known once we condition, so it stays.
##     E[U | X = x] = 0, so the U drops out.
##     You are left with a straight line. Do NOT leave + U in the conditional mean.
##     The conditional mean is also not just b1*x (that drops the intercept)
##     and not the sample average of all Y (that ignores x).
##
## Q6  The OLS slope estimate is  b1_hat = cov(x, y) / var(x).
##     Memory: covariance on top, variance of the X variable on the bottom.
##     Not var(x)/var(y), not var(x)/cov(x,y), not cov times var.
##
## Q7  We ESTIMATE b0 and b1 because they are population constants and we only
##     see a sample. We cannot compute the true population values exactly.
##     The estimates change from sample to sample. That is why they wear hats: b0_hat, b1_hat.
##
## Q8  b0 + b1*X is the part of Y EXPLAINED by X. It is the conditional mean E[Y|X].
##     U is the part NOT explained by X (the residual, once we have estimates).

## ============================================================
## Q9  slope from a given covariance and variance
##     b1_hat = cov(x,y) / var(x)
##     This attempt: cov = 4, var(x) = 7  ->  0.57
## ============================================================
## Tomorrow: replace 4 and 7 with the two numbers Canvas prints.
cov_xy <- 4
var_x  <- 7
b1 <- cov_xy / var_x
round(b1, 2)                       # 4/7 = 0.5714... -> 0.57

## ============================================================
## Q10  intercept from means and a slope
##      b0_hat = ybar - b1_hat * xbar
##      This attempt: ybar = 10, xbar = 8, b1 = 7/10  ->  4.40
## ============================================================
## Read a fraction like 7/10 as 0.7. Do the subtraction in this order:
## intercept = average of y, minus (slope times average of x).
ybar <- 10
xbar <- 8
b1   <- 7/10
b0   <- ybar - b1 * xbar
round(b0, 2)                       # 10 - 0.7*8 = 10 - 5.6 = 4.40

## ============================================================
## Q11  OLS slope from a sample of points
##      b1_hat = cov(x,y) / var(x)
##      This attempt: x = (5, 7, 2), y = (12, 7, 12)  ->  -0.92
## ============================================================
## Why cov/var is legal here: the textbook writes
##   sum( (x - xbar) * (y - ybar) ) / sum( (x - xbar)^2 )
## R's cov() and var() each divide by n - 1. The n - 1 is on the top AND the
## bottom, so it cancels. cov(x,y)/var(x) equals that sum formula.
## A negative answer is fine. It means y tends to fall as x rises.
x <- c(5, 7, 2)
y <- c(12, 7, 12)
b1 <- cov(x, y) / var(x)
round(b1, 2)                       # -0.92

## By hand, if you want to see the same number:
## xbar = (5+7+2)/3 = 14/3
## ybar = (12+7+12)/3 = 31/3
## deviations in x: 1/3, 7/3, -8/3
## deviations in y: 5/3, -10/3, 5/3
## sum of products = -105/9, sum of squared x-deviations = 114/9
## slope = -105/114 = -0.92105... -> -0.92

## ============================================================
## Q12  OLS intercept from a sample
##      first get the slope, THEN b0 = mean(y) - b1 * mean(x)
##      This attempt: x = (4, 6, 6), y = (5, 8, 2)  ->  5.00
## ============================================================
## Use the x and y printed in THIS question, even if the sentence says
## "that same sample." These numbers are not the ones from Q11.
x <- c(4, 6, 6)
y <- c(5, 8, 2)
b1 <- cov(x, y) / var(x)           # this one happens to be 0
b0 <- mean(y) - b1 * mean(x)
round(b0, 2)                       # mean(y) = 5, slope = 0, so intercept = 5.00

## ============================================================
## Q13  prediction when they hand you the intercept and the slope
##      yhat = b0 + b1 * x
##      This attempt: b0 = 3, b1 = 4/10, x = 12  ->  7.80
## ============================================================
## No data list. Plug x into the line they already gave you.
b0 <- 3
b1 <- 4/10
x_new <- 12
yhat <- b0 + b1 * x_new
round(yhat, 2)                     # 3 + 0.4*12 = 3 + 4.8 = 7.80

## ============================================================
## Q14  fit the line yourself, then predict at a new x
##      This attempt: x = (6, 8, 6), y = (2, 0, 5), predict at x = 7  ->  1.75
## ============================================================
## Three steps, always in this order:
##   1. slope from the sample
##   2. intercept from the two means and that slope
##   3. plug the NEW x into b0 + b1*x
## The new x (7) is not one of the data points. That is the point of prediction.
x <- c(6, 8, 6)
y <- c(2, 0, 5)
b1 <- cov(x, y) / var(x)           # -1.75
b0 <- mean(y) - b1 * mean(x)       # 14
x_new <- 7
yhat <- b0 + b1 * x_new
round(yhat, 2)                     # 14 + (-1.75)*7 = 14 - 12.25 = 1.75

## ============================================================
## Q15  evaluate a conditional-mean line they already wrote down
##      E[colGPA | hsGPA] = 15/10 + (3/10) * hsGPA
##      at hsGPA = 36/10  ->  2.58
## ============================================================
## This is Day 8, not estimation. They gave you b0 and b1.
## 15/10 = 1.5,  3/10 = 0.3,  36/10 = 3.6
## Expected colGPA = 1.5 + 0.3 * 3.6
## The notes example was 1.5 + 0.5*hsGPA. The quiz can change the fractions.
## Read the fractions on the question. Do not memorize 0.5.
b0 <- 15/10
b1 <- 3/10
hsGPA <- 36/10
round(b0 + b1 * hsGPA, 2)          # 1.5 + 1.08 = 2.58

## ============================================================
## Q16  ceteris-paribus change: slope times the change in X
##      wage = b0 + b1*educ + U,   b1 = 6/10,   educ rises by 2
##      change in predicted wage = b1 * (change in educ)  ->  1.20
## ============================================================
## You do NOT need b0 or the old level of educ.
## "Rises by 2 years" is a CHANGE, delta_educ = 2, not a level of 2.
## delta_y = b1 * delta_x. The intercept does not move, so it cancels.
b1 <- 6/10
delta_educ <- 2
round(b1 * delta_educ, 2)          # 0.6 * 2 = 1.20

## ============================================================
## Q17  E[X] from a joint probability table
##      rows: (x, y, p) = (1, 6, 0.2), (5, 4, 0.3), (1, 3, 0.5)
##      E[X] = sum(x * p)  ->  2.20
## ============================================================
## Y is in the table and you ignore it. E[X] only uses the x column and p.
## Check that the probabilities add to 1 before you trust the table: 0.2+0.3+0.5 = 1.
## Do not use mean(x). mean() treats the three rows as equally likely data points
## and would divide by 3. Here the rows are not equally likely.
x <- c(1, 5, 1)
p <- c(0.2, 0.3, 0.5)
round(sum(x * p), 2)               # 1*0.2 + 5*0.3 + 1*0.5 = 0.2 + 1.5 + 0.5 = 2.20

## ============================================================
## Q18  Cov(X,Y) from a joint probability table
##      Cov = E[XY] - E[X]*E[Y]
##      rows: (5, 5, 0.2), (6, 6, 0.3), (5, 2, 0.5)  ->  0.66
## ============================================================
## Order of operations, or the number will be wrong:
##   1. E[X]  = sum(x * p)
##   2. E[Y]  = sum(y * p)
##   3. E[XY] = sum(x * y * p)     product of x and y, THEN times p
##   4. Cov   = E[XY] - E[X] * E[Y]
## E[XY] is not E[X]*E[Y]. That gap IS the covariance.
## Do not call cov(x, y). That ignores the probabilities.
x <- c(5, 6, 5)
y <- c(5, 6, 2)
p <- c(0.2, 0.3, 0.5)
EX  <- sum(x * p)                  # 5.3
EY  <- sum(y * p)                  # 3.8
EXY <- sum(x * y * p)              # 25*0.2 + 36*0.3 + 10*0.5 = 20.8
round(EXY - EX * EY, 2)            # 20.8 - 5.3*3.8 = 20.8 - 20.14 = 0.66

## ============================================================
## Q19  population regression slope from a joint table
##      beta1 = Cov(X,Y) / Var(X)
##      rows: (3, 7, 0.2), (1, 0, 0.3), (6, 0, 0.5)  ->  -0.26
## ============================================================
## Var(X) here is the POPULATION variance: E[X^2] - (E[X])^2.
## (E[X])^2 means square the mean. E[X^2] means square each x, then weight by p.
## Those are different numbers. Square first, then average.
x <- c(3, 1, 6)
y <- c(7, 0, 0)
p <- c(0.2, 0.3, 0.5)
EX  <- sum(x * p)                  # 3.9
EY  <- sum(y * p)                  # 1.4
EXY <- sum(x * y * p)              # 4.2
EX2 <- sum(x^2 * p)                # 9*0.2 + 1*0.3 + 36*0.5 = 20.1
Cov  <- EXY - EX * EY              # 4.2 - 3.9*1.4 = -1.26
VarX <- EX2 - EX^2                 # 20.1 - 3.9^2 = 20.1 - 15.21 = 4.89
round(Cov / VarX, 2)               # -1.26 / 4.89 = -0.2576... -> -0.26

## ============================================================
## Q20  SAMPLE covariance (review). This one IS a data list.
##      S_xy = cov(x, y)     R divides by n - 1, which is what "sample" means
##      This attempt: x = (6, 2, 0), y = (5, 6, 2)  ->  3.67
## ============================================================
## The question writes (1/(n-1)) * sum( (x - xbar) * (y - ybar) ).
## That is exactly cov(x, y). No probabilities on this one.
x <- c(6, 2, 0)
y <- c(5, 6, 2)
round(cov(x, y), 2)                # 3.666... -> 3.67

## ============================================================
## Canvas answers for THIS attempt, in order. Tomorrow's numbers will differ.
## Q1  Y
## Q2  factors other than X that affect Y
## Q3  ceteris paribus effect of X on Y
## Q4  the average of U does not depend on X
## Q5  b0 + b1*x
## Q6  cov(x,y) / var(x)
## Q7  they are population quantities; we only see a sample
## Q8  the part of Y explained by X (its conditional mean)
## Q9  0.57
## Q10 4.40
## Q11 -0.92
## Q12 5.00
## Q13 7.80
## Q14 1.75
## Q15 2.58
## Q16 1.20
## Q17 2.20
## Q18 0.66
## Q19 -0.26
## Q20 3.67
