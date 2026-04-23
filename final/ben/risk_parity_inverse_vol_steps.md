# Inverse-volatility weights (naive risk parity)

Short recipe: estimate each asset’s volatility, take weights proportional to $1/\sigma$, then normalize so weights sum to 100%.

## Steps

1. For each asset $i$, compute **annualized volatility** from a return history (e.g. daily simple returns over a window of length $T$), using a square-root-of-time rule to annualize.

2. Assign a **raw weight** proportional to **inverse volatility**, $w_i^\ast \propto 1/\hat{\sigma}_i$, so that riskier assets receive smaller weights.

3. **Normalize** the raw weights so they sum to one: $w_i = w_i^\ast / \sum_j w_j^\ast$.

4. Use the vector $\mathbf{w}$ in the portfolio; with arbitrary correlations, **exact** equal risk budgets need the full covariance matrix (e.g. ERC), but inverse-vol is the standard scalar approximation that “equalizes” risk when dependence is ignored or as a simple rule.

---

## LaTeX (inline with the steps)

**Annualized vol from daily simple returns** (252 trading days per year):

$$
\hat{\sigma}_i = s_i \sqrt{252}
$$

where $s_i$ is the sample standard deviation of daily returns $r_{i,t}$:

$$
s_i = \sqrt{\frac{1}{T-1}\sum_{t=1}^{T}(r_{i,t}-\bar{r}_i)^2}
$$

**Inverse-vol raw weights and normalization:**

$$
w_i^\ast = \frac{1}{\hat{\sigma}_i}, \qquad
w_i = \frac{w_i^\ast}{\sum_{j=1}^{n} w_j^\ast}
= \frac{1/\hat{\sigma}_i}{\sum_{j=1}^{n} 1/\hat{\sigma}_j}
$$

**Feasible portfolio constraint:**

$$
\sum_{i=1}^{n} w_i = 1, \qquad w_i \ge 0
$$

---

## Levered performance (match volatility, then levered return)

1. **Vol-matched leverage** — scale the portfolio so its volatility matches a reference (e.g. a benchmark’s ann. vol) using a **scalar leverage** (same risk on both sides, linear scale of returns & vol in the 1D approximation).

2. **Levered return** — assume extra notional is financed at a rate $R_f$; the return on the **incremental** exposure $(L-1)$ is the **excess** of the strategy over the financing rate. One common shortcut:

$$
L = \frac{\sigma_{\text{ref}}}{\sigma_p}
\qquad\Rightarrow\qquad
\text{example: } L = \frac{17.63\%}{7.15\%}
$$

$$
R_{\text{lev}} = R + (L-1)(R - R_f)
\qquad\Rightarrow\qquad
\text{example: } R_{\text{lev}} = 5.59\% + (L-1)\,(5.59\% - 4\%)
$$

**Symbols (general):**

- $\sigma_{\text{ref}}$ — reference (target) ann. vol (here **17.63%** as an example).
- $\sigma_p$ — unlevered portfolio ann. vol (here **7.15%**).
- $R$ — unlevered portfolio return (here **5.59%**).
- $R_f$ — financing / cash rate (here **4%**).
- $L$ — leverage ratio; $L-1$ is the **extra** exposure financed at $R_f$.

*Note: This matches your two lines numerically. “Same vol” is enforced by the ratio $L=\sigma_{\text{ref}}/\sigma_p$; the return formula is the usual spread on incremental leverage, not a separate model.*

---

*Note: “Each asset’s risk $\approx$ X%” after weighting holds exactly only under a chosen risk measure and model (e.g. marginal contribution to vol using $\Sigma$). Inverse-vol is not full ERC; it is the usual closed-form 1D shortcut.*
