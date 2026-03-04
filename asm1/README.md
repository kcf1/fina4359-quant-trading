# FINA4359 Assignment 1 — Quantitative Trading

MFIN4359 course assignment on asset allocation, smart beta ETFs, and performance benchmarking.

---

## Authors

| Name            | Student ID  |
|-----------------|-------------|
| Tsang Chun Kit  | 3036080288  |
| Tam Pai Lok     | 303592647   |
| Kan Chi Fu      | 3035807902  |

---

## Repository structure

```
asm1/
├── README.md                        # This file
├── requirements.txt                # Python package list
├── fina4359_asm1_code.ipynb        # Main code notebook (all questions)
├── fina4359_asm1_writeup.pdf       # Assignment writeup (methods & discussion)
│
├── damodaran.xlsx                   # Q1: Historical returns by asset class
├── mpf_category_annual_returns.csv # Q1.6: MPF category annual returns
├── FINA4359_SPMO.xlsx              # Q2: SPMO ETF data
├── FINA4359_JMOM_MTUM.xlsx         # Q2: JMOM & MTUM momentum ETF data
├── macro_return.xlsx               # Q3: Global Macro Index returns
└── custom_factors.xlsx             # Q3: Custom factor benchmark data
```

---

## Main deliverables

| File | Description |
|------|-------------|
| **fina4359_asm1_code.ipynb** | Jupyter notebook with all implementations: Q1 (asset allocation), Q2 (smart beta ETFs), Q3 (covariances & performance benchmarking). Run top to bottom; requires data files in the same directory. |
| **fina4359_asm1_writeup.pdf** | Written report: methodology, results, and discussion for the assignment. |

---

## Assignment overview (from code)

### Q1 — Asset allocation

- **1.1** Mean returns, Sharpe ratios, and correlations using Damodaran historical returns (S&P 500, US Small cap, T-Bills, bonds, real estate, gold, etc.).
- **1.2** Comparison of last 30 years vs earlier period; tangent portfolio construction and rolling tangent portfolios.
- **1.6** MPF category analysis using `mpf_category_annual_returns.csv`.

### Q2 — Smart beta ETFs

- SPMO analysis using `FINA4359_SPMO.xlsx`.
- JMOM vs MTUM factor regressions using `FINA4359_JMOM_MTUM.xlsx` (e.g. momentum, size, value).

### Q3 — Sleuthing via covariances & performance benchmarking

- Macro index returns: summary stats, cumulative returns (`macro_return.xlsx`).
- **FF5 benchmark**: Fama–French 5-factor regression (data from Kenneth French’s website).
- **Custom benchmark**: regression on `custom_factors.xlsx`.
- Rolling-window analysis (e.g. 60-month), replicating portfolio, and tracking error.

---

## Packages required

Install with `pip install -r requirements.txt` or:

| Package | Purpose |
|---------|---------|
| `pandas` | Data handling, Excel/CSV I/O |
| `numpy` | Numerical operations |
| `scipy` | Optimization (e.g. `minimize`, `brentq`) |
| `matplotlib` | Plotting |
| `openpyxl` | Reading `.xlsx` files |
| `statsmodels` | Regressions, `RollingOLS` |
| `pandas-datareader` | Fama–French factor data (Q3) |
| `yfinance` | Optional; used in Q3 for data |

**Minimal install:**

```bash
pip install pandas numpy scipy matplotlib openpyxl statsmodels pandas-datareader yfinance
```

---

## How to run the code

1. **Environment**: Python 3 with Jupyter. Install the packages above.
2. **Data**: Place all required data files in the same folder as `fina4359_asm1_code.ipynb` (see Data files below). Q3 fetches Fama–French data from the web.
3. **Execution**: Open `fina4359_asm1_code.ipynb` in Jupyter or Google Colab and run all cells in order.

---

## Data files (required for full run)

| File | Used in |
|------|--------|
| `damodaran.xlsx` | Q1 |
| `mpf_category_annual_returns.csv` | Q1.6 |
| `FINA4359_SPMO.xlsx` | Q2 |
| `FINA4359_JMOM_MTUM.xlsx` | Q2 |
| `macro_return.xlsx` | Q3 |
| `custom_factors.xlsx` | Q3 |

Fama–French 5-factor data are loaded from Kenneth French’s data library inside the notebook.

---

## License & course

Course: **FINA4359 / MFIN4359** (Quantitative Trading).  
This repository is for assignment and learning purposes.
