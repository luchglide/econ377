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

Run from this folder:

```
Rscript ask_bank_test.R ../exam2.R out.csv
Rscript ask_real_loo.R ../exam2.R
```

## Textbook bank (Nov 8)

64 Wooldridge Ch 2–3 problems and computer exercises (`../Wooldridge_ch2_ch3_practice.md`). Before the rule fixes, ASK() routed 48/64 top-1 and 55/64 top-2. After them, 64/64 top-1. Those rules were tuned on these items, so that number is not held out. With the 64 items added to EXAMPLES, the real-question leave-one-out score is 200/217 top-1 and 213/217 top-2.

## FORM() (Nov 9)

`Rscript form_test.R ../exam2.R` pre-fills FORM()'s boxes for all 245 questions in EXAMPLES, the way FORM() does, and runs each block. 10 stop with an error. Each of those has a red box: a value the question gives in words the form can't read, for example "birth weight on family income" instead of variable names. Of the 80 textbook questions with known answers, every one that FORM() filled in completely showed the right answer.
