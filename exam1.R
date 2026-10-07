## ECN 377 Exam I lookup. Wed Oct 7, 2026. Open notes. Round to the hundredths.
## Run the next two lines once. Ctrl+F the equation as written on the question.
## Spaces and * both work. First hit is the block to run. FIRST lines start with CLICK.
## MIDDLE is one equation: formula, then the SET lines, then r2(). Run that block only.
## LAST10 matches Problem Set 7. Each block stands alone.
## Day 13 is marked NOT ON EXAM I at the bottom of this file.
##
## Fast searches: y = b0 + b1 x    Dy = b1 Dx    %Dx = 100*(x_new-x_old)/x_old
##   Var(X) = E[X^2]-(E[X])^2    b1 = cov(x,y)/var(x)    uhat = y - yhat
##   R^2 = 1-SSR/SST    lm(wage ~ educ    wagehat = b0 + b1*educ

r2 <- function(z) {
  z <- as.numeric(z)
  z[abs(z) < 1e-8] <- 0
  formatC(round(z, 2), format = "f", digits = 2)
}
library(wooldridge)


## ============================================================
## FIRST. Multiple choice and true or false. No calculator.
## ============================================================

## positive residual = UNDER-predicted
## Uhat > 0    hat U_i > 0    actual > fitted
## CLICK: positive residual = UNDER-predicted. Actual y is above the fitted value.

## negative residual
## Uhat < 0    hat U_i < 0    actual < fitted
## CLICK: A negative residual means over-predicted. Actual y is below the fitted value.

## residual uhat actual minus fitted
## uhat = y - yhat    hat u = y - hat y    Uhat = Y - Yhat    hat U_i = Y_i - hat Y_i
## CLICK: The residual equals actual y minus the fitted value.

## fitted value prediction at that x
## yhat = b0 + b1*x    Yhat_i = b0_hat + b1_hat * X_i    hat Y_i = hat beta_0 + hat beta_1 X_i
## CLICK: The fitted value is the model's prediction of y at that x. It is not the actual y.

## intercept affect change true false
## y = b0 + b1 x    y=b0+b1 x    Dy = b1 Dx    the intercept b0 affects the change Dy
## CLICK: False. The intercept does not affect the change in y when x changes.

## prediction keeps the intercept
## yhat = b0 + b1*x    predict y at x    keep b0
## CLICK: A prediction keeps the intercept. A change drops the intercept.

## rises by is a change not a level
## Delta x = 2    Dx = 2    rises by 2
## CLICK: "Rises by 2" is a change of 2, not a level of 2.

## y when x is 0 intercept
## b0 is y when x = 0    Y = b0 + b1*X + U
## CLICK: The intercept is predicted y when every x is 0.

## For y = b0 + b1 X1 + b2 X2, the coefficient b1 is
## y=b0+b1 X1+b2 X2    y = b0 + b1*X1 + b2*X2
## CLICK: b1 is the effect of X1 on y, holding X2 fixed. Not the intercept.

## ceteris paribus holding other factors fixed
## CLICK: Ceteris paribus means holding other factors fixed.

## beta greek letter not B
## CLICK: The slope letter is the Greek letter beta, not a Latin B.

## correlation causation confounding ice cream
## CLICK: False. A strong correlation does not prove that x causes y. Correlation means two variables move together. Causation means changing one changes the other.

## correlation is not causation summer confounder
## CLICK: Ice cream and drownings rise together because summer drives both. Summer is the confounder.

## education wages ability family ambition
## CLICK: A strong education-wage correlation does not prove education causes higher wages. Ability, family, and ambition can confound.

## percentage point versus percent change old value
## %Dx = 100*(x_new-x_old)/x_old    percentage points = new - old
## CLICK: A percentage-point change is new minus old. A percent change is 100 * (new - old) / old. Divide by the old value, not the new value.

## proportion percent multiply divide 100
## CLICK: Proportion to percent: multiply by 100. Percent to proportion: divide by 100.

## probability table not a list
## E[X] = sum(x*p)    do not use mean() or var() on a table
## CLICK: A list of observed points is a sample: use mean(), var(), sd(), cov(), cor(). A probability table weights each value by p. Use sum(value * p). Do not call var() or cov() on a table. Check that the probabilities add to 1.

## sample variance standard deviation divide n-1
## Sx^2 = 1/(n-1)*sum(xi-xbar)^2    Sx = sqrt(Sx^2)
## CLICK: True. The sample variance and the sample standard deviation divide by n - 1. var() and sd() already do that. Do not divide again.

## mean sum length same true
## xbar = (1/n)*sum xi    x-bar = (1/n)*sum xi
## CLICK: True. mean(x) gives the same result as sum(x) / length(x).

## c() hist() not the mean
## CLICK: c() only makes a vector. hist() draws the shape. Neither one computes the mean.

## move together covariance sign
## Sxy    S_xy    sample covariance
## CLICK: If two variables move together, the sample covariance is positive. If one rises while the other falls, the sample covariance is negative.

## correlation between -1 and 1 no units
## rho = Sxy/(Sx*Sy)    Cor(X,Y) = Cov(X,Y)/(sd(X)*sd(Y))
## CLICK: Correlation is always between -1 and 1, and it has no units. Close to -1 is a strong negative relationship. Close to +1 is a strong positive relationship (height and weight). Covariance is harder to read because it depends on the scale of the variables.

## correlation uncorrelated independent
## Corr(a1*X+b1, a2*Y+b2) = Corr(X,Y)    Cov(X,Y)=0
## CLICK: Correlation 0 means uncorrelated. Independent implies uncorrelated, and independent implies covariance 0. An added shift does not change correlation when both scale factors are positive: Corr(a1*X + b1, a2*Y + b2) = Corr(X, Y) if a1 > 0 and a2 > 0.

## E[X] expected value probability weighted
## E[X] = sum(x*p)    E[c] = c
## CLICK: E[X] equals the sum of each value times its probability. Not mean() on a table. E[c] = c. A constant comes out unchanged.

## E[g(X)] function of X square first
## E[g(X)] = sum(g(x)*p)
## CLICK: E[g(X)] weights g(x) by the probability. For g(x) = x^2, square the values first, then multiply by p.

## E[X^2] not the square of the mean
## E[X^2] = sum(x^2*p)    E[X^2] is not (E[X])^2
## CLICK: E[X^2] is not (E[X])^2. Square each value, then weight by p.

## Var(X) = E[X^2] - (E[X])^2
## Var(X) = E[X^2] - E[X]^2    Var(X) = E[(X-E[X])^2]
## CLICK: Var(X) = E[X^2] - (E[X])^2. Square the mean only in the second term. Also Var(X) = E[(X - E[X])^2]. Variance is always greater than or equal to 0.

## 0 1 variable X squared equals X
## X^2 = X    E[X^2] = E[X]
## CLICK: For a 0/1 variable, X^2 = X, so E[X^2] = E[X].

## added constant expectation keeps it variance drops it
## E[aX+b] = a*E[X]+b    Var(aX+b) = a^2*Var(X)
## CLICK: An added constant stays in the expectation: E[aX + b] = a*E[X] + b. An added constant does not change the variance: Var(aX + b) = a^2 * Var(X).

## independent Var(X+Y) covariance 0
## Var(X+Y) = Var(X)+Var(Y)    Cov(X,Y)=0
## CLICK: If X and Y are independent, Cov(X, Y) = 0 and Var(X + Y) = Var(X) + Var(Y).

## uppercase random variable lowercase realization
## CLICK: Uppercase X is the random variable. Lowercase x is one realization. A discrete random variable takes finitely many values.

## conditional expectation E[Y|X] subpopulation
## E[Y|X=x]    E[Y | X = x]    E[X|X] = X
## CLICK: E[Y | X = x] is the average of Y inside the group where X equals x. It has the same linearity as an ordinary expectation. E[X | X] = X. Mean education among people with 12 years of education is 12.

## conditional mean list versus probability
## E[Y|X=x] = mean(y)    E[Y|X=x] = sum(y*p)
## CLICK: A list of Y values and no probabilities: use mean(y). Values with probabilities: use sum(y * p).

## E[U|X] = 0 zero conditional mean
## E[U|X]=0    E[U | X] = E[U] = 0
## CLICK: E[U | X] = 0 means the average of U does not depend on X. The notes also write E[U | X] = E[U] = 0. It does not mean every U is 0.

## E[U|X] fails ability education
## E[Y|X] = b0 + b1*X    E[Y|X] is not b0+b1*X if E[U|X] fails
## CLICK: E[U | X] = 0 fails when something inside U moves with X. If U is ability, average ability has to be the same at every education level. If ability rises with education, the assumption fails, and E[Y | X] is not b0 + b1*X.

## omitted other factors in U
## Y = b0 + b1*X + U    Dy = b1*Dx if DU = 0
## CLICK: U is every factor other than X that affects Y. If those other factors do not change, the change in U is 0, so the change in Y is b1 times the change in X.

## dependent explanatory error
## Y = b0 + b1*X + U    y = b0 + b1 x + u
## CLICK: Y is the dependent variable. X is the explanatory variable. b0 + b1*X is the explained part of Y. U is the error.

## slope versus correlation any number
## CLICK: b1 is the ceteris paribus effect of X on Y. A slope can be any number. A correlation stays between -1 and 1.

## estimate population constants sample hats
## b0_hat    b1_hat    hat beta_0    hat beta_1
## CLICK: b0 and b1 are population constants. We only see a sample, so we estimate them. Estimates wear hats and change from sample to sample.

## OLS least squares minimize SSR
## SSR = sum(uhat^2)    OLS minimizes SSR
## CLICK: OLS means least squares. It chooses the intercept and the slope to minimize the sum of squared residuals. Any other choice gives a bigger SSR.

## OLS slope covariance over variance
## b1 = cov(x,y)/var(x)    b1_hat = cov(x,y)/var(x)
## CLICK: The OLS slope is covariance of x and y, divided by variance of x. Covariance on top. Variance of x on the bottom.

## that same sample new lists
## CLICK: "That same sample" can still print new lists. Use the x and y written in THIS question.

## sum of residuals average of residuals
## sum(uhat) = 0    mean(uhat) = 0    sum_i hat U_i = 0
## CLICK: The sum of the OLS residuals is 0. The average of the OLS residuals is 0. Not SSR. Not 1. Not always positive.

## covariance residuals uncorrelated x
## cov(x, uhat) = 0    sum(x*uhat) = 0
## CLICK: X and the residuals are uncorrelated. Their sample covariance is 0. The sum of x times residual is 0.

## xbar ybar on the line average of y
## (xbar, ybar)    ybar = b0 + b1*xbar    mean(y) = b0 + b1*mean(x)
## CLICK: The point (xbar, ybar) is on the OLS line. The average of y equals b0 + b1 times the average of x.

## explained part fitted unexplained residual
## y = yhat + uhat    Y = Yhat + Uhat
## CLICK: y equals fitted plus residual. The explained part is the fitted value. The unexplained part is the residual.

## SST = SSE + SSR true
## SST=SSE+SSR    SST = SSE + SSR
## CLICK: True. SST = SSE + SSR. SST is total variation in Y. SSE is explained. SSR is unexplained, the squared residuals.

## R^2 fraction explained low common
## R^2 = SSE/SST    R^2 = 1-SSR/SST
## CLICK: R^2 is the fraction of the sample variation in Y explained by X. It is not the slope. It is not always 1. A value near 0 means the line explains little. That is common in economics, and it does not mean the slope is 0.

## R^2 between 0 and 1 perfect fit
## R^2 = 1
## CLICK: R^2 is between 0 and 1. If the line fits perfectly, R^2 = 1.

## cross-section time series panel
## CLICK: Cross-section is many units at one time. Time series is one unit over many times. Panel is many units over many times. All 50 states and every year is panel, not time series.

## population sample true
## CLICK: The population is the whole group you care about. The sample is the part you actually collect. True: you use the sample to learn about the population.

## dataset dollar sign column summary center spread shape
## CLICK: The name in front of $ is whatever you saved with <-. It is not a money sign.
##   wage1$wage is the wage column of the dataset you loaded as wage1.
##   reg <- lm(y ~ x, data = wage1), then:
##   reg$coefficients     both estimates. [1] intercept, [2] slope.
##   reg$fitted.values    the predictions.
##   reg$residuals        actual y minus fitted.
##   summary(reg)$r.squared
## If you named the regression fit instead of reg, write fit$fitted.values. Same for any other name.
## summary() with no $ is the snapshot of every variable. Center, spread, shape: mean(), sd(), hist().

## econometrics economics data statistics
## CLICK: Econometrics combines economics, data, and statistics.

## normal t F distribution names
## CLICK: Know the names normal, t, and F. The t has fatter tails than the normal. The F is nonnegative and right-skewed. The F is not simply a squared normal. Exam I does not ask you to run a t-test or an F-test.

## natural log exp diminishing increasing undo
## exp(log(x)) = x    log(exp(x)) = x
## CLICK: The natural log needs a positive input. As x grows, extra x adds less and less extra y. exp(x) adds more and more. log and exp undo each other.

## AI writes you verify exam off
## CLICK: On practice, AI writes and you verify. AI is off on the exam.


## ============================================================
## MIDDLE. Hand equations. Change the SET lines. Run only that block.
## Ctrl+F the equation copied from the question, then edit SET, then run.
## ============================================================

## x-bar = (1/n) * sum xi
## xbar = (1/n)*sum(xi)
## xbar = (1/n)*sum xi
## sample mean is x-bar = (1/n) * sum xi
## mean = sum(x)/n
x_mean <- c(0, 0, 6, 2, 1)          # SET
r2(sum(x_mean) / length(x_mean))
## TOY: list 0, 0, 6, 2, 1. mean() is the same command.

## x-bar = (1/n)*sum xi    mean when they give the sum and n
## mean = total / n
## A set of n numbers sums to total. Using x-bar = (1/n)*sum xi, find the mean.
total_mean <- 90                    # SET
n_mean <- 5                         # SET
r2(total_mean / n_mean)
## TOY: five numbers that add to 90.

## sum of the observations
## sum xi    sum_{i=1}^{n} x_i    Find sum xi for x = (3, 7, 5)
## sum = x1 + x2 + ... + xn
x_sum <- c(3, 7, 5)                 # SET
sum(x_sum)
## TOY: 3 + 7 + 5 from the first problem set.

## length n how many numbers in the list
## n = length(x)
x_len <- c(2, 5, 7, 10)             # SET
length(x_len)

## %Dx = 100 * (x_new - x_old) / x_old
## %Dx = 100*(x_new-x_old)/x_old
## percent change = 100*(new-old)/old
## Percent change is %Dx = 100*(x_new-x_old)/x_old. Find it when x goes from old to new.
## A polling share goes from 52% to 38%. Divide by the OLD value, 52. The answer is negative.
old_pct <- 20                       # SET
new_pct <- 25                       # SET
r2(100 * (new_pct - old_pct) / old_pct)
## TOY: 20 to 25. Notes: 4 pp to 6 pp divides by 4. Polling 52 to 38 divides by 52, not by 38.

## percentage POINTS. A rate goes from 52% to 38%. What is the change in percentage points?
## percentage points = new - old
## This is not a percent. 52 to 38 is -14 points, not -14 percent.
old_pp <- 3                         # SET
new_pp <- 5                         # SET
r2(new_pp - old_pp)
## TOY: 3 to 5 is 2 points. Notes: 4 pp to 6 pp is 2 points. Polling 52 to 38 is -14 points.

## percent change when the level is already a percent
## %Dx = 100*(x_new-x_old)/x_old
old_rate <- 3                       # SET already in percent, not a decimal
new_rate <- 5                       # SET
r2(100 * (new_rate - old_rate) / old_rate)

## y = b0 + b1*X1 + b2*X2
## y = b0 + b1 X1 + b2 X2
## y=b0+b1 X1+b2 X2
## y = b0 + b1*x1 + b2*x2
## y = b0 + b1 X1 + b2 X2 + b3 X3
## y=b0+b1 X1+b2 X2+b3 X3
## Dy = b1 DX1 + b2 DX2
## Dy = b1*dX1 + b2*dX2
## Dy = b1 DX1 + b2 DX2 + b3 DX3
## Dy = b1 Dx
## Dy = b1 * Dx
## delta y = b1*dx1 + b2*dx2 + b3*dx3
## For y = b0 + b1 X1 + b2 X2, Dy = b1 DX1 + b2 DX2. They print b0. Leave b0 out.
## Example: b0 = 9, b1 = 8, b2 = 8, dX1 = 4, dX2 = -1.
## One slope only: set b2 and dX2 to 0. Three slopes: fill b3 and dX3.
b1_dy <- -9.8                       # SET slope on the variable that changes
b2_dy <- 0.03                       # SET 0 if the question has only one slope
b3_dy <- 0                          # SET
dx1_dy <- 1                         # SET
dx2_dy <- 0                         # SET
dx3_dy <- 0                         # SET
r2(b1_dy * dx1_dy + b2_dy * dx2_dy + b3_dy * dx3_dy)
## TOY: ramen quantity = 120 - 9.8*price + 0.03*income. Price up 1, income fixed. Income down 100 is a change of -100 on the second slope. Price down 2 and income up 300 uses both changes. The 120 never enters.

## b1 = Dy/Dx
## b1 = Dy / Dx
## beta_1 = Dy/Dx
## On a line, when x increases by 3, y increases by 27. Find the slope b1 = Dy/Dx.
## slope = delta y / delta x
dy_rise <- 27                       # SET
dx_run <- 3                         # SET
r2(dy_rise / dx_run)

## y = b0 + b1*x
## y = b0 + b1 x
## y=b0+b1 x
## y = b0 + b1*x1
## yhat = b0 + b1*x + b2*x2
## For y = b0 + b1 x with b0 = 1 and b1 = 7, predict y at x = 1. Keep the intercept.
b0_pred <- 1                        # SET
b1_pred <- 7                        # SET
b2_pred <- 0                        # SET
x_pred <- 1                         # SET
x2_pred <- 0                        # SET
r2(b0_pred + b1_pred * x_pred + b2_pred * x2_pred)
## TOY: b0 = 1, b1 = 7, x = 1.

## predict fraction type the slash
## yhat = b0 + b1*x
## E[colGPA | hsGPA] = 15/10 + (3/10)*hsGPA
b0_frac <- 15/10                    # SET
b1_frac <- 3/10                     # SET
x_frac <- 36/10                     # SET
r2(b0_frac + b1_frac * x_frac)
## TOY: type 15/10, not a rounded decimal.

## colGPA hsGPA 1.5 + 0.5 conditional mean line
## E[y|x] = b0 + b1*x
## E[Y|X=x] = b0 + b1*x
## E[colGPA | hsGPA] = 1.5 + 0.5*hsGPA
b0_gpa <- 1.5                       # SET
b1_gpa <- 0.5                       # SET
x_gpa <- 3.6                        # SET
r2(b0_gpa + b1_gpa * x_gpa)
## TOY: notes, hsGPA 3.6. For hsGPA 3.0, change x_gpa only.

## Sx^2 = 1/(n-1) * sum (xi - x-bar)^2
## Sx^2 = 1/(n-1)*sum(xi-xbar)^2
## sample variance = sum((x-mean(x))^2)/(n-1)
## Compute the sample variance for x = (3, 4, 5). Divide by n - 1.
x_svar <- c(3, 4, 5)                # SET
r2(var(x_svar))
## TOY: var() already divides by n-1. Notes also work (2, 1, 3): mean 2, squared deviations 0, 1, 1, divide by 2.

## Sx = sqrt(Sx^2)
## sample sd is Sx = sqrt(Sx^2)
## sd = sqrt(sample variance)
x_ssd <- c(9, 2, 2)                 # SET
r2(sd(x_ssd))

## standard deviation from a variance they already gave you
## sd(X) = sqrt(Var(X))
## sd = sqrt(variance)
var_given <- 10                     # SET
r2(sqrt(var_given))

## Sxy = 1/(n-1) * sum (xi - x-bar)(yi - y-bar)
## Sxy = 1/(n-1)*sum(xi-xbar)(yi-ybar)
## S_xy = cov(x, y)
## sample covariance = sum((x-xbar)*(y-ybar))/(n-1)
x_scov <- c(2, 2, 0)                # SET
y_scov <- c(4, 4, 2)                # SET
r2(cov(x_scov, y_scov))
## TOY: cov() already divides by n-1. Notes table x = (7, 0, 8), y = (1, 1, 4).

## rho = Sxy / (Sx * Sy)
## rho = Sxy/(Sx*Sy)
## correlation = Sxy / (Sx * Sy)
sxy_cor <- 4                        # SET
sx_cor <- 3                         # SET
sy_cor <- 2                         # SET
r2(sxy_cor / (sx_cor * sy_cor))

## sample correlation from two lists cor
## Cor(X,Y) = Cov(X,Y)/(sd(X)*sd(Y))
## correlation = cov(x,y)/(sd(x)*sd(y))
x_cor <- c(3, 4, 7)                 # SET
y_cor <- c(3, 6, 7)                 # SET
r2(cor(x_cor, y_cor))

## E[X] = sum(x * p)
## E[X] = sum(x*p)
## A random variable X takes the values 1, 2, 3 with probabilities 0.2, 0.5, 0.3. Find E[X].
## "takes the values" and "with probabilities" means a probability table. Do not use mean().
x_ex <- c(1, 2, 3)                  # SET
p_ex <- c(0.2, 0.5, 0.3)            # SET
if (abs(sum(p_ex) - 1) > 1e-6) warning("probabilities do not sum to 1")
r2(sum(x_ex * p_ex))
## TOY: values 1, 2, 3. A fair die is 1 through 6, each with probability 1/6.

## E[aX+b] = a*E[X]+b
## E[aX+bY] = a*E[X]+b*E[Y]
## E[aX+bY+c] = a*E[X]+b*E[Y]+c
## E[aX+bY-c] = a*E[X]+b*E[Y]-c
## E[4X+5Y-3]
EX_lin <- 2                         # SET
EY_lin <- 3                         # SET
a_lin <- 4                          # SET
b_lin <- 5                          # SET
c_lin <- -3                         # SET the constant, with its sign
r2(a_lin * EX_lin + b_lin * EY_lin + c_lin)
## TOY: notes, E[4X + 5Y - 3] with E[X] = 2 and E[Y] = 3.

## E[X^2] = sum(x^2 * p)
## E[X^2] = sum(x^2*p)
## For that same distribution, find E[X^2]. Square the values first, then weight by the probabilities.
x_ex2 <- c(1, 2, 3)                 # SET
p_ex2 <- c(0.2, 0.5, 0.3)           # SET
if (abs(sum(p_ex2) - 1) > 1e-6) warning("probabilities do not sum to 1")
r2(sum(x_ex2^2 * p_ex2))

## Var(X) = E[X^2] - (E[X])^2
## Var(X) = E[X^2] - E[X]^2
## Var(X) from E[X^2] and E[X]
EX_pv <- 4                          # SET
EX2_pv <- 83                        # SET
r2(EX2_pv - EX_pv^2)

## Var(X) from a probability table
## Var(X) = E[X^2]-(E[X])^2
x_pv <- c(1, 2, 3)                  # SET
p_pv <- c(0.2, 0.5, 0.3)            # SET
if (abs(sum(p_pv) - 1) > 1e-6) warning("probabilities do not sum to 1")
EX_pvtab <- sum(x_pv * p_pv)
EX2_pvtab <- sum(x_pv^2 * p_pv)
r2(EX2_pvtab - EX_pvtab^2)

## Var(X) = E[(X - E[X])^2]
## Var(X) definition E of squared deviation
x_vdef <- c(0, 1)                   # SET coin faces
p_vdef <- c(1/2, 1/2)               # SET
if (abs(sum(p_vdef) - 1) > 1e-6) warning("probabilities do not sum to 1")
EX_vdef <- sum(x_vdef * p_vdef)
r2(sum((x_vdef - EX_vdef)^2 * p_vdef))
## TOY: notes coin. The standard deviation is the square root of this variance.

## Var(aX+b) = a^2*Var(X)
## Var(aX + b) = a^2 * Var(X)
VarX_scale <- 4                     # SET
a_scale <- 2                        # SET
r2(a_scale^2 * VarX_scale)

## Cov(X,Y) = E[XY] - E[X]*E[Y]
## Cov(X,Y) = E[XY]-E[X]*E[Y]
## Given E[XY], E[X], and E[Y], find Cov(X, Y).
EXY_cv <- 17                        # SET
EX_cv <- 1                          # SET
EY_cv <- 3                          # SET
r2(EXY_cv - EX_cv * EY_cv)

## Cov(X,Y) joint probability table
## E[XY] = sum(x*y*p)
## Cov = E[XY] - E[X]*E[Y]
x_jcv <- c(1, 0, 0)                 # SET
y_jcv <- c(2, 2, 1)                 # SET
p_jcv <- c(1/3, 1/3, 1/3)           # SET
if (abs(sum(p_jcv) - 1) > 1e-6) warning("probabilities do not sum to 1")
EX_jcv <- sum(x_jcv * p_jcv)
EY_jcv <- sum(y_jcv * p_jcv)
EXY_jcv <- sum(x_jcv * y_jcv * p_jcv)
r2(EXY_jcv - EX_jcv * EY_jcv)
## TOY: do not call cov() on a table. Notes 0/1 table uses joint probabilities 0.4, 0.1, 0.1, 0.4. Multiply x * y * p on each row, then add.

## joint table asks only for E[X]
## E[X] = sum(x * p)
x_ign <- c(1, 5, 1)                 # SET
p_ign <- c(0.2, 0.3, 0.5)           # SET
if (abs(sum(p_ign) - 1) > 1e-6) warning("probabilities do not sum to 1")
r2(sum(x_ign * p_ign))

## Cov(a1*X + b1, a2*Y + b2) = a1*a2*Cov(X,Y)
## Cov(a1X+b1, a2Y+b2) = a1*a2*Cov
Cov_scale <- -1                     # SET
a1_scale <- 3                       # SET
a2_scale <- 5                       # SET
r2(a1_scale * a2_scale * Cov_scale)

## Cor(X,Y) = Cov(X,Y)/(sd(X)*sd(Y))
## Cor = Cov / (sdX * sdY)
Cov_pcor <- 3                       # SET
sdX_pcor <- 3                       # SET
sdY_pcor <- 3                       # SET
r2(Cov_pcor / (sdX_pcor * sdY_pcor))

## Var(X+Y) = Var(X)+Var(Y)
## independent Var(X+Y)
VarX_ind <- 6                       # SET
VarY_ind <- 6                       # SET
r2(VarX_ind + VarY_ind)
## TOY: only if the question says independent.

## Var(aX+bY) = a^2*Var(X) + b^2*Var(Y) + 2*a*b*Cov(X,Y)
## Var(aX + bY) = a^2*Var(X)+b^2*Var(Y)+2*a*b*Cov(X,Y)
a_lv <- 3                           # SET
b_lv <- 3                           # SET
VarX_lv <- 6                        # SET
VarY_lv <- 5                        # SET
Cov_lv <- 0                         # SET
r2(a_lv^2 * VarX_lv + b_lv^2 * VarY_lv + 2 * a_lv * b_lv * Cov_lv)

## E[Y|X=x] = mean(y)
## E[Y | X = x] = mean(y)
## conditional expectation list of y values
y_cm <- c(1, 3, 5, 10)              # SET the y values inside the subgroup
r2(mean(y_cm))

## E[Y|X=x] = sum(y*p)
## E[Y | X = x] = sum(y * p)
## conditional expectation probability weights
y_cmw <- c(9, 9, 9)                 # SET
p_cmw <- c(0.2, 0.3, 0.5)           # SET
if (abs(sum(p_cmw) - 1) > 1e-6) warning("probabilities do not sum to 1")
r2(sum(y_cmw * p_cmw))

## E[aY+b|X=x] = a*E[Y|X=x]+b
## E[aY + b | X = x] = a*(conditional mean)+b
cond_lin <- 2                       # SET
a_cml <- 3                          # SET
b_cml <- 9                          # SET
r2(a_cml * cond_lin + b_cml)

## Var(Y|X=x) = var(y)
## Var(Y | X = x) = var(y)
y_cv <- c(1, 3, 5, 10)              # SET
r2(var(y_cv))
## TOY: a list uses the sample variance, divide by n-1.

## Var(Y|X=x) = E[Y^2|X=x] - (E[Y|X=x])^2
## Var(Y | X = x) = E[Y^2 | X = x] - (E[Y | X = x])^2
y_cvt <- c(1, 2, 3)                 # SET
p_cvt <- c(0.2, 0.5, 0.3)           # SET
if (abs(sum(p_cvt) - 1) > 1e-6) warning("probabilities do not sum to 1")
EY_cvt <- sum(y_cvt * p_cvt)
EY2_cvt <- sum(y_cvt^2 * p_cvt)
r2(EY2_cvt - EY_cvt^2)
## TOY: do not call var() on this table.

## b1 = cov(x,y)/var(x)
## b1_hat = cov(x,y)/var(x)
## hat beta_1 = cov(x,y)/var(x)
## OLS slope from covariance and variance
cov_b1 <- 4                         # SET
var_b1 <- 7                         # SET
r2(cov_b1 / var_b1)

## b1 = cov(x,y)/var(x)
## hat beta_1 = sum((Xi-Xbar)(Yi-Ybar))/sum((Xi-Xbar)^2)
## b1 = sum((x-xbar)*(y-ybar))/sum((x-xbar)^2)
## For the sample x = (1, 2, 3), y = (2, 2, 5), find the OLS slope.
x_b1 <- c(1, 2, 3)                  # SET this question only
y_b1 <- c(2, 2, 5)                  # SET this question only
r2(cov(x_b1, y_b1) / var(x_b1))

## beta1 = Cov(X,Y)/Var(X)
## population slope from a joint table, not cov()/var()
## beta1 = Cov / Var    Var(X) = E[X^2]-(E[X])^2
x_popb1 <- c(3, 1, 6)               # SET
y_popb1 <- c(7, 0, 0)               # SET
p_popb1 <- c(0.2, 0.3, 0.5)         # SET
if (abs(sum(p_popb1) - 1) > 1e-6) warning("probabilities do not sum to 1")
EX_pop <- sum(x_popb1 * p_popb1)
EY_pop <- sum(y_popb1 * p_popb1)
EXY_pop <- sum(x_popb1 * y_popb1 * p_popb1)
EX2_pop <- sum(x_popb1^2 * p_popb1)
r2((EXY_pop - EX_pop * EY_pop) / (EX2_pop - EX_pop^2))
## TOY: PS5 table. Do not call cov() or var() on this table.

## b0 = ybar - b1*xbar
## b0_hat = ybar - b1_hat * xbar
## hat beta_0 = Ybar - hat beta_1 * Xbar
## OLS intercept from ybar xbar and b1
ybar_b0 <- 10                       # SET
xbar_b0 <- 8                        # SET
b1_b0 <- 7/10                       # SET
r2(ybar_b0 - b1_b0 * xbar_b0)

## b0 = ybar - b1*xbar
## b0 = mean(y) - b1*mean(x)
## For that same sample x = (1, 2, 3), y = (2, 2, 5), find the OLS intercept. Use the lists in THIS question.
x_b0 <- c(1, 2, 3)                  # SET this question's x, not the previous question
y_b0 <- c(2, 2, 5)                  # SET this question's y, not the previous question
b1_b0s <- cov(x_b0, y_b0) / var(x_b0)
r2(mean(y_b0) - b1_b0s * mean(x_b0))

## yhat = b0 + b1*x
## hat y = hat beta_0 + hat beta_1 x
## Yhat = b0_hat + b1_hat * X
## A fitted line is yhat = 5 + (2/10)*x. Find the fitted value at x = 15.
b0_fit <- 5                         # SET
b1_fit <- 2/10                      # SET
x_fit <- 15                         # SET
r2(b0_fit + b1_fit * x_fit)
## TOY: type 2/10, not 2.

## fitted value from a sample at a new x
## yhat = b0 + b1 * x_new
## fit the OLS line yhat = b0 + b1 x and predict yhat at x = 3
x_fs <- c(1, 2, 3)                  # SET
y_fs <- c(2, 2, 5)                  # SET
xnew_fs <- 4                        # SET the x they say to predict at
b1_fs <- cov(x_fs, y_fs) / var(x_fs)
b0_fs <- mean(y_fs) - b1_fs * mean(x_fs)
r2(b0_fs + b1_fs * xnew_fs)

## uhat = y - yhat
## hat u = y - hat y
## Uhat = Y - Yhat
## hat U_i = Y_i - hat Y_i
## A fitted line is yhat = 4 + (1/2)*x. A person has x = 6 and actual y = 5. Find the residual.
## residual = actual y - fitted
b0_res <- -0.90                     # SET
b1_res <- 0.54                      # SET
x_res <- 12                         # SET
y_res <- 9                          # SET actual y
fit_res <- b0_res + b1_res * x_res
r2(y_res - fit_res)

## Delta yhat = b1 * Delta x
## Dyhat = b1 * Dx
## Delta hat y = hat beta_1 * Delta x
## A fitted slope is b1 = 7/10. Using Dyhat = b1*Dx, find the predicted change when x rises by 1.
b1_dhat <- 7/10                     # SET
dx_dhat <- 1                        # SET
r2(b1_dhat * dx_dhat)

## SSR = sum((Y - Yhat)^2)
## SSR = sum(uhat^2)
## For the fitted line yhat = 2 + (4/10)*x and the points (3,10),(5,14),(9,11), find SSR.
b0_ssrp <- 2                        # SET
b1_ssrp <- 4/10                     # SET
x_ssrp <- c(3, 5, 9)                # SET
y_ssrp <- c(10, 14, 11)             # SET
yhat_ssrp <- b0_ssrp + b1_ssrp * x_ssrp
r2(sum((y_ssrp - yhat_ssrp)^2))

## sum of residuals and average of residuals
## sum(uhat) = 0    mean(uhat) = 0
x_sumr <- c(1, 2, 3)                # SET
y_sumr <- c(2, 2, 5)                # SET
u_sumr <- resid(lm(y_sumr ~ x_sumr))
r2(sum(u_sumr))
r2(mean(u_sumr))

## covariance between x and the residuals
## cov(x, uhat) = 0
x_covr <- c(1, 2, 3)                # SET
y_covr <- c(2, 2, 5)                # SET
u_covr <- resid(lm(y_covr ~ x_covr))
r2(cov(x_covr, u_covr))

## ybar = b0 + b1*xbar
## average of y on the line b0 + b1 * xbar
b0_ybar <- 44/10                    # SET
b1_ybar <- 7/10                     # SET
xbar_ybar <- 8                      # SET
r2(b0_ybar + b1_ybar * xbar_ybar)

## xbar ybar lies on the fitted line
## mean(y) = b0 + b1*mean(x)
x_on <- c(1, 2, 3)                  # SET
y_on <- c(2, 2, 5)                  # SET
fit_on <- lm(y_on ~ x_on)
r2(mean(y_on))
r2(unname(coef(fit_on)[1]) + unname(coef(fit_on)[2]) * mean(x_on))

## SSE = SST - SSR
## SSE = SST-SSR
SST_sse <- 200                      # SET
SSR_sse <- 150                      # SET
r2(SST_sse - SSR_sse)

## R^2 = 1 - SSR/SST
## R^2 = 1-SSR/SST
SST_r <- 200                        # SET
SSR_r <- 150                        # SET
r2(1 - SSR_r / SST_r)

## unexplained fraction SSR/SST
## unexplained = SSR/SST
## What fraction of the variation in Y is UNEXPLAINED?
SST_un <- 200                       # SET
SSR_un <- 150                       # SET
r2(SSR_un / SST_un)

## R^2 = SSE/SST
## R^2 = SSE / SST
SSE_r2 <- 60                        # SET
SST_r2 <- 315                       # SET
r2(SSE_r2 / SST_r2)

## SSR = SST*(1-R^2)
## SSR = SST * (1 - R^2)
SST_fromr <- 358                    # SET
R2_fromr <- 50/100                  # SET
r2(SST_fromr * (1 - R2_fromr))

## R^2 from a sample SST and SSR
## R^2 = 1 - SSR/SST
## SST = sum((y-ybar)^2)    SSR = sum((y-yhat)^2)
x_r2 <- c(1, 2, 3)                  # SET
y_r2 <- c(2, 2, 5)                  # SET
yhat_r2 <- fitted(lm(y_r2 ~ x_r2))
SST_s <- sum((y_r2 - mean(y_r2))^2)
SSR_s <- sum((y_r2 - yhat_r2)^2)
r2(1 - SSR_s / SST_s)

## SST = (n-1)*sy^2
## SST = (n - 1) * sy^2
n_sst <- 3                          # SET
sy2_sst <- 3                        # SET sample variance of y from this question
r2((n_sst - 1) * sy2_sst)
## TOY: y = (2, 2, 5) has n = 3 and sample variance 3. Type the n and the variance from this question.

## SSE = (n-1)*syhat^2
## SSE = (n - 1) * syhat^2
n_sse <- 10                         # SET
syhat2_sse <- 4                     # SET sample variance of the fitted values
r2((n_sse - 1) * syhat2_sse)

## SSR = (n-1)*suhat^2
## SSR = (n - 1) * suhat^2
n_ssru <- 10                        # SET
suhat2_ssr <- 4                     # SET sample variance of the residuals
r2((n_ssru - 1) * suhat2_ssr)

## exp(log(x)) = x    log(exp(x)) = x
c(exp(log(3)), log(exp(3)))


## dollar sign $ fitted.values coefficients residuals r.squared what goes in front
## The name in front of $ is the object you already saved.
## Dataset column: wage1$wage
## After reg <- lm(y ~ x, data = wage1):
##   reg$coefficients[1]     intercept
##   reg$coefficients[2]     slope
##   reg$fitted.values       predictions
##   reg$residuals           actual minus fitted
##   summary(reg)$r.squared  R^2
## Swap reg for whatever name is on the left of <-.

## ============================================================
## LAST10. Same 10 moves as Problem Set 7.
## library(wooldridge) is the startup line above. Run it once before these.
## Change the dataset name, the column names, and the numbers. Keep the commands.
## ============================================================

## L1 how many workers are in the wage1 sample nrow
## n = nrow(data)
## nrow(wage1)
data(wage1)                                      # SET dataset name
nrow(wage1)                                      # SET same name
## TOY: wage1 only.

## L2 sample mean of hourly wage
## mean(wage1$wage)
## mean of the column
data(wage1)                                      # SET
r2(mean(wage1$wage))                             # SET dataset$column
## TOY: wage1$wage only.

## L3 sample standard deviation years of education wage1$educ sd
## sd(wage1$educ)
## sd of the column
data(wage1)                                      # SET
r2(sd(wage1$educ))                               # SET dataset$column
## TOY: wage1$educ only.

## L4 OLS slope lm wage on educ coefficients[2] ignore the name
## lm(wage ~ educ, data = wage1)
## b1 <- reg$coefficients[2]
## hat beta_1    slope = unname(reg$coefficients[2])
data(wage1)                                      # SET
reg_l4 <- lm(wage ~ educ, data = wage1)          # SET y ~ x and the dataset
r2(unname(reg_l4$coefficients[2]))
## TOY: wage1 only. The name printed above the number is not the answer.

## L5 OLS intercept coefficients[1]
## b0 <- reg$coefficients[1]
## hat beta_0    intercept = unname(reg$coefficients[1])
data(wage1)                                      # SET
reg_l5 <- lm(wage ~ educ, data = wage1)          # SET the same formula as L4
r2(unname(reg_l5$coefficients[1]))
## TOY: wage1 only. It can be negative.

## L6 predicted hourly wage keep the intercept
## wagehat = b0 + b1*educ
## wage = b0 + b1*educ
## predicted = b0 + b1 * x_level
data(wage1)                                      # SET
reg_l6 <- lm(wage ~ educ, data = wage1)          # SET
b0_l6 <- unname(reg_l6$coefficients[1])
b1_l6 <- unname(reg_l6$coefficients[2])
x_level_l6 <- 14                                 # SET the level in the question
r2(b0_l6 + b1_l6 * x_level_l6)
## TOY: wage1 at educ 14 only.

## L7 predicted wage change when education rises delta educ
## Delta wage = b1 * Delta educ
## Delta wagehat = b1 * Delta educ
## Dyhat = b1 * Dx
data(wage1)                                      # SET
reg_l7 <- lm(wage ~ educ, data = wage1)          # SET
b1_l7 <- unname(reg_l7$coefficients[2])
delta_x_l7 <- 2                                  # SET the change, not a level
r2(b1_l7 * delta_x_l7)
## TOY: wage1, education rises by 2, only.

## L8 sum of squared residuals SSR reg$residuals^2
## SSR = sum(reg$residuals^2)
## SSR = sum(uhat^2)
data(wage1)                                      # SET
reg_l8 <- lm(wage ~ educ, data = wage1)          # SET
r2(sum(reg_l8$residuals^2))
## TOY: wage1 only.

## L9 R^2 = 1 - SSR/SST r.squared decimal
## R^2 = 1-SSR/SST
## SST = sum((y-ybar)^2)
## SST <- sum((wage1$wage - mean(wage1$wage))^2)
## summary(reg)$r.squared
data(wage1)                                      # SET
reg_l9 <- lm(wage ~ educ, data = wage1)          # SET
y_l9 <- wage1$wage                               # SET the y column
SSR_l9 <- sum(reg_l9$residuals^2)
SST_l9 <- sum((y_l9 - mean(y_l9))^2)
r2(1 - SSR_l9 / SST_l9)
r2(summary(reg_l9)$r.squared)
## TOY: wage1 only. Decimal, not a percent. The two lines match.

## L10 birth weight cigarettes cigs ounces bwght second regression new name
## lm(bwght ~ cigs, data = bwght)
## Delta bwght = b1 * Delta cigs
## delta = slope * change, and the regression must use a new name
data(bwght)                                      # SET the new dataset
reg2 <- lm(bwght ~ cigs, data = bwght)           # SET y ~ x, new name
b1_l10 <- unname(reg2$coefficients[2])
delta_x_l10 <- 5                                 # SET
r2(b1_l10 * delta_x_l10)
## TOY: bwght only. It can be negative.


## ============================================================
## NOT ON EXAM I
## Oct 5 study guide: units of measurement, and logs inside a regression.
## The challenge mean where x equals one number is not on the exam either.
## ============================================================

## NOT ON EXAM I units of measurement salary dollars thousands
## CLICK: NOT ON EXAM I. If Y is multiplied by c, the intercept and the slope both multiply by c. R^2 stays the same.
old_slope_y <- 18.50                # SET their slope, not this toy
y_mult <- 1000                      # SET 1000 when Y goes from thousands to dollars
r2(old_slope_y * y_mult)
## TOY: NOT ON EXAM I. Copy the R^2 printed in the question. It does not move.

## NOT ON EXAM I roe decimal x divided by 100
## CLICK: NOT ON EXAM I. If X is divided by 100, the slope multiplies by 100. The intercept stays. R^2 stays.

## NOT ON EXAM I log inside a regression log(wage) education percent
## log(wage) = b0 + b1*education + U
## CLICK: NOT ON EXAM I. log(wage) = b0 + b1*education + U. Then b1 is about a percent change: percent change in wage is about 100 * b1 * delta education.

## NOT ON EXAM I challenge exactly equal to one number
## mean(y[x == that number])
## CLICK: NOT ON EXAM I. Problem Set 7 calls mean(y[x == that number]) a challenge. Loh said that one will not be on the exam.
