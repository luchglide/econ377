# ECN 377 – Exam II study plan (Wed Nov 11, in class, open notes + R, no AI/internet)

Script: `exam2.R`. Run the whole file once before the exam. Every block prints its default answer, so you can confirm it works.

## STUDY GUIDE POSTED (Nov 6): what changed
- **Chapter 4 t-tests (Day 22) are NOT on the exam.** Skip the t-test parts of L5, the mocks and the drill. Gauss–Markov (BLUE) is still in.
- **A few questions from before Exam I:** E[X]/Var from a probability table, Var(X + b) = Var(X), population quantity vs sample statistic, sample mean/sd, and the **mean within a group**, e.g. `mean(wage1$wage[wage1$female == 1])` → [D0] group mean.
- **Problem Set 12** (optional): about five exam questions closely follow PS12 problems 2, 4, 6, 9 and 12. See `PS12_questions.md`. Blocks: [S2] given numbers, [D14] se by hand on data, [K18] concepts.
- **Textbook practice:** 64 Wooldridge Ch 2–3 problems and computer exercises, with answers, are in `Wooldridge_ch2_ch3_practice.md`. All 64 are in ASK()'s examples.
- **Before-Exam-I questions** (probability, E/Var/Cov rules, sample stats, OLS by hand, definitions): ASK() now knows all of PS1-PS7 and Quizzes 1-6. New blocks: [S8] quick formulas (mean from a sum, slope from a change, a given line's residual/SSR, cov/var slope, Cov from E[XY], E[aX+bY+c]) and [K19] definitions and R commands. [S6] works with only x given.
- **Lab PC setup:** download the repo ZIP, unzip, open `exam2.R`, press **Source** while you still have internet. It finds its own folder, installs anything missing into a folder you can write to (no prompts), and prints a SETUP CHECK box. Offline it still works from the `data/` copies.
- **Typing help:** run `setup_rstudio.R` once (installs packages, turns on RStudio typo checks, adds Addins > Exam II). In `exam2.R`: `NUMS()` lists every number in the copied question, labelled.
- Study guide sections: units/logs (D13) · unbiasedness, Var(β̂₁) = σ²/SST_X, sd ÷ √k (D15–16) · multiple regression, MLR1–4, MLR3 failures, endogeneity (D17–19) · OVB (3.23) both directions, Table 3.2, the story in words (D19–20) · Var(β̂ⱼ) with R_j², df, σ̂, se by hand in R, Gauss–Markov (D20–21).

## What's on it (updated Nov 2)
On Nov 2 the course schedule shifted one slot: D20 now stops before Gauss–Markov, and two-sided tests, p-values and confidence intervals moved to after the exam. The exam most likely covers **D13 and D15–D22**. If a study guide posts, it decides.

| Class | Topic | Wooldridge | Lesson | Script tag |
|---|---|---|---|---|
| D13 | Units of measurement, logs and functional form | 2.4 | L3 | [U1]–[U3] [L1]–[L4] [D2]–[D5] |
| D15 | Assumptions, unbiasedness, omitted-variable bias (intro) | 2.5, 3.3 | L2 | [K2]–[K6] [B3] |
| D16 | Variances of OLS, standard errors | 2.5 | L2 | [V1]–[V7] [D6] |
| D17–D18 | MLR prediction and predicted change; Example 3.2 | 3.1–3.2 | L4 | [M1]–[M3] [D7] [D8] |
| D19 | Example 3.1, OVB formula (3.23) | 3.2–3.3 | L1 §8, L4 | [B1] [B2] [D10] |
| D20 (Nov 2) | OVB sign table (Table 3.2) in wage1; reading standard errors | 3.3–3.4 | L2 | [B3] [D10] [D11] [K10]–[K15] |
| D21 (Nov 4) | Gauss–Markov, normality, the t-statistic · **Quiz 10 (PS11)** | 3.5, 4.1 | L5 | [K16] [T1] |
| D22 (Nov 9) | One-sided t-tests, critical values | 4.2 | L5 | [T1] [T2] [D12] |
| after the exam | Two-sided tests, p-values, CIs, F-test | 4.2–4.5 | – | [T1]–[T4] (ready if needed) |

## Lessons (interactive, answers save so Claude can see what to reteach)
- L1 Foundations: https://claude.ai/artifact/2wixtDbG5DgR6EBLVvAdAG
- L2 Sampling, unbiasedness, OVB, standard errors, with a simulator: https://claude.ai/artifact/PmkGSC2TyoCZdppG49vQQZ
- L3 Units and logs (Table 2.3): https://claude.ai/artifact/1pdakkuJR57E3C5B5YcRyj
- L4 Multiple regression and OVB (Table 3.2), with multi-step chains: https://claude.ai/artifact/EHwgYo8BiLZArkGbb1SZsp
- L5 Gauss–Markov and one-sided t-tests (the logic questions): https://claude.ai/artifact/9NzVZRGbbs7eBqie6n42TM
- L6 Timed mock Exam II: https://claude.ai/artifact/7BXNAJhL8G87JqaTGnkNDj
- Each of L3–L5 ends with a rewording drill: the same skill asked several ways. Name what's GIVEN and ASKED, then the block, before any math.

## Lessons from Exam I (11.4 / 38, 70 minutes)
- Most lost points were **unanswered**, not wrong. Part III (real data) was nearly all blank or wrong, yet the questions themselves were short: n, a mean, a correlation, a slope, a prediction, a change, R², and a residual.
- Several wrong answers were real outputs of the wrong thing: 526 (wage1's n) for ceosal1's n, and 963.19 (an intercept) for a correlation. **Name what you're solving for before you compute.**
- `REG()` and `STATS()` now answer all ten Part III questions from Exam I correctly (checked against the Canvas key).

## How to take the exam
1. **First 2 minutes:** run `exam2.R` once, top to bottom, and confirm the defaults print.
2. **Real data first (Part 1, [D0]–[D13]).** Each block is one data-question type; change the dataset/formula/numbers and run.
3. **Then formula questions (Part 2).** Type `FIND("words from the question")` in the Console to get the block tag, Ctrl+F it, change only the `# <-- CHANGE` lines, and run the block.
4. **Multiple choice last (Part 3).** The [K] blocks list the answer for each question wording.
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
