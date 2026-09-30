## ECN 377 - Problem Set 6  (Canvas attempt 1, Sep 30, 11:19am)
## Quiz 6 is the same QUESTION TYPES with NEW numbers.
##
## HOW TO USE THIS ON THE QUIZ
## 1. On the lab PC, BEFORE you open the quiz, pull this file and open it in RStudio.
##    Quizzes are closed-internet, so GitHub will not load once the quiz has started.
## 2. Do not turn on Copilot. The quiz is closed-AI. This file is the practice script.
## 3. Find the block with the same question number. Replace only the numbers. Run that block.
##    Highlight the lines and press Ctrl+Enter.
## 4. Canvas says "round to the hundredths." Type the printed number with two decimals,
##    including trailing zeros (2.00, not 2). A negative answer stays negative.
## 5. If a question says "that same sample" but prints a NEW list of numbers, use the
##    numbers printed in THAT question. Q10 does this. The phrase is leftover wording.
##
## NAMES FROM DAY 11 AND DAY 12 (do not mix these up)
##   Yhat  = b0_hat + b1_hat * X     the fitted value. The point on the line.
##   Uhat  = Y - Yhat                the residual. Actual minus fitted.
##   SST   = total variation in Y    sum( (Y - Ybar)^2 )
##   SSR   = unexplained             sum( (Y - Yhat)^2 )   squared residuals
##   SSE   = explained               SST - SSR
##   R^2   = SSE / SST               fraction of Y that the line explains
##           also 1 - SSR / SST
##
## OLS on a sample of points (Q9, Q10, Q11):
##   b1_hat = cov(x, y) / var(x)     slope. n - 1 is in BOTH, so it cancels.
##   b0_hat = mean(y) - b1_hat * mean(x)
##   yhat   = b0_hat + b1_hat * x_new
## lm() gives the same two numbers. cov/var is the version from class.

rm(list = ls())

## ============================================================
## Q1-Q8  concepts. No calculator. Same clicks every time.
## ============================================================
##
## Q1  The fitted value Yhat_i = b0_hat + b1_hat * X_i is:
##     The model's PREDICTION of Y at X_i.
##     Not the actual Y. Not the residual. Not the error term U.
##
## Q2  The OLS residual Uhat_i equals:
##     Y_i - Yhat_i   (actual minus fitted)
##     Fitted minus actual is the same gap with the sign flipped. Do not pick that.
##
## Q3  A POSITIVE residual (Uhat > 0) means OLS:
##     Under-predicted Y_i (actual > fitted).
##     The point sits above the line. OLS guessed too low.
##     Over-predicted would be a negative residual.
##
## Q4  R^2 is:
##     The fraction of the sample variation in Y explained by X.
##     It is not the slope, not the sum of squared residuals, and not always 1.
##
## Q5  SST =
##     SSE + SSR
##     Total = explained + unexplained. Not a difference, not a product.
##
## Q6  The sum of the OLS residuals is always:
##     0
##     Day 11 property 1. They cancel. Not SSR, not 1, not always positive.
##
## Q7  An R^2 close to 0 means:
##     The OLS line explains little of the variation in Y.
##     That is common, and not necessarily a bad model.
##     The slope does not have to be 0. The regression is not "invalid."
##     X does not have to perfectly predict Y.
##
## Q8  The point (Xbar, Ybar):
##     Always lies on the OLS regression line.
##     Day 11 property 3. It is not the residual and it is not R^2.

## ============================================================
## Q9  OLS slope from a sample
##     b1_hat = cov(x, y) / var(x)
##     This attempt: x = (2, 2, 3), y = (2, 2, 4)  ->  2.00
## ============================================================
## Textbook formula, same answer:
##   sum( (x - xbar) * (y - ybar) ) / sum( (x - xbar)^2 )
x <- c(2, 2, 3)
y <- c(2, 2, 4)
b1 <- cov(x, y) / var(x)
round(b1, 2)                       # 2.00

## ============================================================
## Q10  OLS intercept from a sample
##      first get the slope, THEN b0_hat = mean(y) - b1_hat * mean(x)
##      This attempt: x = (3, 2, 3), y = (7, 0, 10)  ->  -17.00
## ============================================================
## Use the x and y printed in THIS question. These are not the Q9 numbers,
## even though the sentence says "that same sample."
x <- c(3, 2, 3)
y <- c(7, 0, 10)
b1 <- cov(x, y) / var(x)           # 8.5
b0 <- mean(y) - b1 * mean(x)
round(b0, 2)                       # -17.00

## ============================================================
## Q11  fit the line, then predict at a new x
##      This attempt: x = (5, 6, 8), y = (0, 6, 8), predict at x = 3  ->  -3.43
## ============================================================
## Three steps, always in this order:
##   1. slope from the sample
##   2. intercept from the two means and that slope
##   3. plug the NEW x into b0 + b1 * x
## The new x (3) is not one of the data points.
x <- c(5, 6, 8)
y <- c(0, 6, 8)
b1 <- cov(x, y) / var(x)
b0 <- mean(y) - b1 * mean(x)
x_new <- 3
yhat <- b0 + b1 * x_new
round(yhat, 2)                     # -3.43

## ============================================================
## Q12  fitted value when they already give you the line
##      yhat = -3 + (2/10) * x, at x = 12  ->  -0.60
## ============================================================
## No sample. Do not call lm() or cov(). Plug x into the line.
b0 <- -3
b1 <- 2/10
x_new <- 12
round(b0 + b1 * x_new, 2)          # -3 + 0.2*12 = -3 + 2.4 = -0.60

## ============================================================
## Q13  residual
##      line: yhat = 1 + (8/10) * x
##      person has x = 12 and actual y = 19  ->  8.40
## ============================================================
## Residual = actual y - fitted y. Positive means the line was too low.
b0 <- 1
b1 <- 8/10
x_i <- 12
y_i <- 19
yhat <- b0 + b1 * x_i              # 10.6
round(y_i - yhat, 2)               # 19 - 10.6 = 8.40

## ============================================================
## Q14  predicted CHANGE. Ignore the intercept.
##      slope = 7/10, x rises by 1  ->  0.70
## ============================================================
## delta_yhat = b1 * delta_x. "Rises by 1" is a change, not a level of x.
b1 <- 7/10
delta_x <- 1
round(b1 * delta_x, 2)             # 0.70

## ============================================================
## Q15  SSR from a given line and three points
##      line: yhat = 2 + (4/10) * x
##      points: (3, 10), (5, 14), (9, 11)  ->  175.40
## ============================================================
## SSR = sum( (actual y - fitted y)^2 )
## Fit each x with the line they gave you. Do not re-estimate the slope.
x <- c(3, 5, 9)
y <- c(10, 14, 11)
yhat <- 2 + (4/10) * x             # 3.2, 4.0, 5.6
resid <- y - yhat                  # 6.8, 10, 5.4
round(sum(resid^2), 2)             # 175.40

## ============================================================
## Q16  explained sum of squares
##      SST = 241, SSR = 113  ->  SSE = 128.00
## ============================================================
## SSE = SST - SSR. Explained = total minus unexplained.
SST <- 241
SSR <- 113
round(SST - SSR, 2)                # 128.00

## ============================================================
## Q17  R^2 from SST and SSR
##      SST = 206, SSR = 70  ->  0.66
## ============================================================
## R^2 = (SST - SSR) / SST = SSE / SST
SST <- 206
SSR <- 70
round((SST - SSR) / SST, 2)        # 136/206 = 0.66019... -> 0.66

## ============================================================
## Q18  R^2 from SSE and SST
##      SSE = 60, SST = 315  ->  0.19
## ============================================================
## They handed you explained and total. R^2 = SSE / SST.
## Do not subtract. SSR is not in this question.
SSE <- 60
SST <- 315
round(SSE / SST, 2)                # 60/315 = 0.19047... -> 0.19

## ============================================================
## Q19  fraction UNEXPLAINED
##      SST = 357, SSR = 176  ->  0.49
## ============================================================
## Unexplained fraction = SSR / SST. That is 1 - R^2, not R^2.
## Read the word UNEXPLAINED before you divide.
SST <- 357
SSR <- 176
round(SSR / SST, 2)                # 176/357 = 0.49299... -> 0.49

## ============================================================
## Q20  SSR from SST and R^2
##      SST = 358, R^2 = 50/100  ->  179.00
## ============================================================
## SSR = SST * (1 - R^2)
## Same path: SSE = R^2 * SST, then SSR = SST - SSE.
SST <- 358
R2 <- 50/100
round(SST * (1 - R2), 2)           # 358 * 0.5 = 179.00

## ============================================================
## IF THE QUIZ CHANGES THE NUMBERS
## ------------------------------------------------------------
## Slope from a sample (Q9):
##   round(cov(x, y) / var(x), 2)
##
## Intercept from a sample (Q10):
##   b1 <- cov(x, y) / var(x)
##   round(mean(y) - b1 * mean(x), 2)
##
## Predict at a new x (Q11):
##   b1 <- cov(x, y) / var(x)
##   b0 <- mean(y) - b1 * mean(x)
##   round(b0 + b1 * x_new, 2)
##
## Fitted value, line already given (Q12):
##   round(b0 + b1 * x, 2)
##
## Residual (Q13):
##   round(y - (b0 + b1 * x), 2)
##
## Change in y, ignore intercept (Q14):
##   round(b1 * dx, 2)
##
## SSR from points and a given line (Q15):
##   yhat <- b0 + b1 * x
##   round(sum((y - yhat)^2), 2)
##
## SSE (Q16):                 round(SST - SSR, 2)
## R^2 from SST and SSR (Q17): round((SST - SSR) / SST, 2)
## R^2 from SSE and SST (Q18): round(SSE / SST, 2)
## Unexplained (Q19):         round(SSR / SST, 2)
## SSR from R^2 (Q20):        round(SST * (1 - R2), 2)
## ============================================================

## Canvas answers for THIS attempt, in order. The quiz numbers will differ.
## Q1  model's PREDICTION of Y at X_i
## Q2  Y_i - Yhat_i (actual minus fitted)
## Q3  under-predicted Y_i (actual > fitted)
## Q4  fraction of the sample variation in Y explained by X
## Q5  SSE + SSR
## Q6  0
## Q7  explains little of the variation in Y. Common. Not necessarily a bad model.
## Q8  (Xbar, Ybar) always lies on the OLS line
## Q9  2.00
## Q10 -17.00
## Q11 -3.43
## Q12 -0.60
## Q13 8.40
## Q14 0.70
## Q15 175.40
## Q16 128.00
## Q17 0.66
## Q18 0.19
## Q19 0.49
## Q20 179.00
