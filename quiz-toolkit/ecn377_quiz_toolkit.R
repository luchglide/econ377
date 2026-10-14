## ECN 377 — Exam I group review toolkit (Groups A–G)
## Same style as PS5.R / exam1.R: find the block, replace only the numbers
## under "SET", run the block (highlight + Ctrl+Enter / Cmd+Enter).
## Round to hundredths unless the question says otherwise.
## Textbook notation: SSE = EXPLAINED, SSR = RESIDUAL (unexplained), SST = total.
##
## Pull this file BEFORE the quiz starts (quizzes are closed-internet).
## Group E needs the wooldridge package. Install it before the quiz:
##   install.packages("wooldridge")

rm(list = ls())

## ============================================================
## A1  sd of aX + b from E[X] and E[X^2]
##     Sheet: E[X]=2, E[X^2]=20, sd(3X-7)  ->  12.00
## ============================================================
## Var(X) = E[X^2] - (E[X])^2.  Var(aX+b) = a^2 Var(X).  The +b does nothing.
## sd(aX+b) = |a| * sd(X)
EX  <- 2      # SET
EX2 <- 20     # SET
a   <- 3      # SET
b   <- -7     # SET (ignored, constants do not change spread)
varX <- EX2 - EX^2
round(abs(a) * sqrt(varX), 2)          # Var(X)=16, sd=4, 3*4 = 12.00

## ============================================================
## A2  Var(aX + bY) with a covariance
##     Sheet: Var(X)=5, Var(Y)=8, Cov=-2, Var(3X-2Y)  ->  101.00
## ============================================================
## Var(aX+bY) = a^2 VarX + b^2 VarY + 2ab Cov
varX <- 5     # SET
varY <- 8     # SET
covXY <- -2   # SET
a <- 3        # SET
b <- -2       # SET  (minus sign goes INTO b)
round(a^2*varX + b^2*varY + 2*a*b*covXY, 2)   # 45 + 32 + 24 = 101.00

## ============================================================
## B1  Cor(X,Y) from a JOINT probability table
##     Sheet: (1,2,.2) (2,6,.3) (4,3,.4) (5,7,.1)  ->  0.1644 (0.16)
## ============================================================
## Table, NOT a sample: never var()/cov() here. Weight by p.
x <- c(1, 2, 4, 5)           # SET
y <- c(2, 6, 3, 7)           # SET
p <- c(0.2, 0.3, 0.4, 0.1)   # SET
stopifnot(abs(sum(p) - 1) < 1e-9)
EX <- sum(x*p); EY <- sum(y*p)
VarX <- sum(x^2*p) - EX^2          # 1.89
VarY <- sum(y^2*p) - EY^2          # 3.29
CovXY <- sum(x*y*p) - EX*EY        # 0.41
c(EX = EX, EY = EY, VarX = VarX, VarY = VarY, Cov = CovXY)
round(CovXY / sqrt(VarX*VarY), 4)  # 0.1644

## ============================================================
## B2  conditional mean and variance given X = x
##     Sheet: Y in (4,10,16), p (.25,.5,.25); E[3Y-2|X], Var(Y|X)  ->  28, 18
## ============================================================
yv <- c(4, 10, 16)           # SET
pv <- c(0.25, 0.5, 0.25)     # SET
a <- 3; b <- -2              # SET  E[aY+b | X]
EY  <- sum(yv*pv)                    # 10
VarY <- sum(yv^2*pv) - EY^2          # 18
round(c(E_aYb = a*EY + b, VarY_given_X = VarY), 2)   # 28.00, 18.00

## ============================================================
## C1  OLS by hand, residual of observation i
##     Sheet: x=(2,3,5,7,8), y=(3,6,5,9,12), i=4  ->  -0.54
## ============================================================
x <- c(2, 3, 5, 7, 8)        # SET
y <- c(3, 6, 5, 9, 12)       # SET
i <- 4                       # SET which observation
b1 <- cov(x, y) / var(x)     # 1.2692
b0 <- mean(y) - b1*mean(x)   # 0.6538
uhat <- y - (b0 + b1*x)
c(b0 = b0, b1 = b1)
round(uhat[i], 2)            # 9 - (0.6538 + 1.2692*7) = -0.54
coef(lm(y ~ x))              # check: same numbers

## ============================================================
## C2  (a) missing residual   (b) sum of x_i * uhat_i
##     Sheet: 1.4, -0.6, -2.3, 0.9, 1.1, ?  ->  -0.50 ;  sum x*uhat = 0
## ============================================================
## OLS residuals ALWAYS sum to 0, so the missing one = -(sum of the others).
known <- c(1.4, -0.6, -2.3, 0.9, 1.1)   # SET
round(-sum(known), 2)                   # -0.50
## (b) OLS property: sum(x * uhat) = 0 for ANY OLS fit. Uses C1's x and uhat.
round(sum(x * uhat), 10)                # 0

## ============================================================
## D1  SSR from SSE and R^2
##     Sheet: SSE=120, R^2=0.4  ->  SST=300, SSR=180
## ============================================================
SSE <- 120    # SET (explained)
R2  <- 0.4    # SET
SST <- SSE / R2
c(SST = SST, SSR = SST - SSE)           # 300, 180

## ============================================================
## D2  SST from sample variance, then R^2
##     Sheet: n=31, S_y^2=9, SSR=189  ->  SST=270, R^2=0.30
## ============================================================
## S_y^2 = SST/(n-1)  so  SST = (n-1) * S_y^2
n <- 31; S2 <- 9; SSR <- 189            # SET
SST <- (n - 1) * S2
round(c(SST = SST, R2 = 1 - SSR/SST), 2)   # 270.00, 0.30

## ============================================================
## E   real data (wooldridge)
## ============================================================
if (!requireNamespace("wooldridge", quietly = TRUE)) {
  message("wooldridge not installed. Run install.packages('wooldridge') then rerun Group E.")
} else {
  library(wooldridge)
  ## E1  wage1: wage on tenure, residual of row 6  ->  2.34
  data("wage1")
  m1  <- lm(wage ~ tenure, data = wage1)
  row <- 6                                  # SET
  print(coef(m1))
  cat("E1 residual row", row, ":", round(resid(m1)[row], 2), "\n")

  ## E2  ceosal1: salary on roe, SSE (explained) and % R^2  ->  5,166,419 ; 1.32%
  data("ceosal1")
  m2  <- lm(salary ~ roe, data = ceosal1)
  yb  <- mean(ceosal1$salary)
  SSE <- sum((fitted(m2) - yb)^2)           # explained
  SST <- sum((ceosal1$salary - yb)^2)
  print(coef(m2))                           # 963.19 + 18.50*roe
  cat("E2 SSE (explained):", format(round(SSE), big.mark = ","), "\n")
  cat("E2 R^2 %:", round(100 * SSE/SST, 2), " (summary says", round(100*summary(m2)$r.squared, 2), ")\n")
}

## ============================================================
## F   concepts (no math)
## ============================================================
## F1  NO. Family income is in U and is correlated with class size
##     (richer districts -> smaller classes), so E[U | class size] changes with
##     class size and is not 0. The OLS slope picks up the income effect (biased).
## F2  LINE C. OLS line must have sum(uhat) = 0 (only A and C) AND the smallest
##     sum(uhat^2) among those (C 5.33 < A 6.91). sum(uhat)=0 alone does not pick
##     one (A and C tie), and sum|uhat| is not what OLS minimizes.
lines <- data.frame(line = c("A","B","C","D"),           # SET
                    su   = c(0, -4, 0, 0.5),
                    ssq  = c(6.91, 8.00, 5.33, 5.55))
ok <- subset(lines, abs(su) < 1e-9)
ok$line[which.min(ok$ssq)]                                # "C"

## ============================================================
## G1  correlation after rescaling units  ->  0.35
## ============================================================
## Correlation is unit-free: dividing income by 1000 does not change it.
## (The covariance WOULD change: 6200/1000 = 6.2.)
r <- 0.35; cov_old <- 6200; c_scale <- 1/1000             # SET
c(cor_new = r, cov_new = cov_old * c_scale)

## ============================================================
## G2  linear change  dy = b1*dX1 + b2*dX2   (intercept cancels)
##     Sheet: y = 2 + 1.5X1 - 0.8X2, X1 +4, X2 -3  ->  8.40
## ============================================================
b1 <- 1.5; b2 <- -0.8                                     # SET
dX1 <- 4;  dX2 <- -3                                      # SET ("falls" = negative)
round(b1*dX1 + b2*dX2, 2)                                 # 6 + 2.4 = 8.40
