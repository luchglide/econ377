#!/usr/bin/env python3
"""Generate ~500 reworded exam-style questions with acceptable block tags.
Rewording styles mirror Exam I vs PS1-PS7: hints removed, steps merged,
directions flipped, new datasets/stories, Canvas copy artefacts."""
import random, csv, sys
R = random.Random(int(sys.argv[1]) if len(sys.argv) > 1 else 377)
def r(a, b, d=2): return round(R.uniform(a, b), d)
def ri(a, b): return R.randint(a, b)
def pick(*xs): return R.choice(xs)

# ---------- datasets: name -> (description, list of (var, desc)) ----------
DS = {
 "wage1": [("wage","average hourly earnings in dollars"),("educ","years of education"),("exper","years of potential experience"),("tenure","years with current employer"),("female","=1 if female")],
 "ceosal1": [("salary","1990 salary in thousands of dollars"),("roe","return on equity, percent"),("sales","firm sales in millions of dollars")],
 "ceosal2": [("salary","CEO compensation in $1000s"),("ceoten","years as CEO with the company"),("sales","firm sales in millions"),("comten","years with the company")],
 "bwght": [("bwght","birth weight in ounces"),("cigs","cigarettes smoked per day while pregnant"),("faminc","family income in $1000s"),("motheduc","mother's years of education")],
 "gpa1": [("colGPA","college GPA"),("ACT","ACT score"),("hsGPA","high school GPA"),("skipped","lectures missed per week")],
 "vote1": [("voteA","percent of vote for candidate A"),("expendA","A's spending in $1000s"),("expendB","B's spending in $1000s"),("prtystrA","percent of vote for A's party")],
 "hprice1": [("price","house price in $1000s"),("sqrft","square feet"),("bdrms","number of bedrooms"),("lotsize","lot size in square feet"),("assess","assessed value in $1000s")],
 "k401k": [("prate","percent of eligible workers participating"),("mrate","firm match rate"),("age","age of the plan in years"),("totemp","total firm employment")],
 "meap93": [("math10","percent passing the 10th grade math test"),("lnchprg","percent in the school lunch program"),("expend","expenditure per student"),("salary","average teacher salary")],
 "sleep75": [("sleep","minutes of sleep per week"),("totwrk","minutes worked per week"),("educ","years of schooling"),("age","age in years")],
 "attend": [("atndrte","percent of classes attended"),("priGPA","prior cumulative GPA"),("ACT","ACT score"),("final","final exam score")],
 "crime1": [("narr86","number of arrests in 1986"),("pcnv","proportion of prior arrests leading to conviction"),("avgsen","average sentence length in months"),("ptime86","months in prison in 1986")],
 "lawsch85": [("salary","median starting salary"),("LSAT","median LSAT score"),("GPA","median college GPA"),("rank","law school ranking")],
 "rdchem": [("rd","R&D spending in millions"),("sales","firm sales in millions"),("profmarg","profits as a percent of sales")],
 "mlb1": [("salary","1993 season salary"),("years","years in the major leagues"),("gamesyr","games per year in the league")],
 "discrim": [("psoda","price of a medium soda"),("prpblck","proportion black in the zip code"),("income","median family income")],
 "gpa2": [("colgpa","GPA after fall semester"),("sat","combined SAT score"),("hsize","high school graduating class size in 100s")],
}
POS = ["wage1","ceosal1","ceosal2","bwght","gpa1","vote1","hprice1","k401k","meap93","sleep75","attend","crime1","lawsch85","rdchem","mlb1","discrim","gpa2"]

def ds_intro(name, vars_):
    d = dict(DS[name]); desc = "; ".join(f"{v} = {d[v]}" for v in vars_)
    return pick(
        f"Data: {name} ({desc}). ",
        f"Use the {name} data set from the wooldridge package ({desc}). ",
        f"Load {name} ({desc}). ",
        f"In the {name} data, {desc}. ",
        f"Using {name}: ",
        f"Data set {name}. Variables: {desc}. ",
    )
def yx(name, k=1):
    vs = [v for v, _ in DS[name]]
    y = vs[0]; xs = R.sample(vs[1:], min(k, len(vs) - 1)); return y, xs

Q = []
def add(text, tags, kind, style):
    Q.append({"text": text.strip(), "tags": " ".join(tags), "kind": kind, "style": style})

ORD = ["first","second","third","fourth","fifth","10th","25th","100th"]

# ======================= PART III: real data ==========================
for _ in range(12):  # D0 n/mean/sd/cor
    n = pick(*POS); y, (x,) = yx(n); intro = ds_intro(n, [y, x])
    f = pick(f"How many observations are in the sample?", f"What is the sample size?",
             f"What is the average {y} in the sample?", f"Find the sample mean of {x}.",
             f"What is the sample standard deviation of {y}?", f"Compute the sample variance of {x}.",
             f"What is the sample correlation between {y} and {x}?", f"Find the correlation coefficient of {x} and {y}.",
             f"What is the sample covariance between {y} and {x}?")
    add(intro + f + " (round to the hundredths)", ["D0","D13"], "D0 stats", "new dataset")
for _ in range(4):  # dummy share / min / max (coverage)
    n = pick("wage1","hprice1","bwght","sleep75"); y, (x,) = yx(n)
    f = pick(f"What fraction of the workers in wage1 are women (female = 1)?" if n=="wage1" else f"What is the largest value of {y} in the sample?",
             f"What is the median of {y}?", f"How many observations have {x} equal to zero?")
    add(ds_intro(n,[y,x]) + f, ["D0"], "D0 other stat (coverage)", "new stat")
for _ in range(16):  # D1 simple regression pieces
    n = pick(*POS); y, (x,) = yx(n); intro = ds_intro(n, [y, x])
    a = ri(1, 20); b = a + ri(1, 10); row = pick(*ORD)
    f = pick(f"Regress {y} on {x}. What is the slope estimate?",
             f"Estimate {y} = b0 + b1 {x} + u by OLS. Report b0.",
             f"What is the predicted {y} when {x} = {a}, using the OLS line of {y} on {x}?",
             f"Using the simple regression of {y} on {x}, how much does predicted {y} change when {x} goes from {a} to {b}?",
             f"What share of the variation in {y} is explained by {x}? Give a percent.",
             f"Run the OLS regression of {y} on {x}. What is the R-squared?",
             f"After regressing {y} on {x}, what is the residual for the {row} observation?",
             f"What is the sum of squared residuals from the regression of {y} on {x}?",
             f"Compute the explained sum of squares when {y} is regressed on {x}.",
             f"What is the fitted value for the {row} observation in the regression of {y} on {x}?",
             f"If {x} increases by {a}, by how much does the predicted {y} change in the simple regression?")
    add(intro + f, ["D1","D13"], "D1 simple lm", pick("new dataset","no code given"))
for _ in range(8):  # D2 units in data
    n = pick("ceosal1","wage1","hprice1","k401k","meap93","bwght"); y, (x,) = yx(n)
    f = pick(f"Measure {y} in dollars instead of thousands of dollars and rerun the regression of {y} on {x}. What is the new slope?",
             f"Suppose {x} is divided by 100 before running lm({y} ~ {x}). What is the new coefficient on {x}?",
             f"Re-express {y} in cents rather than dollars. What slope do you get from regressing it on {x}?",
             f"Create {x}dec = {x}/100 and regress {y} on {x}dec. Report the slope.")
    add(ds_intro(n,[y,x]) + f, ["D2","S3","U1","U2"], "D2 units data", "flipped")
for _ in range(8):  # D3 log-level data
    n = pick("wage1","ceosal1","hprice1","lawsch85","mlb1"); y, (x,) = yx(n); d = ri(1, 10)
    f = pick(f"Regress log({y}) on {x}. By approximately what percent does {y} change when {x} rises by {d}?",
             f"Estimate lm(log({y}) ~ {x}). What is the approximate percentage effect of {d} more units of {x}?",
             f"Using the natural log of {y} as the dependent variable and {x} as the regressor, interpret a {d}-unit increase in {x} as a percent.")
    add(ds_intro(n,[y,x]) + f, ["D3","D8","L1","S4"], "D3 log-level data", "hint removed")
for _ in range(7):  # D4 level-log
    n = pick("ceosal1","hprice1","meap93","k401k"); y, (x,) = yx(n); p = ri(1, 25)
    f = pick(f"Regress {y} on log({x}). How much does {y} change when {x} increases by {p}%?",
             f"Estimate {y} = b0 + b1 log({x}) + u. By about how many units does predicted {y} change for a {p} percent rise in {x}?",
             f"Run lm({y} ~ log({x})). What is the predicted change in {y} if {x} goes up {p}%?")
    add(ds_intro(n,[y,x]) + f, ["D4","L3","S4"], "D4 level-log data", "hint removed")
for _ in range(8):  # D5 log-log
    n = pick("ceosal1","hprice1","bwght","rdchem","meap93","discrim"); y, (x,) = yx(n); p = ri(1, 30)
    f = pick(f"Regress log({y}) on log({x}). What is the estimated elasticity of {y} with respect to {x}?",
             f"In the regression of log({y}) on log({x}), by about what percent does {y} change when {x} rises by {p}%?",
             f"Estimate a constant elasticity model of {y} on {x}. If {x} falls by {p} percent, what happens to {y} in percent?")
    add(ds_intro(n,[y,x]) + f, ["D5","L2","S4"], "D5 log-log data", "hint removed")
for _ in range(9):  # D6 sigma-hat, SST_x, se
    n = pick(*POS); y, (x,) = yx(n)
    f = pick(f"Regress {y} on {x}. What is the standard error of the regression, sigma-hat?",
             f"For the regression of {y} on {x}, compute SST_x, the total variation in {x}.",
             f"What is the standard error of the slope on {x}?",
             f"Compute the estimated error variance from the regression of {y} on {x}.",
             f"Using sigma-hat and the total sum of squares of {x}, compute se(b1) by hand for the regression of {y} on {x}.")
    add(ds_intro(n,[y,x]) + f, ["D6","D13","D1"], "D6 se data", "merged steps")
for _ in range(14):  # D7 multiple regression
    n = pick("wage1","hprice1","gpa1","bwght","vote1","sleep75","attend","crime1","lawsch85","k401k","ceosal2","meap93")
    y, xs = yx(n, 2); x1, x2 = xs; a, b = ri(1, 20), ri(1, 20); d = ri(1, 10)
    f = pick(f"Regress {y} on {x1} and {x2}. What is the coefficient on {x1}?",
             f"Estimate {y} = b0 + b1 {x1} + b2 {x2} + u. What is the predicted {y} for {x1} = {a} and {x2} = {b}?",
             f"Holding {x2} fixed, how much does predicted {y} change when {x1} rises by {d}?",
             f"Run lm({y} ~ {x1} + {x2}). Report the intercept.",
             f"Using the regression of {y} on {x1} and {x2}, what is the effect on {y} of {x1} rising by {d} and {x2} falling by {ri(1,5)}?",
             f"What is the R-squared of the regression of {y} on {x1} and {x2}?")
    add(ds_intro(n,[y,x1,x2]) + f, ["D7","D13","D1"], "D7 multiple data", pick("new dataset","merged steps"))
for _ in range(9):  # D8 log(y) multiple
    n = pick("wage1","hprice1","ceosal1","ceosal2","lawsch85","mlb1"); y, xs = yx(n, 2); x1, x2 = xs; d = ri(1, 5)
    f = pick(f"Regress log({y}) on {x1} and {x2}. By about what percent does {y} change when {x1} increases by {d}, holding {x2} fixed?",
             f"Estimate lm(log({y}) ~ {x1} + {x2}). What is the predicted {y} (not log) when {x1} = {ri(1,15)} and {x2} = {ri(1,15)}?",
             f"With log({y}) as the dependent variable and {x1}, {x2} as regressors, what is the percentage effect of {x1} rising by {d} and {x2} rising by 1?")
    add(ds_intro(n,[y,x1,x2]) + f, ["D8","D13","L4","D3"], "D8 log multiple data", "hint removed")
for _ in range(5):  # D9 predicted at means
    n = pick("gpa1","wage1","hprice1","attend"); y, xs = yx(n, 2)
    f = pick(f"Regress {y} on {xs[0]} and {xs[1]}. What is the predicted value of {y} when both regressors are at their sample means?",
             f"Plug the sample averages of {xs[0]} and {xs[1]} into the fitted regression of {y}. What do you get?",
             f"Show that the OLS line passes through the means: compute the fitted {y} at the mean of {xs[0]} and {xs[1]}.")
    add(ds_intro(n,[y]+xs) + f, ["D9","M3","D7"], "D9 at means data", "flipped")
for _ in range(10):  # D10 OVB in data
    n = pick("wage1","bwght","gpa1","meap93","hprice1","attend","sleep75"); y, xs = yx(n, 2); x1, x2 = xs
    f = pick(f"Regress {y} on {x1} alone, then on {x1} and {x2}. How much does the coefficient on {x1} change?",
             f"Regress {x2} on {x1}. What is the slope (delta-tilde)?",
             f"Compute b2 times delta1, where b2 is the {x2} coefficient in the multiple regression and delta1 is the slope from regressing {x2} on {x1}.",
             f"Compare the simple regression slope of {y} on {x1} with the slope when {x2} is added. Is the simple slope larger or smaller?",
             f"Verify formula (3.23) using {y}, {x1} and {x2}: what is the simple regression slope on {x1}?")
    add(ds_intro(n,[y,x1,x2]) + f, ["D10","B1"], "D10 OVB data", "merged steps")
for _ in range(4):  # D11 collinearity
    f = pick("Create totexpend = expendA + expendB and regress voteA on expendA, expendB and totexpend. What does R report for totexpend?",
             "Regress voteA on expendA, expendB and their sum. Why is one coefficient NA?",
             "Add a variable that equals expendA + expendB to the regression of voteA. What happens to its coefficient?",
             "In hprice1, regress price on sqrft and a new variable sqm = sqrft/10.76. What does R report for sqm?")
    add(f, ["D11","K11"], "D11 collinearity data", "new story")
for _ in range(10):  # D12 t-test in data
    n = pick("wage1","hprice1","gpa1","bwght","attend","sleep75","meap93","k401k"); y, xs = yx(n, 2); a = pick("5%","1%","10%")
    f = pick(f"Regress {y} on {xs[0]} and {xs[1]}. What is the t statistic for {xs[1]}?",
             f"Test H0: beta_{xs[0]} = 0 against H1: beta_{xs[0]} > 0 at the {a} level. Do you reject?",
             f"Is {xs[1]} statistically significant at {a} against a one-sided alternative that its effect is negative?",
             f"Compute the t ratio for the coefficient on {xs[0]} and compare it with the {a} one-sided critical value.",
             f"What is the p-value for {xs[1]} in the regression of {y} on {xs[0]} and {xs[1]}?")
    add(ds_intro(n,[y]+xs) + f, ["D12","D13","T1"], "D12 t-test data", "new dataset")
for _ in range(4):  # adjusted R2 in data (coverage)
    n = pick("wage1","hprice1","gpa1"); y, xs = yx(n, 2)
    add(ds_intro(n,[y]+xs) + f"Regress {y} on {xs[0]} and {xs[1]}. What is the adjusted R-squared?", ["D13","D7","D1"], "adj R2 data (coverage)", "new stat")

# ======================= PART II: numbers in the question ==============
for _ in range(14):  # S1 sums of squares, all directions
    sse, ssr, n_, s2, r2 = ri(20, 900), ri(20, 900), ri(10, 90), ri(2, 40), r(0.05, 0.95)
    f = pick(f"A regression has SSE = {sse} and R² = {r2}. Find SSR.",
             f"The explained sum of squares is {sse} and the residual sum of squares is {ssr}. What is the R-squared?",
             f"SST = {sse+ssr} and the model leaves {ssr} unexplained. What fraction of the variation is explained?",
             f"With n = {n_} observations and a sample variance of y of {s2}, what is SST?",
             f"n = {n_}, sample variance of the dependent variable = {s2}, SSR = {ri(5,n_*s2-1)}. Compute R².",
             f"R-squared is {r2} and SSR = {ssr}. What is the total sum of squares?",
             f"What share of the total variation is unexplained if SSE = {sse} and SST = {sse+ssr}?",
             f"Given R2 = {r2} and SST = {sse+ssr}, find the explained sum of squares.")
    add(f, ["S1","O4","O5"], "S1 sums of squares", pick("flipped","hint removed"))
for _ in range(16):  # S2 / V variance family
    sig, n_, sx, ssr = ri(2, 20), ri(8, 60), r(0.5, 4), ri(40, 600)
    xs = sorted(R.sample(range(1, 15), 5))
    f = pick(f"Under SLR.1–SLR.5 with σ = {sig}, n = {n_}, and sample standard deviation of x equal to {sx}, find sd(β̂₁).",
             f"σ² = {sig*sig} and SST_x = {ri(10,200)}. What is the variance of the OLS slope?",
             f"A simple regression on n = {n_} has SSR = {ssr} and SST_x = {ri(10,200)}. What is se(b1)?",
             f"x takes the values {', '.join(map(str,xs))}, and the error standard deviation is {sig}. Find the standard deviation of the slope estimator.",
             f"With {n_} observations and SSR = {ssr}, estimate σ².",
             f"The regression has σ̂ = {sig}, n = {n_} and S_x² = {r(1,9)}. Compute the standard error of β̂₁.",
             f"Using n = {n_}, k = {ri(2,5)} regressors and SSR = {ssr}, what is sigma-hat?",
             f"x = ({', '.join(map(str,xs))}) and SSR = {ssr}. What is se of the slope?")
    add(f, ["S2","V1","V2","V3","V4","V5"], "S2 variance", pick("merged steps","hint removed"))
for _ in range(5):  # V6
    sd = r(0.1, 2)
    f = pick(f"sd(β̂₁) = {sd}. If the sample were {ri(2,9)} times larger with x spread the same way, what would sd(β̂₁) become?",
             f"A researcher quadruples the sample size. If the current standard error of the slope is {sd}, roughly what will it be?",
             f"Doubling n (same spread in x) changes sd(b1) = {sd} to what?")
    add(f, ["V6","S2"], "V6 bigger sample", "flipped")
for _ in range(7):  # V7 VIF
    r2j = r(0.1, 0.95); sig = ri(2, 15); sst = ri(20, 300)
    f = pick(f"In a multiple regression, σ² = {sig*sig}, SST_1 = {sst}, and regressing x1 on the other regressors gives R² = {r2j}. Find Var(β̂₁).",
             f"R_j² = {r2j}. What is the variance inflation factor?",
             f"The R-squared from regressing x2 on all other explanatory variables is {r2j}. How much larger is Var(b2) than it would be with uncorrelated regressors?",
             f"σ = {sig}, SST_j = {sst}, R_j² = {r2j}. Compute sd(β̂_j).")
    add(f, ["V7","S2"], "V7 VIF", "hint removed")
for _ in range(12):  # S3 / U units
    b0, b1 = r(-5, 20), r(0.01, 5); c = pick(10, 100, 1000, 12)
    f = pick(f"ŷ = {b0} + {b1}x. If y is re-measured in thousands (divided by 1000), what are the new intercept and slope?",
             f"The fitted line is y = {b0} + {b1}x with x in dollars. If x is measured in thousands of dollars instead, what is the new slope?",
             f"log(y) = {b0} + {b1} x. If y is measured in cents rather than dollars, what is the new intercept?",
             f"log(salary) = {b0} + {b1} log(sales), salary in $1000s. If salary were in dollars, what would the intercept be?",
             f"y = {b0} + {b1} log(x). If y is multiplied by {c}, what happens to the slope?",
             f"Interest rates are recorded as decimals rather than percents (divided by 100). The old slope was {b1}. What is the new slope?",
             f"Tenure is re-measured in months instead of years. The log-level slope was {b1}. What is the new slope?",
             f"After multiplying x by {c}, the slope becomes {round(b1/c,4)}. What was the original slope?")
    add(f, ["S3","U1","U2","U3","K8"], "S3 units", pick("flipped","hint removed"))
for _ in range(16):  # S4 / L logs
    b = r(0.005, 1.5, 3); d = ri(1, 30)
    f = pick(f"log(wage) = 0.6 + {b}·educ. About how much higher, in percent, is predicted wage for {d} more years of school?",
             f"log(y) = 2.1 + {b} log(x). If x rises {d}%, by how many percent does y change?",
             f"y = 40 + {b*10:.2f} log(x). If x grows by {d} percent, how much does y change?",
             f"A constant-elasticity model gives an estimate of {b}. If the price rises {d}%, what happens to quantity?",
             f"ln(price) = 5 + {b} rooms. Each extra room changes price by roughly what percent?",
             f"The rate rises from {d}% to {d+ri(1,5)}%. What is the percentage change? What is the change in percentage points?",
             f"log(rent) = 1 + {b}·log(income). Interpret {b}.",
             f"In y = β₀ + β₁ ln(x), β̂₁ = {b*30:.1f}. A {d}% increase in x changes y by how much?",
             f"With log(salary) = 4 + {b}·ceoten, compute the exact percent change from {d} more years as CEO.")
    add(f, ["S4","L1","L2","L3","K9","S7"], "S4 logs", "hint removed")
for _ in range(5):  # L4
    f = f"log(ŷ) = 1.1 + {r(0.01,0.1,3)}x₁ − {r(0.01,0.1,3)}x₂. If x₁ rises by {ri(1,5)} and x₂ rises by {ri(1,5)}, about what percent does ŷ change?"
    add(pick(f, f.replace("about what percent does ŷ change", "what is the approximate percentage change in y")), ["L4","S4","S7"], "L4 log multiple", "merged steps")
for _ in range(14):  # S5 / P probability
    ex, ex2 = ri(1, 6), 0; ex2 = ex*ex + ri(1, 20); a, b = ri(-5, 5) or 2, ri(-9, 9)
    vx, vy, cxy = ri(1, 12), ri(1, 12), r(-3, 3)
    vals = sorted(R.sample(range(1, 30), 3)); p1 = r(0.1, 0.5); p2 = r(0.1, 1 - p1 - 0.05)
    f = pick(f"E(X) = {ex}, E(X²) = {ex2}. What is sd({a}X + {b})?",
             f"Var(X) = {vx}, Var(Y) = {vy}, Cov(X,Y) = {cxy}. Compute Var({a}X − {abs(b) or 1}Y).",
             f"Y equals {vals[0]}, {vals[1]} or {vals[2]} with probabilities {p1}, {p2} and {round(1-p1-p2,2)}. Find E(Y) and Var(Y).",
             f"Cov(X,Y) = {cxy}, sd(X) = {r(1,4)}, Var(Y) = {vy}. What is the correlation?",
             f"Use the joint probability table of X and Y below to compute Cov(X, Y). x: 1, 2; y: 0, 1; P = 0.1, 0.3, 0.4, 0.2.",
             f"X has mean {ex} and variance {vx}. Find E[{a}X + {b}] and Var[{a}X + {b}].",
             f"If Var(X) = {vx}, what is the standard deviation of {a}X?",
             f"Given X = x, Y takes values {vals} with probabilities {p1}, {p2}, {round(1-p1-p2,2)}. Find E[{a}Y + {b} | X = x].")
    add(f, ["S5","P1","P2","P3"], "S5 probability", pick("new story","flipped"))
for _ in range(12):  # S6 / O small sample
    xs = R.sample(range(1, 16), 5); ys = [ri(1, 15) for _ in xs]; i = ri(1, 5)
    f = pick(f"For x = ({', '.join(map(str,xs))}) and y = ({', '.join(map(str,ys))}), compute the OLS slope.",
             f"Five observations: x = {xs}, y = {ys}. What is the residual for observation {i}?",
             f"Using the data x = {xs} and y = {ys}, find the intercept of the least squares line.",
             f"Data points (x, y): " + ", ".join(f"({a},{b})" for a, b in zip(xs, ys)) + ". What is R² of the OLS fit?",
             f"For the sample x = {xs}, y = {ys}, compute Σ x_i·û_i after regressing y on x.",
             f"Find the sample correlation between x = {xs} and y = {ys}.",
             f"Find the sample standard deviation of x = ({', '.join(map(str,xs))}).",
             f"Predict y at x = {ri(1,15)} using the OLS line for x = {xs}, y = {ys}.")
    add(f, ["S6","O1","O3"], "S6 small sample", pick("hint removed","new story"))
for _ in range(5):  # O2 missing residual
    res = [r(-3, 3, 1) for _ in range(ri(4, 6))]
    f = pick(f"The OLS residuals from a regression with an intercept are {', '.join(map(str,res))} and one more. Find the last residual.",
             f"{len(res)+1} residuals: {', '.join(map(str,res))}, ?. What must the missing residual be?",
             f"An OLS fit leaves residuals {res} for the first {len(res)} observations. What is the residual of the final observation?")
    add(f, ["O2"], "O2 missing residual", "flipped")
for _ in range(14):  # S7 / M equation
    b0, b1, b2 = r(-5, 10), r(-3, 3), r(-3, 3); a, b = ri(1, 12), ri(1, 12)
    f = pick(f"ŷ = {b0} + {b1}x₁ + {b2}x₂. Predict y when x₁ = {a} and x₂ = {b}.",
             f"colGPA-hat = {b0} + {b1} hsGPA + {b2} ACT. What is the predicted GPA for hsGPA = 3.{ri(0,9)} and ACT = {ri(18,34)}?",
             f"From y-hat = {b0} + {b1}x1 + {b2}x2, how much does y-hat change if x1 rises by {a} while x2 drops by {b}?",
             f"The fitted line is y = {b0} + {b1}x and x-bar = {a}. What is y-bar?",
             f"ŷ = {b0} + {b1}x₁ + {b2}x₂, the mean of x₁ is {a}, and the mean of x₂ is {b}. What is the mean of y?",
             f"wage-hat = {b0} + {abs(b1)} educ + {abs(b2)} exper. Two workers differ by {a} years of education and have the same experience. What is the difference in predicted wage?",
             f"Using price-hat = {b0*10:.1f} + {abs(b1)/10:.3f} sqrft + {abs(b2)*5:.1f} bdrms, what is the estimated effect of adding a {ri(100,400)} square foot bedroom?",
             f"y-bar = {a+5}, x-bar = {a}, and the slope is {b1}. What is the intercept?")
    add(f, ["S7","M1","M2","M3"], "S7 equation", pick("new story","flipped"))
for _ in range(9):  # B1 / B2 OVB numbers
    bt, bh, b2h, d1 = r(-1, 1), r(-1, 1), r(-2, 2), r(-1, 1)
    f = pick(f"The simple regression slope is {bt} and the multiple regression gives b1 = {bh}, b2 = {b2h}. What is the slope from regressing x2 on x1?",
             f"β̂₁ = {bh}, β̂₂ = {b2h}, δ̃₁ = {d1}. What is β̃₁?",
             f"True β₂ = {b2h}; the regression of x₂ on x₁ has slope {d1}. What is the bias in the simple regression slope?",
             f"If β₁ = {bh}, β₂ = {b2h} and δ₁ = {d1}, what is the expected value of the slope when x₂ is omitted?",
             f"Leaving out x2 changes the slope on x1 from {bh} to {bt}. If b2 = {b2h}, what is delta1?",
             f"The short regression slope is {bt}, the long regression slope is {bh}. What is β̂₂·δ̃₁?")
    add(f, ["B1","B2"], "B1/B2 OVB numbers", "flipped")
for _ in range(12):  # T1/T2 t-tests numbers
    b, se, df = r(-2, 2, 3), r(0.05, 1, 3), ri(20, 400); t = r(-4, 4)
    f = pick(f"β̂ = {b}, se = {se}, n = {df+3}, k = 2. Test H₀: β = 0 against H₁: β > 0 at 5%.",
             f"What is the t statistic for H0: beta1 = 1 if the estimate is {b} with standard error {se}?",
             f"With {df} degrees of freedom, what is the 1% critical value for a one-sided test?",
             f"t = {t}, c = 1.68. H1: β₁ < 0. Reject or not?",
             f"Coefficient {b}, standard error {se}. Is it significant at the 10% level against a two-sided alternative?",
             f"A one-tailed test at α = 0.05 with df = {df}: what is the critical value?",
             f"The p-value is {r(0.001,0.2,3)}. At which significance levels do you reject H0?",
             f"An estimate of {b} has t = {t}. What is its standard error?")
    add(f, ["T1","T2"], "T1/T2 t-tests", pick("flipped","merged steps"))
for _ in range(4):  # adjusted R2 / df by formula (coverage)
    f = pick(f"R² = {r(0.1,0.9)}, n = {ri(20,200)}, k = {ri(1,6)}. Compute adjusted R².",
             f"A regression with n = {ri(20,200)} and k = {ri(1,6)} slopes: what are the degrees of freedom for the residuals?",
             f"SSR = {ri(100,900)}, SST = {ri(1000,2000)}, n = {ri(30,90)}, k = 3. What is the adjusted R-squared?")
    add(f, ["S1","T1","S2"], "adj R2 / df formula (coverage)", "new stat")
for _ in range(3):  # confidence interval (after exam, but cheap)
    add(f"β̂₁ = {r(-2,2)}, se = {r(0.1,1)}, df = {ri(25,300)}. Construct a 95% confidence interval for β₁.", ["T3"], "T3 CI", "hint removed")

# ======================= PART I: concepts (MC) =========================
STORIES = [  # (y, x, omitted, sign of effect on y, corr with x)
 ("wage","education","ability","+","+"),("crop yield","fertilizer","land quality","+","+"),
 ("test score","class size","family income","+","-"),("exam score","tutoring hours","prior ability","+","-"),
 ("birth weight","cigarettes smoked","family income","+","-"),("house price","square footage","neighborhood quality","+","+"),
 ("college GPA","hours studied","motivation","+","+"),("crime rate","police officers","city size","+","+"),
 ("health","doctor visits","illness severity","-","+"),("sleep","hours worked","number of young children","-","+"),
 ("earnings","job training","motivation","+","+"),("attendance","distance from campus","owning a car","+","-"),
 ("sales","advertising","product quality","+","+"),("salary","years as CEO","firm size","+","+"),
]
for _ in range(14):  # K2/K12: MLR.4 holds/fails
    y, x, z, s1, s2 = pick(*STORIES)
    f = pick(f"In {y} = β₀ + β₁·{x} + u, {z} is part of u, and {z} is correlated with {x}. Which statement is correct?",
             f"Suppose {z} affects {y} and is left in the error term of a regression of {y} on {x}. If people with more {z} tend to have {'more' if s2=='+' else 'less'} {x}, does E(u|{x}) = 0 hold?",
             f"Which of the following would make the zero conditional mean assumption fail in a regression of {y} on {x}?",
             f"{z} is in the error term and is unrelated to {x}. Is {x} exogenous?",
             f"Why might E(u | {x}) ≠ 0 in a simple regression of {y} on {x}?",
             f"The error term contains {z}, which moves together with {x}. Is the key assumption for unbiasedness satisfied?")
    add(f, ["K2","K12","K3"], "K2/K12 MLR.4", "new story")
for _ in range(12):  # B3/K17 direction stories
    y, x, z, s1, s2 = pick(*STORIES)
    f = pick(f"A researcher regresses {y} on {x} but leaves out {z}. {z.capitalize()} {'raises' if s1=='+' else 'lowers'} {y}, and {z} is {'positively' if s2=='+' else 'negatively'} correlated with {x}. The estimated effect of {x} is most likely:",
             f"Omitting {z} from a regression of {y} on {x}: is the slope biased up or down?",
             f"Will the simple regression of {y} on {x} overstate or understate the true effect, given that {z} is omitted?",
             f"{z.capitalize()} is left out of the {y} equation. Areas with more {z} have {'more' if s2=='+' else 'less'} {x}. Which direction is the bias?",
             f"Leaving out {z}, the coefficient on {x} is expected to be too high or too low?")
    add(f, ["B3","K17","B2"], "B3/K17 direction", "new story")
for _ in range(5):  # B3 abstract sign table
    s1, s2 = pick("positive","negative"), pick("positively","negatively")
    f = pick(f"β₂ is {s1} and x₂ is {s2} correlated with x₁. What is the sign of the bias in β̃₁?",
             f"If corr(x1, x2) is {s2[:-2]}e and beta2 is {s1}, the simple slope is biased which way?",
             f"Using Table 3.2: β₂ {'>' if s1=='positive' else '<'} 0 and Corr(x₁,x₂) {'>' if s2=='positively' else '<'} 0. Upward or downward bias?")
    add(f, ["B3"], "B3 sign table", "hint removed")
for _ in range(5):  # K3
    y, x, z, *_ = pick(*STORIES)
    f = pick(f"In a regression of {y} on {x}, which omitted factor is most likely to cause bias: (a) {z}, (b) the person's ID number, (c) the weather on the survey day, (d) a coin flip?",
             f"Which variable, if left out, would bias the estimated effect of {x} on {y}?",
             f"For omitted-variable bias to arise from leaving out {z}, what two conditions must hold?")
    add(f, ["K3","K15","B3"], "K3 OVB candidate", "new story")
for _ in range(6):  # K4 unbiased meaning
    f = pick("What does it mean for the OLS estimator to be unbiased?",
             "If many researchers each draw their own random sample and estimate β₁, what does unbiasedness imply about their estimates?",
             "E(β̂₁) = β₁ means:",
             "True or false: unbiasedness means the estimate equals the true value in every sample.",
             "A simulation draws 5,000 samples and computes the slope each time. Under SLR.1–SLR.4, what is the average of those slopes close to?",
             "Which property describes the center of the sampling distribution of β̂₁ under the first four Gauss-Markov assumptions?")
    add(f, ["K4"], "K4 unbiased", "hint removed")
for _ in range(4):  # K5
    f = pick("Every observation in the sample has the same value of x. What goes wrong with OLS?",
             "All firms in the sample have the same number of employees. Can you estimate the effect of firm size?",
             "Which assumption fails if the explanatory variable does not vary in the sample?",
             "Why can't we estimate the return to schooling if everyone in the sample has 16 years of education?")
    add(f, ["K5","K11"], "K5 no variation", "new story")
for _ in range(5):  # K6
    f = pick("The variance of the error grows with income. Which assumption is violated, and is OLS still unbiased?",
             "Var(u|x) depends on x. What does this mean for OLS?",
             "The scatter of savings around the regression line fans out at higher incomes. Which statement is true?",
             "Heteroskedasticity is present. Which of the following is correct about β̂₁?",
             "Which assumption says Var(u | x) = σ² for all x?")
    add(f, ["K6","K16"], "K6 heteroskedasticity", "new story")
for _ in range(8):  # K7
    f = pick("Which of the following would increase the standard error of β̂₁?",
             "Holding other things equal, a larger sample size makes Var(β̂₁):",
             "Why is a sample where x is more spread out better for estimating the slope?",
             "Adding a regressor that is highly correlated with x₁ does what to Var(β̂₁)?",
             "Which change makes the slope estimate more precise?",
             "If the error variance doubles, what happens to the variance of the OLS slope?",
             "Select all changes that reduce sd(b1).",
             "What happens to se(β̂₁) when the x values are bunched closely together?")
    add(f, ["K7","V7"], "K7 what changes Var", "hint removed")
for _ in range(7):  # K8 units MC
    f = pick("If y is multiplied by 100, what happens to the slope, intercept and R²?",
             "x is converted from years to months. What happens to the OLS slope in a level-level regression?",
             "In a log-log model, salary is converted from thousands of dollars to dollars. Which coefficient changes?",
             "Changing the units of the dependent variable in log(y) = β₀ + β₁x affects which estimates?",
             "Does R-squared change when x is divided by 1,000?",
             "Temperature is changed from Celsius to Fahrenheit in a regression of energy use on temperature. What happens to the slope?",
             "Income is re-measured in dollars rather than thousands. In y = β₀ + β₁ log(income), what changes?")
    add(f, ["K8","S3","U1","U2","U3"], "K8 units MC", "new story")
for _ in range(8):  # K9 interpretation
    b = r(0.01, 1.5, 3)
    f = pick(f"In log(y) = β₀ + β₁ log(x), β̂₁ = {b}. What does it mean?",
             f"How do you interpret β₁ in y = β₀ + β₁ log(x) + u?",
             f"Which model gives the elasticity of y with respect to x directly?",
             f"In log(wage) = β₀ + β₁ educ, β̂₁ = {b}. Interpret it.",
             f"Which functional form implies a constant percentage effect of a one-unit change in x?",
             f"Match the model to its interpretation: level-level, log-level, level-log, log-log.",
             f"In which model is Δy ≈ (β₁/100)·%Δx?",
             f"A coefficient of {b} in a log-log demand equation means:")
    add(f, ["K9","S4"], "K9 log interpretation", "hint removed")
for _ in range(7):  # K10 algebraic properties
    f = pick("Which of the following always holds for OLS residuals when an intercept is included?",
             "True or false: the sample covariance between the regressors and the OLS residuals is zero.",
             "Does the OLS regression line always pass through the point of sample means?",
             "Which statements about OLS fitted values and residuals are always true? Select all.",
             "Is the sum of the residuals zero if the regression has no intercept?",
             "True or false: the average of the fitted values equals the average of y.",
             "Which is NOT an algebraic property of OLS: (a) residuals sum to 0, (b) cov(x, û) = 0, (c) cov(y, û) = 0, (d) line passes through means?")
    add(f, ["K10","K1"], "K10 properties", "hint removed")
for _ in range(7):  # K11 perfect collinearity
    f = pick("Which of these regressions cannot be estimated because of perfect collinearity?",
             "A model includes income in dollars and income in thousands of dollars. What happens?",
             "Can you include both experience and experience squared in the same regression?",
             "You regress sales on spending on TV ads, spending on radio ads, and total ad spending. What's the problem?",
             "Which assumption rules out an exact linear relationship among the explanatory variables?",
             "Does high but not perfect correlation between two regressors violate MLR.3?",
             "The sample has 4 observations and 5 explanatory variables. Which assumption fails?")
    add(f, ["K11","K16"], "K11 collinearity", "new story")
for _ in range(4):  # K13
    f = pick("Why not include every available variable in a regression?",
             "What is the cost of adding irrelevant variables to a model?",
             "Including an irrelevant variable that is correlated with x1: effect on bias and variance of b1?",
             "Over-controlling: adding a variable that has no effect on y but is correlated with the regressors does what?")
    add(f, ["K13","K7"], "K13 too many vars", "hint removed")
for _ in range(6):  # K14 simple vs multiple, ceteris paribus
    f = pick("In wage = β₀ + β₁ educ + β₂ exper, what does β₁ measure?",
             "Why does the coefficient on cigs change when faminc is added to the birth-weight regression?",
             "What does 'holding other factors fixed' mean for a coefficient in multiple regression?",
             "The simple slope of score on hours is 2.1, and the multiple-regression slope controlling for GPA is 1.4. Interpret the 1.4.",
             "Explain the partialling-out interpretation of β̂₁ in a multiple regression.",
             "When will the simple and multiple regression estimates of β₁ be the same?")
    add(f, ["K14","K15","B1"], "K14 ceteris paribus", "new story")
for _ in range(4):  # K15
    f = pick("Omitting x2 causes no bias in the coefficient on x1 when:",
             "Under what conditions does the simple regression slope equal the multiple regression slope?",
             "If x₂ has no effect on y, does leaving it out bias β̃₁?",
             "Leaving out a variable that is uncorrelated with every included regressor: biased or not?")
    add(f, ["K15","B2","K14"], "K15 no bias", "flipped")
for _ in range(10):  # K16 assumptions / tests
    f = pick("Which assumptions are needed for OLS to be BLUE?",
             "What does the Gauss-Markov theorem say?",
             "What does the normality assumption (MLR.6) add?",
             "Under MLR.1–MLR.6, what is the distribution of (β̂ⱼ − βⱼ)/se(β̂ⱼ)?",
             "A small p-value means:",
             "In a one-sided test H₁: β > 0, when do you reject H₀?",
             "What does 'statistically significant at 5%' mean?",
             "Which assumption is needed for unbiasedness but NOT for Gauss-Markov efficiency?",
             "The t statistic measures:",
             "Which assumptions together are called the classical linear model assumptions?")
    add(f, ["K16","T1","T2"], "K16 assumptions/tests", "hint removed")
for _ in range(4):  # R2 never decreases (coverage)
    f = pick("When another regressor is added, what happens to R-squared?",
             "Why can't you use R² to decide whether to add a variable?",
             "True or false: R² can decrease when you add an explanatory variable.",
             "A low R-squared means the OLS estimates are biased. True or false?")
    add(f, ["K10","K13","K16","S1"], "R2 concept (coverage)", "new concept")
for _ in range(3):  # K1
    f = pick("Four candidate lines are fit to the same data. Line A has Σû = 0 and Σû² = 120; Line B has Σû = 0 and Σû² = 95; Line C has Σû = 3 and Σû² = 80; Line D has Σû = 0 and Σ|û| = 20. Which is the OLS line?",
             "What criterion does OLS minimize?",
             "Why are the OLS estimates called least squares estimates?")
    add(f, ["K1"], "K1 OLS criterion", "hint removed")

def canvas(t):  # mimic MathJax stripped by a Canvas copy: symbols vanish, leaving ( _1 )
    t = re.sub(r"[βσδθ]̂?̃?([₀₁₂ⱼ])?", lambda m: "( _" + {"₀":"0","₁":"1","₂":"2","ⱼ":"j"}.get(m.group(1) or "", "") + " )", t)
    return t.replace("²", "^2").replace("ŷ", "( y )").replace("û", "( u )")
import re
for q in Q:
    if R.random() < 0.25: q["text"] = canvas(q["text"]); q["style"] += "+canvas"
R.shuffle(Q)
w = csv.DictWriter(sys.stdout, fieldnames=["id","text","tags","kind","style","fold"])
w.writeheader()
for i, q in enumerate(Q):
    q["id"] = i + 1; q["fold"] = "dev" if i % 2 == 0 else "test"; w.writerow(q)
print(len(Q), file=sys.stderr)
