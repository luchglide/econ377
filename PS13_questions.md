# Problem Set 13

**Canvas quiz:** https://uncw.instructure.com/courses/108656/quizzes/413708  
**Points:** 22 (22 questions, 1 point each)  
**Time limit:** None  
**Allowed attempts:** 2  
**Due:** Fri Nov 20, 2026, 11:59 PM (Canvas: 20 Nov at 23:59)  
**Lock date:** No lock date was shown on the quiz details page.

## Quiz instructions

These are your main practice, and each weekly quiz is drawn straight from that week's set. They're extra credit: score 90%+ and you earn +10% on that week's quiz, with two attempts (higher score counts). You may work with your group and use AI to learn, but you must be able to answer every question yourself.

Quiz 11 (Wed 11/18) is a shorter quiz: seven questions taken from these problems, with new numbers: #1, #3, #4, #7, #14, #17, #20.

## Unnumbered introductory block (Canvas labels it “Spacer”)

Problem Set 13 covers the $t$-statistic, where the $t$ distribution comes from, and one-sided $t$-tests (problems 1–16), plus a few problems that review Exam II (problems 17–22). Quiz 11 (Wed 11/18) will have questions taken from these problems, with new numbers: #1, #3, #4, #6, #7, #8, #9, #14, #16, #17, #20. Round every numeric answer to the hundredths place, and keep unrounded coefficients in R until the last step.

## Questions

### Question 1 — Multiple choice — 1 pt

Under MLR1–MLR6, $(\hat\beta_j-\beta_j)/\mathrm{sd}(\hat\beta_j)$ has a $N(0,1)$ distribution, but $(\hat\beta_j-\beta_j)/\mathrm{se}(\hat\beta_j)$ has a $t$ distribution. Why?

*Hint: $\mathrm{sd}(\hat\beta_j)$ uses $\sigma$; $\mathrm{se}(\hat\beta_j)$ uses $\hat\sigma$. Which of the two changes from sample to sample?*

**Group of answer choices**
- The standard error replaces the unknown $\sigma$ with the estimate $\hat\sigma$, which varies from sample to sample.
- The $t$ distribution applies only when the sample is small.
- $\hat\beta_j$ is not normally distributed when we use the standard error.
- The standard error is always larger than the standard deviation.

### Question 2 — Multiple choice — 1 pt

In the Day 22 simulation, we reran the experiment with larger and larger samples. What happened as $n$ grew?

*Hint: $\hat\beta_1$ is unbiased and its standard deviation shrinks as $n$ grows. The $t$-statistic divides by the standard error.*

**Group of answer choices**
- Neither histogram changed.
- The histogram of $\hat\beta_1$ concentrated around the true $\beta_1$, while the histogram of $t$ kept its width and looked more and more like $N(0,1)$.
- The histogram of $\hat\beta_1$ spread out, while the histogram of $t$ concentrated around 0.
- Both histograms, of $\hat\beta_1$ and of $t=(\hat\beta_1-\beta_1)/\mathrm{se}(\hat\beta_1)$, shrank toward a single value.

### Question 3 — Numeric — 1 pt

A multiple regression with $K=5$ independent variables is estimated on $n=99$ observations. How many degrees of freedom does the $t$-statistic for $\hat\beta_j$ have?

*Hint: $df=n-K-1$: subtract one for each slope and one for the intercept.*

### Question 4 — Numeric — 1 pt

An estimate is $\hat\beta_j=-2.31$ with $\mathrm{se}(\hat\beta_j)=1.09$. Find the $t$-statistic for $H_0:\beta_j=0$. (round to the hundredths)

*Hint: $t=\hat\beta_j/\mathrm{se}(\hat\beta_j)$. It has the same sign as $\hat\beta_j$.*

### Question 5 — Numeric — 1 pt

Data: wage1 (wage = average hourly earnings in dollars; educ, exper and tenure = years of education, experience, and tenure with the current employer). Run reg <- lm(log(wage) ~ educ + exper + tenure, data = wage1) (Example 4.1). Find the $t$-statistic for tenure by dividing its estimate by its standard error. (round to the hundredths)

*Hint: s <- summary(reg)$coefficients is a table with one row per coefficient (intercept first, then educ, exper, tenure). Column 1 is the estimate and column 2 the standard error, so the tenure entries are s[4, 1] and s[4, 2]. Check your answer against s[4, 3].*

### Question 6 — Numeric — 1 pt

For a test of $H_0:\beta_j=0$ against $H_1:\beta_j>0$ at the 5% level with $df=28$, find the critical value $c$. (round to the hundredths)

*Hint: the rejection region is the right tail, so $c$ is the 95th percentile of the $t_{df}$ distribution: qt(0.95, df = ...). The normal cutoff 1.64 is not accepted.*

### Question 7 — Multiple choice — 1 pt

You test $H_0:\beta_j=0$ against $H_1:\beta_j>0$ at the 5% level with $df=25$, so $c=1.71$. The $t$-statistic is $t=1.52$. What do you conclude?

*Hint: against $H_1:\beta_j>0$, reject $H_0$ only if $t>c$.*

**Group of answer choices**
- Fail to reject $H_0$, because $t>0$.
- Reject $H_0$, because $t>0$.
- Fail to reject $H_0$, because $t<c$.
- Reject $H_0$, because $t<c$.

### Question 8 — Numeric — 1 pt

For a test of $H_0:\beta_j=0$ against $H_1:\beta_j<0$ at the 5% level with $df=32$, find the critical value $c$. (round to the hundredths)

*Hint: for $H_1:\beta_j<0$, the rejection region is the left tail, so $c$ is negative: qt(0.05, df = ...).*

### Question 9 — Multiple choice — 1 pt

You test $H_0:\beta_j=0$ against $H_1:\beta_j<0$ at the 5% level with $df=30$, so $c=-1.70$. Two researchers with different samples get $t=-2.10$ and $t=-1.20$. Which conclusions are correct?

*Hint: against $H_1:\beta_j<0$, reject $H_0$ only if $t<c$.*

**Group of answer choices**
- Reject $H_0$ in both cases, because both $t$-statistics are negative.
- Reject $H_0$ when $t=-2.10$; fail to reject when $t=-1.20$.
- Fail to reject $H_0$ when $t=-2.10$; reject when $t=-1.20$.
- Fail to reject $H_0$ in both cases, because a one-sided test rejects only when $t$ is positive.

### Question 10 — Multiple choice — 1 pt

What does a significance level of $\alpha=0.05$ mean?

*Hint: $\alpha$ is chosen before looking at the data. It describes how often the test makes a particular mistake.*

**Group of answer choices**
- The estimate $\hat\beta_j$ is within 5% of $\beta_j$.
- If $H_0$ is true, there is a 5% chance that the test rejects it.
- 95% of the observations fit the regression line.
- There is a 5% chance that $H_0$ is true.

### Question 11 — Numeric — 1 pt

Data: ceosal1 (salary = CEO salary in thousands of dollars; sales = firm sales in millions of dollars; roe = return on equity, in percent). Run reg <- lm(log(salary) ~ log(sales) + roe, data = ceosal1). You want to test $H_0:\beta_{roe}=0$ against $H_1:\beta_{roe}>0$. Find the $t$-statistic for roe. (round to the hundredths)

*Hint: use the “t value” column of summary(reg)$coefficients.*

### Question 12 — Numeric — 1 pt

Data: ceosal1 (salary = CEO salary in thousands of dollars; sales = firm sales in millions of dollars; roe = return on equity, in percent). For the test in problem 11, find the critical value $c$ at the 5% level, using $df=n-K-1$. (round to the hundredths)

*Hint: nrow(ceosal1) gives $n$, and $K=2$. Then qt(0.95, df = ...).*

### Question 13 — Multiple choice — 1 pt

Data: ceosal1 (salary = CEO salary in thousands of dollars; sales = firm sales in millions of dollars; roe = return on equity, in percent). Using problems 11 and 12, what do you conclude at the 5% level?

*Hint: against $H_1:\beta_{roe}>0$, reject $H_0$ only if $t>c$. The size of the coefficient alone does not decide the test.*

**Group of answer choices**
- Reject $H_0$, because the roe coefficient is positive.
- Fail to reject $H_0$, because $t>c$.
- Fail to reject $H_0$, because the roe coefficient (about 0.018) is close to 0.
- Reject $H_0$, because $t>c$: a higher roe is associated with a higher salary, holding sales fixed.

### Question 14 — Numeric — 1 pt

Data: bwght (bwght = birth weight in ounces; cigs = cigarettes the mother smoked per day while pregnant; faminc = family income in thousands of dollars). Run reg <- lm(bwght ~ cigs + faminc, data = bwght). You want to test $H_0:\beta_{cigs}=0$ against $H_1:\beta_{cigs}<0$ at the 1% level. Find the $t$-statistic for cigs. (round to the hundredths)

*Hint: cigs is row 2 of summary(reg)$coefficients, and the “t value” is column 3.*

### Question 15 — Numeric — 1 pt

Data: bwght (bwght = birth weight in ounces; cigs = cigarettes the mother smoked per day while pregnant; faminc = family income in thousands of dollars). For the test in problem 14, find the critical value $c$ at the 1% level, using $df=n-K-1$. (round to the hundredths)

*Hint: the rejection region is the left tail, so $c$ is negative: qt(0.01, df = ...), with $n$ from nrow(bwght) and $K=2$.*

### Question 16 — Multiple choice — 1 pt

Data: bwght (bwght = birth weight in ounces; cigs = cigarettes the mother smoked per day while pregnant; faminc = family income in thousands of dollars). Using problems 14 and 15, what do you conclude at the 1% level?

*Hint: against $H_1:\beta_{cigs}<0$, reject $H_0$ only if $t<c$.*

**Group of answer choices**
- Fail to reject $H_0$, because $t<c$.
- Fail to reject $H_0$, because the cigs coefficient (about $-0.46$ ounces per cigarette) is small.
- Reject $H_0$, because $t<c$: more cigarettes per day are associated with a lower birth weight, holding family income fixed.
- Fail to reject $H_0$, because a one-sided test rejects only when $t$ is positive.

### Question 17 — Numeric — 1 pt

A regression of the number of hours a student studies per week on the student's financial-aid share, measured in percent (so 40 means 40%), has slope 0.049. If the aid share were measured as a decimal instead (so 0.40 means 40%), what would the slope be? (round to the hundredths)

*Hint: measuring $x$ as a decimal divides every $x$ by 100. A one-unit change in the decimal is a 100-point change in the percent.*

### Question 18 — Numeric — 1 pt

Under MLR1–MLR5, a regression has $\mathrm{sd}(\hat\beta_1)=0.74$. If the sample were approximately 4 times as large, with $SST_1$ 4 times as large and $R_1^2$ unchanged, what would $\mathrm{sd}(\hat\beta_1)$ be? (round to the hundredths)

*Hint: $\mathrm{sd}(\hat\beta_1)=\sigma/\sqrt{SST_1(1-R_1^2)}$. $SST_1$ is under a square root.*

### Question 19 — Numeric — 1 pt

Data: wage1 (wage = average hourly earnings in dollars; educ, exper and tenure = years of education, experience, and tenure with the current employer). For reg <- lm(log(wage) ~ educ + exper + tenure, data = wage1) with $X_j$ = tenure, find $R_j^2$, the $R^2$ that enters $\mathrm{se}(\hat\beta_j)=\hat\sigma/\sqrt{SST_j(1-R_j^2)}$. (round to the hundredths)

*Hint: regress tenure on the other independent variables.*

### Question 20 — Numeric — 1 pt

Data: hprice1 (price = house price in thousands of dollars; sqrft = size of the house in square feet; bdrms = number of bedrooms). Run reg <- lm(log(price) ~ log(sqrft) + bdrms, data = hprice1). What is the predicted price of a 2,000-square-foot house with 3 bedrooms (in thousands of dollars)? (round to the hundredths)

*Hint: plug in log(2000), not 2000, and use exp() at the end.*

### Question 21 — Numeric — 1 pt

In the population, $score=\beta_0+\beta_1 hours+\beta_2 job+U$, where hours is weekly study hours, job is weekly hours at a paid job, and $\beta_2=-2.4$. You omit job and regress score on hours alone. The slope from regressing job on hours is $\tilde\delta_1=-0.24$. What is $Bias(\tilde\beta_1)$? (round to the hundredths)

*Hint: $Bias(\tilde\beta_1)=\beta_2\tilde\delta_1$. Keep both signs: a positive bias means the simple-regression slope is pushed upward.*

### Question 22 — Multiple choice — 1 pt

In $score=\beta_0+\beta_1 hours+U$, ability is part of $U$. More able students study more hours (a positive but not perfect correlation). Which statement is correct?

*Hint: MLR3 is about the independent variables in the model. MLR4 is about $U$.*

**Group of answer choices**
- MLR3 and MLR4 both hold, because the correlation is not perfect.
- No assumption fails, because ability is not in the model.
- MLR4 fails, because ability is in $U$ and moves with hours, so $E[U\mid hours]\ne 0$.
- MLR3 fails, because ability and hours are correlated.
