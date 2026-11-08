# Wooldridge Ch 2–3: textbook practice with answers

These are the end-of-chapter Problems and Computer Exercises from Wooldridge (the course textbook, Canvas Files), reworded the way an exam asks them.
Each one is in `exam2.R`'s EXAMPLES, so `ASK()` routes it. **Block** is where `ASK()` sends it. Numbers come from the real datasets and are rounded to 2 decimals.

Study tip: cover the Answer column, run ASK() on the question, fill in the block, then check.

| # | Question | Block | Answer |
|---|---|---|---|
| 2.3a | For eight students, GPA = (2.8, 3.4, 3.0, 3.5, 3.6, 3.0, 2.7, 3.7) and ACT = (21, 24, 26, 27, 29, 25, 25, 30). Estimate GPA = b0 + b1 ACT by OLS. What is the slope? | S6 (type the x and y lists) | 0.10 |
| 2.3b | Same eight students. How much higher is the predicted GPA if the ACT score is increased by five points? | S6 (type the x and y lists) | 0.51 |
| 2.3c | Same eight students. What is the predicted value of GPA when ACT = 20? | S6 (type the x and y lists) | 2.61 |
| 2.3d | Same eight students. How much of the variation in GPA is explained by ACT (R-squared)? | S6 (type the x and y lists) | 0.58 |
| 2.4a | bwght-hat = 119.77 - 0.514 cigs. What is the predicted birth weight when cigs = 20 (one pack per day)? | S7 (type the coefficients and the x values) | 109.49 |
| 2.4b | bwght-hat = 119.77 - 0.514 cigs. To predict a birth weight of 125 ounces, what would cigs have to be? | S7 BACKWARDS: s7_yhat <- 125, s7_at <- NA | -10.18 |
| 2.5a | cons-hat = -124.84 + 0.853 inc, with both in dollars. What is the predicted consumption when family income is $30,000? | S7 (type the coefficients and the x values) | 25,465.16 |
| 2.6a | log(price) = 9.40 + 0.312 log(dist), where dist is distance from a garbage incinerator. What does the coefficient 0.312 mean? | K9 | Log-log, so 0.312 is an elasticity: a 1% increase in distance from the incinerator raises predicted price by about 0.312%. |
| 2.7a | sav = b0 + b1 inc + u, where u = sqrt(inc)*e and e is independent of inc. Var(u\|inc) grows with inc. Which assumption fails, and is OLS still unbiased? | K6 | Homoskedasticity (SLR.5) fails, because Var(u|inc) = σ²·inc grows with inc. OLS is **still unbiased**: SLR.1–4 hold. Only the variance formula and the standard errors are wrong. |
| 2.11a | sat = b0 + b1 hours + u, where students choose their hours in an SAT prep course. Which factors in u (like ability or motivation) are likely correlated with hours, and what does that mean for the zero conditional mean assumption? | K2 | Ability, motivation, prior test scores and family income are all in u, and they are likely correlated with hours. So E(u|hours) ≠ 0, SLR.4 (zero conditional mean) fails, and OLS is biased. |
| C2.1a | Data: k401k. Find the average participation rate prate in the sample of plans. | D0 (dataset, column; set d0_by/d0_val for a count or percent) | 87.36 |
| C2.1b | Data: k401k. Find the average match rate mrate in the sample. | D0 (dataset, column; set d0_by/d0_val for a count or percent) | 0.73 |
| C2.1c | Data: k401k. Estimate prate = b0 + b1 mrate by OLS. What is the slope on mrate? | D1 (simple regression on data) | 5.86 |
| C2.1d | Data: k401k. Using the regression of prate on mrate, find the predicted prate when mrate = 3.5. | D1 (simple regression on data) | 103.59 |
| C2.1e | Data: k401k. How much of the variation in prate is explained by mrate? Give a percent. | D1 (simple regression on data) | 7.47% |
| C2.2a | Data: ceosal2 (salary = annual compensation in thousands of dollars; ceoten = prior years as company CEO). Find the average salary in the sample. | D0 (dataset, column; set d0_by/d0_val for a count or percent) | 865.86 |
| C2.2b | Data: ceosal2. How many CEOs are in their first year as CEO (that is, ceoten = 0)? | D0 (dataset, column; set d0_by/d0_val for a count or percent) | 5.00 |
| C2.2c | Data: ceosal2. What is the longest tenure as a CEO (the maximum of ceoten)? | D0 (dataset, column; set d0_by/d0_val for a count or percent) | 37.00 |
| C2.2d | Data: ceosal2. Estimate log(salary) = b0 + b1 ceoten + u. What is the approximate predicted percentage increase in salary given one more year as a CEO? | D3 (log(y) ~ x) | 0.97% |
| C2.3a | Data: sleep75 (sleep = minutes of sleep per week; totwrk = minutes worked per week). Estimate sleep = b0 + b1 totwrk + u. What is the intercept? | D1 (simple regression on data) | 3,586.38 |
| C2.3b | Data: sleep75. Using the regression of sleep on totwrk, if totwrk increases by 2 hours, by how much is sleep estimated to change (in minutes)? | D1 (simple regression on data) | -18.09 |
| C2.4a | Data: wage2 (wage = monthly salary; IQ = IQ score). What is the sample standard deviation of IQ? | D0 (dataset, column; set d0_by/d0_val for a count or percent) | 15.05 |
| C2.4b | Data: wage2. Estimate a simple regression where a one-point increase in IQ changes wage by a constant dollar amount. What is the predicted increase in wage for an increase in IQ of 15 points? | D1 (simple regression on data) | 124.55 |
| C2.4c | Data: wage2. Estimate a model where each one-point increase in IQ has the same percentage effect on wage. If IQ increases by 15 points, what is the approximate percentage increase in predicted wage? | D3 (log(y) ~ x) | 13.21% |
| C2.5a | Data: rdchem (rd = R&D expenditures; sales = annual sales, both in millions). Estimate a constant elasticity model of rd on sales. What is the estimated elasticity of rd with respect to sales? | D5 (log-log elasticity) | 1.08 |
| C2.6a | Data: meap93 (math10 = math pass rate; expend = spending per student). Estimate math10 = b0 + b1 log(expend) + u. If spending increases by 10%, what is the estimated percentage point increase in math10? | D4 (y ~ log(x)) | 1.12 percentage points |
| C2.7a | Data: charity. What is the average gift in the sample (in Dutch guilders)? | D0 (dataset, column; set d0_by/d0_val for a count or percent) | 7.44 |
| C2.7b | Data: charity. What percentage of people gave no gift (gift = 0)? | D0 (dataset, column; set d0_by/d0_val for a count or percent) | 60.00% |
| C2.7c | Data: charity. Estimate gift = b0 + b1 mailsyear + u by OLS. What is the slope on mailsyear? | D1 (simple regression on data) | 2.65 |
| 3.1a | colgpa-hat = 1.392 - 0.0135 hsperc + 0.00148 sat. What is the predicted college GPA when hsperc = 20 and sat = 1,050? | S7 (type the coefficients and the x values) | 2.68 |
| 3.1b | colgpa-hat = 1.392 - 0.0135 hsperc + 0.00148 sat. Students A and B graduated in the same percentile, but A's SAT score was 140 points higher. What is the predicted difference in college GPA? | S7 (type the coefficients and the x values) | 0.21 |
| 3.1c | colgpa-hat = 1.392 - 0.0135 hsperc + 0.00148 sat. Holding hsperc fixed, what difference in SAT scores leads to a predicted colgpa difference of 0.50? | S7 BACKWARDS: s7_dy <- 0.50, s7_dx <- c(0, NA) | 337.84 |
| 3.2a | educ-hat = 10.36 - 0.094 sibs + 0.131 meduc + 0.210 feduc. Holding meduc and feduc fixed, by how much does sibs have to increase to reduce predicted years of education by one year? | S7 BACKWARDS: s7_dy <- -1, s7_dx <- c(NA, 0, 0) | 10.64 |
| 3.2b | educ-hat = 10.36 - 0.094 sibs + 0.131 meduc + 0.210 feduc. Man A has no siblings and his parents each have 12 years of education; Man B has no siblings and his parents each have 16. What is the predicted difference in years of education between B and A? | S7 (type the coefficients and the x values) | 1.36 |
| 3.3a | sleep-hat = 3638.25 - 0.148 totwrk - 11.13 educ + 2.20 age, with sleep and totwrk in minutes per week. If someone works five more hours per week, by how many minutes is sleep predicted to change? | S7 (type the coefficients and the x values) | -44.40 |
| 3.4a | log(salary)-hat = 8.34 + 0.0047 LSAT + 0.248 GPA + 0.095 log(libvol) + 0.038 log(cost) - 0.0033 rank. What is the predicted ceteris paribus difference in salary for schools with a median GPA different by one point? (Report a percentage.) | S4 (log-model % change) | 24.80% |
| 3.4b | log(salary)-hat = 8.34 + 0.0047 LSAT + 0.248 GPA + 0.095 log(libvol) + 0.038 log(cost) - 0.0033 rank. How much is a difference in ranking of 20 worth in terms of predicted starting salary? (Report a percentage.) | S4 (log-model % change) | 6.60% |
| 3.4c | In the law school salary equation, log(salary) includes 0.095 log(libvol). How do you interpret the coefficient on log(libvol)? | K9 | It is an elasticity: holding the other factors fixed, a 1% increase in library volumes raises predicted salary by about 0.095%. |
| 3.5a | GPA = b0 + b1 study + b2 sleep + b3 work + b4 leisure + u, where for every student study + sleep + work + leisure = 168 hours. Why does this model violate MLR.3? | K11 | Perfect collinearity: leisure = 168 − study − sleep − work is an exact linear function of the other regressors, so MLR.3 fails. Drop one of the four (for example, leisure). |
| 3.7a | Which of the following can cause OLS estimators to be biased: heteroskedasticity, omitting an important variable, or a sample correlation of .95 between two included independent variables? | K12 | **Only omitting an important variable.** Heteroskedasticity affects the variance, not the bias. A correlation of .95 is high but not perfect, so MLR.3 still holds and the only cost is a larger variance. |
| 3.8a | avgprod = b0 + b1 avgtrain + b2 avgabil + u. Grants went to firms whose workers have less than average ability, so avgtrain and avgabil are negatively correlated. What is the likely bias in the simple-regression slope of avgprod on avgtrain? | B3 (two-legged table) | β₂ > 0 (ability raises productivity) and Corr(avgtrain, avgabil) < 0, so the bias = β₂δ̃₁ < 0. The simple slope is **biased downward** and understates the effect of training. |
| 3.9a | log(price) = b0 + b1 log(nox) + b2 rooms + u. Rooms raise price, and log(nox) and rooms are negatively correlated. Does the simple regression of log(price) on log(nox) produce an upward or a downward biased estimator of b1? | B3 (two-legged table) | β₂ > 0 (rooms raise price) and Corr(log nox, rooms) < 0, so the bias is negative: a **downward bias** (more negative than the true β₁). |
| 3.9b | Data: hprice2. Regress log(price) on log(nox) alone, then on log(nox) and rooms. What is the simple-regression slope on log(nox)? | D10 (with and without a variable, OVB 3.23) | -1.04 |
| 3.10a | You regress y on x1 alone and on x1, x2, x3. x1 is highly correlated with x2 and x3, and x2 and x3 have small partial effects on y. Would you expect the simple or the multiple regression se of the x1 slope to be smaller? | K7 | The **simple regression se is smaller**. x1 is highly correlated with x2 and x3, so R₁² is large and the VIF inflates Var(β̂₁). Because x2 and x3 barely affect y, they hardly reduce σ̂. |
| 3.12a | growth = b0 + b1 shareP + b2 shareI + b3 shareS + b4 shareF + u, where the four tax shares add up to one. Why must one of the tax share variables be omitted? | K11 | The four shares add to 1, so together they equal the intercept's column of 1s. That is perfect collinearity (MLR.3 fails). Omit one share; it becomes the base group. |
| C3.1a | Data: bwght. Estimate bwght on cigs with and without faminc. What is the slope on cigs in the regression that includes faminc? | D10 (with and without a variable, OVB 3.23) | -0.46 |
| C3.2a | Data: hprice1. Estimate price = b0 + b1 sqrft + b2 bdrms + u. What is the estimated increase in price for a house with one more bedroom, holding square footage constant? | D7 (multiple regression on data) | 15.20 |
| C3.2b | Data: hprice1. Using price on sqrft and bdrms, what is the estimated increase in price for a house with an additional bedroom that is 140 square feet in size? | D7 (multiple regression on data) | 33.18 |
| C3.2c | Data: hprice1. What percentage of the variation in price is explained by square footage and number of bedrooms? | D7 (multiple regression on data) | 63.19% |
| C3.2d | Data: hprice1. The first house in the sample has sqrft = 2,438 and bdrms = 4. Find the predicted selling price for this house from the regression of price on sqrft and bdrms. | D7 (multiple regression on data) | 354.61 |
| C3.2e | Data: hprice1. The actual selling price of the first house was $300,000 (price = 300). Using price on sqrft and bdrms, find the residual for this house. | D13 REG(..., row = 1) | -54.61 |
| C3.3a | Data: ceosal2. Estimate log(salary) on log(sales), log(mktval), profits and ceoten. What is the estimated percentage return for another year of CEO tenure, holding other factors fixed? | D8 (log(y) multiple regression) | 1.17% |
| C3.3b | Data: ceosal2. Estimate a constant elasticity model of salary on sales and market value (log(salary) on log(sales) and log(mktval)). What is the coefficient on log(sales)? | D5 (log-log elasticity) | 0.16 |
| C3.4a | Data: attend (atndrte = percent of classes attended; priGPA = prior GPA; ACT = ACT score). What is the minimum value of atndrte? | D0 (dataset, column; set d0_by/d0_val for a count or percent) | 6.25 |
| C3.4b | Data: attend. Estimate atndrte = b0 + b1 priGPA + b2 ACT + u. What is the predicted atndrte if priGPA = 3.65 and ACT = 20? | D7 (multiple regression on data) | 104.37 |
| C3.4c | Data: attend. Using atndrte on priGPA and ACT: Student A has priGPA = 3.1 and ACT = 21; Student B has priGPA = 2.1 and ACT = 26. What is the predicted difference in their attendance rates (A minus B)? | D7 (multiple regression on data) | 25.84 |
| C3.6a | Data: wage2. Run a simple regression of IQ on educ. What is the slope coefficient (delta-tilde)? | D10 (with and without a variable, OVB 3.23) | 3.53 |
| C3.6b | Data: wage2. Run the multiple regression of log(wage) on educ and IQ. What is the slope on educ? | D10 (with and without a variable, OVB 3.23) | 0.04 |
| C3.7a | Data: meap93. Run the simple regression of math10 on log(expend) and compare with math10 on log(expend) and lnchprg. What is the simple-regression slope on log(expend)? | D10 (with and without a variable, OVB 3.23) | 11.16 |
| C3.8a | Data: discrim (prpblck = proportion black; income = median family income). Find the average value of prpblck in the sample. | D0 (dataset, column; set d0_by/d0_val for a count or percent) | 0.11 |
| C3.8b | Data: discrim. Estimate psoda = b0 + b1 prpblck + b2 income + u. What is the coefficient on prpblck? | D7 (multiple regression on data) | 0.12 |
| C3.8c | Data: discrim. Estimate log(psoda) = b0 + b1 prpblck + b2 log(income) + u. If prpblck increases by .20 (20 percentage points), what is the estimated percentage change in psoda? | D8 (log(y) multiple regression) | 2.43% |
| C3.10a | Data: htv. What percentage of men completed 12th grade but no higher grade (educ = 12)? | D0 (dataset, column; set d0_by/d0_val for a count or percent) | 41.63% |
| C3.10b | Data: htv. Estimate educ = b0 + b1 motheduc + b2 fatheduc + u. How much sample variation in educ is explained by parents' education (R-squared)? | D7 (multiple regression on data) | 0.25 (R² = 24.9%) |

Notes on the trickier ones:
- **2.4b:** cigs = (125 − 119.77)/(−0.514) = −10.18. That is negative, which is impossible, so the model cannot predict a birth weight that high. Wooldridge's point: predictions far outside the data make no sense.
- **2.5a:** −124.84 + 0.853·30000 = 25,465.16 dollars.
- **3.1c:** 0.50 / 0.00148 = 337.84 SAT points.
- **3.2a:** 1 / 0.094 = 10.64 more siblings.
- **3.4b:** 20 × 0.0033 × 100 = 6.6%. A better (lower) rank number means a higher salary.
- **C2.3b:** 2 hours = 120 minutes, so 120 × slope.
- **C3.2b:** 140·b_sqrft + 1·b_bdrms (both change).
- **C3.4b:** the prediction is 104.37%, above 100. That is impossible for an attendance rate, and Wooldridge asks you to notice it.
