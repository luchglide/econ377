# ECN 377 – Exam II study plan (Wed Nov 11, in class, open notes + R, no AI/internet)

Script: `exam2.R`. Run the whole file once before the exam. Every block prints its default answer, so you can confirm it works.

## What's on it (D13, D15–D23)
| Topic | Day | Script tag |
|---|---|---|
| Units of measurement, reading log models | D13 | [C1] [C2] |
| Unbiasedness, omitted-variable bias, sign table, (3.23) | D15, D19 | [C8] [B3] |
| Var / sd / se of OLS, SST_X, σ̂² = SSR/(n−k−1), VIF | D16, D20 | [C5] [C6] [C7] |
| MLR prediction and predicted change, log(y) MLR | D17, D18 | [C3] [C4] [B2] |
| Gauss–Markov, MLR.1–6, t-statistic | D20 | Part D, [C9] |
| One-sided t-tests, critical values | D21 | [C9] [C10] [C11] |
| Two-sided tests, H0: β = a, p-values | D22 | [C9] [C10] [B2 test=] |
| Confidence intervals, the CI/test link | D23 | [C12] [B2] |
| F-test (if covered by D23) | D23 | [C13] [B4] |

## Lessons from Exam I (11.4 / 38, 70 minutes)
- Most lost points were **unanswered**, not wrong. Part III (real data) was nearly all blank or wrong, yet the questions themselves were short: n, a mean, a correlation, a slope, a prediction, a change, R², and a residual.
- `REG()` and `STATS()` now answer all ten Part III questions from Exam I correctly (checked against the Canvas key). **Do Part III first**: one `REG(...)` line per regression.
- Watch the definitions: SSE = **explained**, SSR = **residual**. R² is "% of the variation explained", not "% caused".

## Plan
| When | Do |
|---|---|
| This week | Re-do PS8–PS10 using only the script: find the tag, change the inputs, run. Time yourself. |
| Nov 2–9 | After each class, run that day's D-starter, then the matching script block on new numbers. Do PS11/PS12 as soon as they post. |
| Weekend before | Full mock: PS8–PS12 in one 75-minute sitting, script only. Anything slow, add a comment to the block. |
| Morning of | Pull the repo on the lab PC, open the project, run `exam2.R` once, and check the defaults match. |
