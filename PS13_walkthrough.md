# ECN 377 Problem Set 13 — answers ready to enter

Do not submit from here. Quiz: https://uncw.instructure.com/courses/108656/quizzes/413708  
Due Fri Nov 20, 2026, 11:59 PM ET (America/New_York). 22 questions, 1 pt each, 2 attempts, no time limit.  
Round numerics to the hundredths and keep trailing zeros (1.70 not 1.7).

Script: `/workspace/school/ecn377/2026-11-swirl14-ps13/PS13_lucchit.R` (run confirmed, exit 0).  
For Quiz 11 on Wed 11/18, the page says the in-class items are taken from this set with **new numbers**. Use the script blocks and swap the SET values; do not type these PS13 numbers on Quiz 11.

Confidence: High = computed from the given numbers or wooldridge, or a standard definition that matches the hint and (where relevant) the Day 22 class script. Nothing below is a guess.

## Ready to enter

| Q | Type | Enter this | Confidence | Notes |
|---|---|---|---|---|
| 1 | MC | The standard error replaces the unknown σ with the estimate σ-hat, which varies from sample to sample. | High | se uses σ-hat (random); sd uses σ. |
| 2 | MC | The histogram of β-hat_1 concentrated around the true β_1, while the histogram of t kept its width and looked more and more like N(0,1). | High | Matches the Day 22 simulation comments. |
| 3 | Numeric | 93 | High | df = 99 − 5 − 1. Integer; no hundredths needed. |
| 4 | Numeric | -2.12 | High | −2.31 / 1.09. Keep the minus sign. |
| 5 | Numeric | 7.13 | High | wage1, tenure t = estimate/se, matches column 3. |
| 6 | Numeric | 1.70 | High | qt(0.95, 28) = 1.70113… Enter **1.70**, not 1.7 or 1.64. |
| 7 | MC | Fail to reject H0, because t<c. | High | 1.52 < 1.71; right-tailed test. |
| 8 | Numeric | -1.69 | High | qt(0.05, 32) = −1.69389… Keep the minus sign. |
| 9 | MC | Reject H0 when t=-2.10; fail to reject when t=-1.20. | High | Reject only if t < −1.70. |
| 10 | MC | If H0 is true, there is a 5% chance that the test rejects it. | High | Type I error rate. |
| 11 | Numeric | 4.52 | High | ceosal1, roe t value. n = 209. |
| 12 | Numeric | 1.65 | High | qt(0.95, 206) = 1.65228… |
| 13 | MC | Reject H0, because t>c: a higher roe is associated with a higher salary, holding sales fixed. | High | 4.52 > 1.65. |
| 14 | Numeric | -5.06 | High | bwght, cigs t value. Keep the minus sign. n = 1388. |
| 15 | Numeric | -2.33 | High | qt(0.01, 1385) = −2.32904… Keep the minus sign. |
| 16 | MC | Reject H0, because t<c: more cigarettes per day are associated with a lower birth weight, holding family income fixed. | High | −5.06 < −2.33. |
| 17 | Numeric | 4.90 | High | 0.049 × 100. Enter **4.90**, not 4.9. |
| 18 | Numeric | 0.37 | High | 0.74 / sqrt(4). |
| 19 | Numeric | 0.26 | High | R² from tenure ~ educ + exper is 0.25887…; checks against the se formula. |
| 20 | Numeric | 279.89 | High | exp(xb) for 2,000 sq ft and 3 bedrooms. Units are already thousands of dollars; do not enter 279890. |
| 21 | Numeric | 0.58 | High | (−2.4)×(−0.24) = 0.576 → 0.58 (upward bias). |
| 22 | MC | MLR4 fails, because ability is in U and moves with hours, so E[U\|hours]≠0. | High | MLR3 is about the regressors in the model, not U. |

## Flags

No question depended on a data file that could not be obtained. wage1, ceosal1, bwght, and hprice1 all loaded from the wooldridge package, and the Q19 se-formula identity checked out.

Nothing is ambiguous enough to change the selected answer. Small entry cautions only:

- Trailing zeros: Q6 is **1.70**, Q17 is **4.90**.
- Negative signs: Q4, Q8, Q14, Q15.
- Q20 is **279.89** (thousands), not 279,890 dollars.
- Q21 is 0.576 rounded to hundredths, which is **0.58**.
- Quiz 11 on Wed 11/18 uses **new numbers**. The quiz-instructions list is #1, #3, #4, #7, #14, #17, #20; the spacer on the PS13 page also names #6, #8, #9, #16. Swap the SET values in those blocks; do not paste these PS13 figures into Quiz 11.

## Walkthrough

**Q1.** Under MLR1–MLR6, (β-hat − β) divided by the true sd is N(0,1). The standard error replaces the unknown σ with σ-hat, and σ-hat changes from sample to sample, so the ratio follows a t distribution.

**Q2.** The Day 22 simulation (isaaccloh/ECON377 D22) shows that as n grows, the histogram of β-hat_1 tightens around the true slope, while the studentized t = (β-hat_1 − β_1)/se keeps a fixed width and looks more like N(0,1) (t with large df).

**Q3.** df = n − K − 1 = 99 − 5 − 1 = 93.

**Q4.** t = β-hat / se = −2.31 / 1.09 = −2.11927… → −2.12.

**Q5.** `lm(log(wage) ~ educ + exper + tenure, data = wage1)`. Tenure is row 4. t = 0.022067 / 0.003094 = 7.13307… → 7.13.

**Q6.** H1: β > 0, so the right-tail cutoff is qt(0.95, 28) = 1.70113… → 1.70. The hint says not to use 1.64.

**Q7.** Against H1: β > 0, reject only if t > c. 1.52 < 1.71, so fail to reject because t < c. Being positive is not enough.

**Q8.** H1: β < 0, so the left-tail cutoff is qt(0.05, 32) = −1.69389… → −1.69.

**Q9.** Reject only if t < −1.70. −2.10 is farther into the left tail (reject); −1.20 is not (fail to reject). A negative t alone is not enough.

**Q10.** α is the Type I error rate, chosen before looking at the data: if H0 is true, the test rejects it 5% of the time.

**Q11–Q13.** `lm(log(salary) ~ log(sales) + roe, data = ceosal1)`, n = 209, K = 2, df = 206. The roe t-statistic is 4.51878… → 4.52. The 5% right-tail critical value is qt(0.95, 206) = 1.65228… → 1.65. 4.52 > 1.65, so reject H0: a higher roe is associated with a higher salary, holding sales fixed. The size of the coefficient (about 0.018) does not decide the test.

**Q14–Q16.** `lm(bwght ~ cigs + faminc, data = bwght)`, n = 1388, K = 2, df = 1385. The cigs t-statistic is −5.06031… → −5.06. The 1% left-tail critical value is qt(0.01, 1385) = −2.32904… → −2.33. −5.06 < −2.33, so reject H0: more cigarettes per day are associated with a lower birth weight, holding family income fixed.

**Q17.** If aid share is measured as a decimal, every x is divided by 100, so the slope is multiplied by 100: 0.049 × 100 = 4.90. A one-unit change in the decimal is a 100-point change in the percent.

**Q18.** sd(β-hat_1) = σ / sqrt(SST_1 (1 − R_1²)). SST_1 four times as large, with σ and R_1² unchanged, divides the sd by 2: 0.74 / 2 = 0.37.

**Q19.** For X_j = tenure in `log(wage) ~ educ + exper + tenure`, R_j² is the R² from `tenure ~ educ + exper`, which is 0.25887… → 0.26. That R_j² also reproduces the tenure standard error from se = σ-hat / sqrt(SST_j (1 − R_j²)).

**Q20.** `lm(log(price) ~ log(sqrft) + bdrms, data = hprice1)`. Plug in log(2000) and 3 bedrooms, then exp(): exp(−0.62340 + 0.80825·log(2000) + 0.03811·3) = 279.889… → 279.89 (thousands of dollars). The question asks for the simple exp(xb) prediction, not a smearing adjustment.

**Q21.** Bias(β~_1) = β_2 δ~_1 = (−2.4)×(−0.24) = 0.576 → 0.58. Both signs are negative, so the bias is positive (the simple-regression hours slope is pushed upward).

**Q22.** Ability is not a regressor in the model, so this is not an MLR3 (perfect collinearity) problem. Ability is in U and is correlated with hours, so E[U | hours] ≠ 0 and MLR4 fails.
