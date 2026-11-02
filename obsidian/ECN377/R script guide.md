# R script guide

Files in the econ377 repo:
- `exam2.R`: Exam II script. Run the whole file once; every block prints its default answer.
- `exam1_solutions.R`: every Exam I question solved, in order.
- `quiz9.R`: Quiz 9 / PS10.
- `data/`: CSV copies of the datasets (works with no internet and no wooldridge package).

## exam2.R map (Ctrl+F the tag)
| Tag | Use it for |
|---|---|
| [B0] | one-liners: `nrow(data)`, `mean(data$x)`, `cor(data$x, data$y)` (Exam I Q29–31) |
| [B2a] | the plain `lm()` lines: slope, prediction, change, R², residual of a row (Exam I Q32–36) |
| [B1] | STATS(): n, mean, sd, correlation matrix |
| [B2] | REG(): one call → coefficients, se, t, p, CI, R², SST/SSE/SSR, prediction, change, residual, t-test |
| [B3] | OVB(): simple vs multiple slope, delta, (3.23) check |
| [B4] | FTEST() |
| [C1]–[C13] | hand formulas: logs, units, MLR prediction/change, Var/se, OVB, t-tests, CIs, F |
| Part D | concept answers (MLR.1–6, Gauss–Markov, p-values…) |
| Part E | Exam I refresher |

## Exam I traps, coded
```r
nrow(ceosal1)                       # 209 -- the question's dataset, not wage1 (526)
cor(ceosal1$salary, ceosal1$roe)    # 0.11 -- cor(), never lm(), for a correlation
reg <- lm(wage ~ tenure, data = wage1); b <- reg$coefficients
b[2] * (16 - 3)                     # 2.31 -- a CHANGE drops the intercept
reg$residuals[3]                    # ONE residual; sum(reg$residuals) is always 0
```
