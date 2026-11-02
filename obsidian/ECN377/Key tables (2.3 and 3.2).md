# Key tables: 2.3 and 3.2

★ Professor flagged these on Nov 2 as **the two most important tables for Chapters 2–3**. Know them cold.

## Table 2.3 — reading slopes with logs
| Model | y side | x side | Read β₁ as | R |
|---|---|---|---|---|
| level-level | y | x | Δy = β₁·Δx | `lm(y ~ x)` |
| level-log | y | log(x) | Δy = (β₁/100)·%Δx | `lm(y ~ log(x))` |
| log-level | log(y) | x | %Δy = (100·β₁)·Δx | `lm(log(y) ~ x)` |
| log-log | log(y) | log(x) | %Δy = β₁·%Δx (elasticity) | `lm(log(y) ~ log(x))` |

Rule: a log on the LEFT → percent change in y. A log on the RIGHT → percent change in x.

## Table 3.2 — direction of omitted-variable bias
Leave x₂ out → simple slope β̃₁ is biased by **β₂ · δ̃₁** (δ̃₁ = slope of x₂ on x₁).

|  | corr(x₁, x₂) > 0 | corr(x₁, x₂) < 0 |
|---|---|---|
| **β₂ > 0** | upward (+), overstates | downward (−), understates |
| **β₂ < 0** | downward (−), understates | upward (+), overstates |

Same signs → too big. Opposite signs → too small. No bias if β₂ = 0 or corr = 0.

```r
coef(lm(wage ~ educ + exper, data = wage1))["exper"]   # beta2 =  0.0701 (+)
cor(wage1$educ, wage1$exper)                           # corr  = -0.2995 (-)
coef(lm(wage ~ educ, data = wage1))["educ"]            # 0.5414 < 0.6443: biased DOWN
```
Lessons: [[Lesson 2 - Unbiasedness, OVB, standard errors]]
