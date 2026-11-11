# ASK()/FIND() routing tests

These scripts check that `ASK()` sends a question to the block that solves it.

- `bank500.csv` holds 500 generated exam-style questions, each with the block tags that count as correct. `genbank.py` produced it.
  The questions are worded the way Exam I reworded PS1–PS7: hints removed, steps merged, directions flipped, new datasets and stories, and Canvas copy artifacts like `( _1 )`.
- `ask_bank_test.R ../exam2.R out.csv` scores the bank.
  The bank is split into dev and test halves: rules were tuned only on the dev half, and the test half measures held-out accuracy.
- `ask_real_loo.R ../exam2.R` scores the 138 real questions (PS8–PS11, Exam I, Mock II).
  Each question is removed from the examples before it is matched, so it can't simply find itself.

Results on Nov 4 (test half / real questions):

| | top 1 | top 2 | top 4 |
|---|---|---|---|
| before (main) | 58% / 70% | 74% / 88% | 83% |
| Nov 4 | 97% / 93% | 99% / 99% | 100% |
| Nov 8 (+ textbook) | 98% / 92% | 99% / 98% | 100% |
| Nov 10 (+ concept notes, what-if V6) | 98% / – | 99% / – | 100% |

Run from this folder:

```
Rscript ask_bank_test.R ../exam2.R out.csv
Rscript ask_real_loo.R ../exam2.R
```

## Textbook bank (Nov 8)

64 Wooldridge Ch 2–3 problems and computer exercises (`../Wooldridge_ch2_ch3_practice.md`). Before the rule fixes, ASK() routed 48/64 top-1 and 55/64 top-2. After them, 64/64 top-1. Those rules were tuned on these items, so that number is not held out. With the 64 items added to EXAMPLES, the real-question leave-one-out score is 200/217 top-1 and 213/217 top-2.

## Concept notes page (Nov 10)

The 70 practice questions on the Exam II concept notes page (Exam I, PS1–PS12, quizzes, study guide) and 11 flipped what-if wordings (sample halved, sigma doubles, target sd, SST_x smaller, R_j^2 rises) were added to EXAMPLES. 64 of the 70 route top-1 to their block. The rest have the right block second, or leave out the Data: line a real question would have. The bank test half is unchanged at 98.0% top-1.
