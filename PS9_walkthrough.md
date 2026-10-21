# ECN 377 – PS9 + PS8 walkthrough (for Quiz 8, Wed 10/21)
Script: `PS9.R` (open the repo as an RStudio project, then Cmd/Ctrl+Shift+Enter). **[QUIZ]** = on the Quiz 8 list.
Round to hundredths. The script now lists the 11 quiz items first. Each block has named input variables (e.g. `q5_pctx`): change them and re-run. Offline: uses the `wooldridge` package if installed, otherwise falls back to `data/ceosal1.csv` and `data/wage1.csv`.
> Prepared scripts are allowed on quizzes (Isaac, in class). No AI and no internet during the quiz, so pull this repo before it starts.

## Table 2.3 cheat sheet (use it for most of these)
| Model | Read the slope as |
|---|---|
| level-level y ~ x | Δy = β1·Δx |
| log-level log(y) ~ x | %Δy ≈ 100·β1·Δx |
| level-log y ~ log(x) | Δy ≈ (β1/100)·%Δx |
| log-log log(y) ~ log(x) | %Δy ≈ β1·%Δx (elasticity) |

Units: if x is multiplied by c, then β1 becomes β1/c. If y is multiplied by c, both β0 and β1 are multiplied by c in level-y models. In log(y) models, only β0 changes, by +log(c).
Variance: Var(β̂1)=σ²/SSTx, sd=σ/√SSTx, SSTx=Σ(xi−x̄)²=(n−1)S²x, σ̂²=SSR/(n−2), se(β̂1)=σ̂/√SSTx.

## PS8 (all three match the Canvas answers ✅)
- **#14 [QUIZ]**: x divided by 1000, so c=1/1000 and the slope becomes 0.58·1000 = **580** ✅
- **#17 [QUIZ]**: log-level, 100·0.02·2 = **4** ✅
- **#19 [QUIZ]**: level-log, (11.3/100)·13 = **1.47** ✅

## PS9
- **Q1 [QUIZ]**: log(1000·salary)=log(1000)+log(salary), so only the intercept shifts (by 6.91). **(c)**
- **Q2**: log-level, Δx=12 months. 100·0.0062·12 = **7.44%**
- **Q3**: new intercept = 3.36 + log(1000) = 3.36 + 6.9078 = **10.27**
- **Q4**: **(a)** log-level
- **Q5 [QUIZ]**: log-log, 0.94·(−8) = **−7.52%** (a fall means %Δx is negative)
- **Q6 [QUIZ]**: `lm(log(salary)~roe, ceosal1)` gives β̂1 = 0.0138626. Then 100·0.0138626·5 = **6.93%**
- **Q7**: `lm(salary~log(sales), ceosal1)` gives β̂1 = 262.9014. Then (262.9014/100)·10 = **26.29** (thousand $)
- **Q8**: unbiased means right on average across samples, so **(d)**
- **Q9 [QUIZ]**: omitted-variable bias needs a variable that (1) affects wage and (2) is correlated with educ. Only ability fits, so **(a)**. The other choices are random or irrelevant.
- **Q10**: no variation in x means SSTx=0, so the slope can't be computed (SLR3). **(d)**
- **Q11**: 66/53 = **1.25**
- **Q12**: SSTx=(6−1)·2=10, so sd = 20/√10 = **6.32** ⚠️ The Canvas text lost the √. With no root, 20/10 = 2.00, but the hint formula and Theorem 2.2 call for √, so the answer is 6.32.
- **Q13 [QUIZ]**: Var = σ²/SSTx, so a bigger SSTx means a smaller variance. **(a)** (A smaller n or a larger σ² raises it, and β0 doesn't matter.)
- **Q14 [QUIZ]**: x̄=6.2, deviations −3.2, −2.2, 0.8, 1.8, 2.8, squares 10.24+4.84+0.64+3.24+7.84 = SSTx 26.80. sd = 6/√26.8 = **1.16**
- **Q15 [QUIZ]**: 268/(14−2) = **22.33**
- **Q16 [QUIZ]**: σ̂=√(437/11)=√39.727=6.30, then se = 6.30/√12 = **1.82**
- **Q17**: the spread grows with income, which is heteroskedasticity. SLR5 fails, the Var formula is invalid, and OLS is still unbiased. **(a)**
- **Q18**: `lm(wage~educ, wage1)` gives σ̂ = √(SSR/524) = **3.38** (matches summary(reg)$sigma)
- **Q19**: `sum((wage1$educ-mean(wage1$educ))^2)` = **4025.43**

## Uncertain / flags
- **Q12** may be uncertain because the √ was lost in transcription (6.32 vs 2.00). 6.32 is the textbook answer.
- Q14 and Q16 also use √ in their hints; they were computed with √, which is the standard formula.
- The quiz uses new numbers. To reuse the script, swap the inputs at the top of each section.
