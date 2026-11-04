# R script guide

Files in the econ377 repo:
- `exam2.R`: Exam II script. Run the whole file once; every block prints its default answer.
- `exam1_solutions.R`: every Exam I question solved, in order.
- `quiz9.R`: Quiz 9 / PS10.
- `data/`: CSV copies of the datasets (works with no internet and no wooldridge package).

## exam2.R map (rebuilt Nov 4 from every PS8–PS11 and Quiz 7–10 question)
**Find a block fast:** in the Console type `FIND("words from the question")`, e.g. `FIND("log percent falls")`. It prints the block tags, best first. Each block starts with **LOOKS LIKE:**, a real question of that type, so you can confirm the match.

| Part | Tags | Question types |
|---|---|---|
| 1 Real data | [D0]–[D13] | n/mean/cor · simple lm (slope, prediction, change, R², residual row, SSE/SSR/SST) · units rerun · log-level / level-log / log-log from data · σ̂, SST_x, se · MLR prediction & change · log(y) MLR % and $ via exp() · prediction at means · OVB in data · perfect collinearity NA · t-test · REG() |
| 2 Numbers given | [U1]–[U3] | rescaling x or y; log(y) intercept + log(c) |
|  | [L1]–[L4] | Table 2.3: log-level, log-log, level-log, log-level MLR |
|  | [M1]–[M3] | MLR prediction, change, ȳ from means |
|  | [O1]–[O5] | residual of obs i, missing residual, Σxû = 0, SSR from SSE & R², SST from n & S² |
|  | [V1]–[V7] | Var(β̂₁), sd/se from σ & S_X, from raw x, σ̂², se from SSR, k× sample, VIF |
|  | [B1]–[B3] | (3.23) solve-any, bias = β₂δ̃₁, direction (Table 3.2) |
|  | [P1]–[P3] | sd(aX+b), Var(aX+bY), Cor from joint table |
|  | [T1]–[T4] | t-tests, decisions, CI, F |
| 3 Multiple choice | [K1]–[K16] | answers keyed to the PS wording (assumptions, OVB stories, units, log interpretation, Var direction, collinearity, testing) |

## Exam I traps, coded
```r
nrow(ceosal1)                       # 209 -- the question's dataset, not wage1 (526)
cor(ceosal1$salary, ceosal1$roe)    # 0.11 -- cor(), never lm(), for a correlation
reg <- lm(wage ~ tenure, data = wage1); b <- reg$coefficients
b[2] * (16 - 3)                     # 2.31 -- a CHANGE drops the intercept
reg$residuals[3]                    # ONE residual; sum(reg$residuals) is always 0
```
