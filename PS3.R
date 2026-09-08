## ECN 377 — Problem Set 3  (your Canvas numbers, attempt 1)
## Wednesday quiz uses THE SAME question types with NEW numbers.
## Change the c(...) / values below to match the quiz, then run that block.
## File -> Open this script in RStudio. Do not turn on Copilot.

rm(list = ls())

## ---------- Q1–Q7  (same every time; no calculator) ----------
## Q1  SAMPLE variance divides by:           n - 1
## Q2  SAMPLE variance in R:                 var(x)
## Q3  correlation in R:                     cor(x, y)
## Q4  correlation is always:                between -1 and 1
## Q5  E[X] equals:                          sum of each value times its probability
## Q6  E[X^2] equals:                        sum of each SQUARED value times its probability
## Q7  sd(x) is the SAMPLE sd (div by n-1):  TRUE

## ---------- Q8  sample mean of x = (7, 8, 6)  ->  7.00 ----------
x <- c(7, 8, 6)
mean(x)                       # or: sum(x) / length(x)

## ---------- Q9  sample variance of x = (8, 6, 7)  ->  1.00 ----------
x <- c(8, 6, 7)
var(x)                        # divides by n-1. by hand:
# sum((x - mean(x))^2) / (length(x) - 1)

## ---------- Q10  sample sd of x = (5, 6, 6)  ->  0.58 ----------
x <- c(5, 6, 6)
sd(x)                         # = sqrt(var(x))

## ---------- Q11  sample cov, x=(2,4,1) y=(6,6,3)  ->  2.00 ----------
x <- c(2, 4, 1)
y <- c(6, 6, 3)
cov(x, y)
# sum((x - mean(x)) * (y - mean(y))) / (length(x) - 1)

## ---------- Q12  rho = Sxy / (Sx * Sy), Sxy=4, Sx=3, Sy=2  ->  0.67 ----------
sxy <- 4; sx <- 3; sy <- 2
sxy / (sx * sy)

## ---------- Q13  sample cor, x=(3,4,7) y=(3,6,7)  ->  0.85 ----------
x <- c(3, 4, 7)
y <- c(3, 6, 7)
cor(x, y)

## ---------- Q14  fair coin, 9 heads / 10 tails, E[X]  ->  9.50 ----------
x <- c(9, 10)
p <- c(1/2, 1/2)
sum(x * p)                    # E[X]

## ---------- Q15  fair coin, 8 heads / 2 tails, E[X^2]  ->  34.00 ----------
x <- c(8, 2)
p <- c(1/2, 1/2)
sum(x^2 * p)                  # E[X^2]  — square the VALUES, then weight. not (E[X])^2

## ---------- Q16  values 2, 1, 1 each with prob 1/3, E[X]  ->  1.33 ----------
x <- c(2, 1, 1)
p <- rep(1/3, 3)
sum(x * p)

## ---------- Q17  values 6, 2, 5 each with prob 1/3, E[X^2]  ->  21.67 ----------
x <- c(6, 2, 5)
p <- rep(1/3, 3)
sum(x^2 * p)

## ---------- Q18  X=2 w.p. 5/10, X=3 w.p. 5/10, E[X]  ->  2.50 ----------
x <- c(2, 3)
p <- c(5/10, (10 - 5)/10)
sum(x * p)

## ---------- Q19  X=0 w.p. 5/10, X=4 w.p. 5/10, E[X^2]  ->  8.00 ----------
x <- c(0, 4)
p <- c(5/10, (10 - 5)/10)
sum(x^2 * p)

## ---------- Q20  values 6, 7, 6  probs 0.2, 0.5, 0.3, E[X]  ->  6.50 ----------
x <- c(6, 7, 6)
p <- c(0.2, 0.5, 0.3)
sum(x * p)

## ---------- Q21  values 2, 2, 7  probs 0.2, 0.5, 0.3, E[X^2]  ->  17.50 ----------
x <- c(2, 2, 7)
p <- c(0.2, 0.5, 0.3)
sum(x^2 * p)

## Round Canvas fill-ins to hundredths: round(answer, 2)
