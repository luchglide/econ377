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
| now | 97% / 93% | 99% / 99% | 100% |

Run from this folder:

```
Rscript ask_bank_test.R ../exam2.R out.csv
Rscript ask_real_loo.R ../exam2.R
```
