# ECN 377 – Exam II study plan (Wed Nov 11, in class, open notes + R, no AI/internet)

Script: `exam2.R`. Run the whole file once before the exam. Every block prints its default answer, so you can confirm it works.

## What's on it (updated Nov 2)
On Nov 2 the course schedule shifted one slot: D20 now stops before Gauss–Markov, and two-sided tests, p-values and confidence intervals moved to after the exam. The exam most likely covers **D13 and D15–D22**. If a study guide posts, it decides.

| Class | Topic | Wooldridge | Lesson | Script tag |
|---|---|---|---|---|
| D13 | Units of measurement, logs and functional form | 2.4 | L3 | [C1] [C2] |
| D15 | Assumptions, unbiasedness, omitted-variable bias (intro) | 2.5, 3.3 | L2 | Part D, [C8] |
| D16 | Variances of OLS, standard errors | 2.5 | L2 | [C5] [C6] [C7] |
| D17–D18 | MLR prediction and predicted change; Example 3.2 | 3.1–3.2 | L4 | [C3] [C4] [B2] |
| D19 | Example 3.1, OVB formula (3.23) | 3.2–3.3 | L1 §8, L4 | [C8] [B3] |
| D20 (Nov 2) | OVB sign table (Table 3.2) in wage1; reading standard errors | 3.3–3.4 | L2 | [C8] [B3] [B2] |
| D21 (Nov 4) | Gauss–Markov, normality, the t-statistic · **Quiz 10 (PS11)** | 3.5, 4.1 | L5 | Part D, [C9] |
| D22 (Nov 9) | One-sided t-tests, critical values | 4.2 | L5 | [C9] [C10] [C11] [B2 test=] |
| after the exam | Two-sided tests, p-values, CIs, F-test | 4.2–4.5 | – | [C9] [C12] [C13] (ready if needed) |

## Lessons (interactive, answers save so Claude can see what to reteach)
- L1 Foundations: https://claude.ai/artifact/2wixtDbG5DgR6EBLVvAdAG
- L2 Sampling, unbiasedness, OVB, standard errors, with a simulator: https://claude.ai/artifact/PmkGSC2TyoCZdppG49vQQZ
- L3–L6: units and logs, MLR, t-tests, then a timed mock exam

## Lessons from Exam I (11.4 / 38, 70 minutes)
- Most lost points were **unanswered**, not wrong. Part III (real data) was nearly all blank or wrong, yet the questions themselves were short: n, a mean, a correlation, a slope, a prediction, a change, R², and a residual.
- Several wrong answers were real outputs of the wrong thing: 526 (wage1's n) for ceosal1's n, and 963.19 (an intercept) for a correlation. **Name what you're solving for before you compute.**
- `REG()` and `STATS()` now answer all ten Part III questions from Exam I correctly (checked against the Canvas key).

## How to take the exam
1. **First 2 minutes:** run `exam2.R` once, top to bottom, and confirm the defaults print.
2. **Part III (real data) first.** Write one `REG(...)` line per regression the questions mention, with `at=`, `from=`/`to=`, `row=` and `test=` as needed. Then read each answer off the printout.
3. **Then formula questions (Part II).** Ctrl+F the tag ([C5], [C8], ...), change only the `# <-- CHANGE` lines, and run the block.
4. **Concepts last (Part I).** Part D of the script lists the answers.
5. **Never leave a blank.** A guess can score; a blank can't. If a question takes more than 3 minutes, flag it and move on.
6. Submit the R script at the end for partial credit.

## Plan to Nov 11
| Day | Do |
|---|---|
| Mon Nov 2 | Finish L1 (sections 3–8), then L2. |
| Tue Nov 3 | PS11 (Quiz 10 is drawn from it), using the script and L2. |
| Wed Nov 4 | Quiz 10. Afterwards: L3 (units and logs). |
| Thu–Fri Nov 5–6 | L4 (multiple regression). Redo PS8–PS10 timed, using only the script. |
| Sat–Sun Nov 7–8 | L5 (t-statistic and one-sided tests). |
| Mon Nov 9 | D22 in class. Then L6: a full timed mock exam with exam2.R. |
| Tue Nov 10 | Review only the questions missed on the mock. Rest. |
| Wed Nov 11 | Pull the repo on the lab PC, open the project, run `exam2.R` once, take the exam. |
