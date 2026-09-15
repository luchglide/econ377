## ECN 377 — Problem Set 4 (Canvas attempt 1)
## Practice only. Quiz 4 is closed-internet and closed-AI.

rm(list = ls())

## ---------- Q1–Q7: concepts ----------
## Q1  E[c] = c
## Q2  If X and Y are independent, Cov(X,Y) = 0
## Q3  Cor(X,Y) is between -1 and 1
## Q4  Var(X) = E[X^2] - E[X]^2
## Q5  Correlation is unitless and between -1 and 1
## Q6  E[Y | X=x] is the average Y among observations with X=x
## Q7  If independent, Var(X+Y) = Var(X) + Var(Y)

## ---------- Q8: E[aX+b], E[X]=5, a=5, b=4 -> 29.00 ----------
EX <- 5; a <- 5; b <- 4
a * EX + b

## ---------- Q9: E[aX+bY], E[X]=8, E[Y]=3, a=2, b=2 -> 22.00 ----------
EX <- 8; EY <- 3; a <- 2; b <- 2
a * EX + b * EY

## ---------- Q10: E[aX+bY-c], E[X]=3, E[Y]=4, a=4, b=5, c=7 -> 25.00 ----------
EX <- 3; EY <- 4; a <- 4; b <- 5; c <- 7
a * EX + b * EY - c

## ---------- Q11: Var(X), E[X]=4, E[X^2]=83 -> 67.00 ----------
EX <- 4; EX2 <- 83
EX2 - EX^2

## ---------- Q12: Var(aX+b), Var(X)=4, a=2 -> 16.00 ----------
VarX <- 4; a <- 2
a^2 * VarX

## ---------- Q13: sd(X), Var(X)=10 -> 3.16 ----------
VarX <- 10
sqrt(VarX)

## ---------- Q14: independent X,Y; Var(X)=6, Var(Y)=6 -> 12.00 ----------
VarX <- 6; VarY <- 6
VarX + VarY

## ---------- Q15: Cov(X,Y), E[XY]=17, E[X]=1, E[Y]=3 -> 14.00 ----------
EXY <- 17; EX <- 1; EY <- 3
EXY - EX * EY

## ---------- Q16: paired values, equally likely -> 0.11 ----------
x <- c(1, 0, 0)
y <- c(2, 2, 1)
p <- rep(1/3, 3)
sum(x * y * p) - sum(x * p) * sum(y * p)

## ---------- Q17: Cov(a1X+b1, a2Y+b2), Cov=-1, a1=3, a2=5 -> -15.00 ----------
CovXY <- -1; a1 <- 3; a2 <- 5
a1 * a2 * CovXY

## ---------- Q18: Cor(X,Y), Cov=3, sdX=3, sdY=3 -> 0.33 ----------
CovXY <- 3; sdX <- 3; sdY <- 3
CovXY / (sdX * sdY)

## ---------- Q19: Var(aX+bY), VarX=6, VarY=5, Cov=0, a=b=3 -> 99.00 ----------
VarX <- 6; VarY <- 5; CovXY <- 0; a <- 3; b <- 3
a^2 * VarX + b^2 * VarY + 2 * a * b * CovXY

## ---------- Q20: E[Y | X=x] for 1,3,5,10 -> 4.75 ----------
y <- c(1, 3, 5, 10)
mean(y)

## ---------- Q21: weighted conditional mean of 9,9,9 -> 9.00 ----------
y <- c(9, 9, 9)
p <- c(0.2, 0.3, 0.5)
sum(y * p)

## ---------- Q22: E[aY+b | X=x], conditional mean=2, a=3, b=9 -> 15.00 ----------
conditional_mean <- 2; a <- 3; b <- 9
a * conditional_mean + b

## Canvas answers, in order:
## c; 0; [-1,1]; E[X^2]-E[X]^2; unitless [-1,1];
## subgroup mean; Var(X)+Var(Y);
## 29.00; 22.00; 25.00; 67.00; 16.00; 3.16; 12.00; 14.00;
## 0.11; -15.00; 0.33; 99.00; 4.75; 9.00; 15.00
