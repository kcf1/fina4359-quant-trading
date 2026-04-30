# Project README: LinkUp Job Posting Data Analysis

Besides the All Weather Portfolio enhancement we presented in class, our group previously explored the LinkUp dataset. Three of us tried different direction and aspect of analysising the dataset, including finding factors, analysing AI related jobs, and sector recruitment relative strength rotation. Attached in the submission our code and this writeup as reference.

## ai_job.ipynb

### 1. Aggregate Recruitment Trend (Macro View)
- **Scope**: Top 100 firms by posting volume (most data‑rich).
- **Method**: For each firm, monthly count of all postings; summed across firms to create a synthetic aggregate time series.
- **Visualization**: Line chart of total active job postings over time, with a vertical marker for the COVID‑19 shock (March 2020).
- **Insight**: Illustrates the overall hiring cycle and the dramatic pandemic‑era disruption.

### 2. O*NET-Based Skill Segmentation
- **Classification**: Using the 8‑digit **ONET code**:
  - **Tech** (O*NET 15‑000000 – Computer & Mathematical Occupations)
  - **Non‑Tech** (all other codes)
- **Process**: Applied across the top 100 firms; aggregated to monthly totals.
- **Output**:
  - **Absolute volume plot** (Tech vs Non‑Tech stacked)
  - **Tech density plot** (percentage of tech jobs over time) – reveals the “digital transformation” trend.
- **Data Saved**: `tech_vs_nontech_full_trend.csv`

### 3. AI‑Specific Hiring Evolution
- **Beyond O*NET**: For deeper analysis, job descriptions are scanned with keyword rules:
  - **AI & Data Science**: `LIKE '%AI%' OR '%Machine Learning%' OR '%Data Science%'`
  - **General Engineering/Tech**: `LIKE '%Engineer%' OR '%R&D%' OR '%Software%'`
  - **Non‑Tech**: remainder
- **Visualization**: Stacked areas of absolute counts and a line for the **AI job density** over time, showing the rise of AI‑related hiring.

### 4. Individual Firm Deep Dives: Case Study (CTSH)
- **Goal**: Illustrate the correlation between total hiring volume and market performance.
- **Method**: 
  1. Fetch all monthly posting counts for CTSH.
  2. Download CTSH stock price (`yfinance`, monthly resampling to first of month).
  3. Merge on month.
  4. Plot dual‑axis chart (postings vs. price).
  5. Compute Pearson correlation.
- **Result**: Outputs the correlation coefficient (e.g., `0.488` for CTSH). This demonstrates initial linkage between hiring momentum and stock price.

### 5. Alpha Backtest: Tech Talent Density vs. Future Stock Returns
- **Hypothesis**: A higher proportion of tech hires in a base year predicts superior stock returns in the following year.
- **Method**:
  1. For the top 50 firms (to compensate for delistings), compute **2022 tech job ratio** from postings (O*NET‑based `onet` codes 15xxxx).
  2. Download **H1 2023 stock returns** using `yfinance` with `auto_adjust=True` (handles adjusted close price).
  3. Plot scatter with regression line.
  4. Compute Pearson correlation.
- **Handling issues**: Delisted tickers (e.g., AAN, RRD, etc.) are skipped with try/except.
- **Outcome**: Negative weak correlation observed (`‑0.085`). This suggests that tech density alone may not be a simple alpha signal.

### 6. Top 10 Firm Hiring–Stock Price Linkage
- **Scope**: Top 10 data‑rich firms.
- **Method**: For each, align monthly job posting totals with monthly average stock price.
- **Output**: A correlation table and subplot panels (one per firm) comparing hiring volume and share price.

## factors.ipynb

### 1. Feature Engineering
- Daily active job postings are merged with their attributes.
- Aggregated features are computed per trading day:

|Category|Features|
|:-------|:-------|
|Volume|num_jobs (count of unique active hashes)|
|Geographic Diversity|	num_countries, num_regions|
|Occupational Diversity|	num_onets, num_onet_groups, num_onet_occupations, num_onet_specifics|
|Occupation Distribution|	top_onet, max_onet_prob, mean_onet_prob, std_onet_prob, skew_onet_prob, kurt_onet_prob|
|Region Distribution|	max_region_prob, mean_region_prob, std_region_prob, skew_region_prob, kurt_region_prob|

- Occupation and region distributions are created by pivoting the active jobs by onet or region per day, normalizing to probabilities, and computing distributional statistics.
- All features (X) are then smoothed using the same EWM (span=20) to align with the target’s construction.

### 2. Correlation Analysis
- A simple linear regression (via scipy.stats.linregress) is run for each feature against the target y.
- Scatter plots (with regression line and statistics) and binned mean bar plots are generated for visual inspection.
- Time series overlay of cumulative return and num_jobs is provided to observe co‑movement.

## job_rrg.ipynb

### 1. Job Relative Strength Metrics (J‑RS‑Ratio & J‑RS‑Momentum)
Analogous to Bloomberg equity RRG:
- **J‑RS‑Ratio** (Relative Strength)
- **J‑RS‑Momentum**: Measures the rate of change of the J‑RS‑Ratio.
Both indicators are normalized with a rolling window and forced to center around 100, making them comparable across sectors.

### 2. Relative Rotation Graph Quadrants
The sector’s position in the (J‑RS‑Ratio, J‑RS‑Momentum) plane is interpreted as:

| Quadrant | J‑RS‑Ratio | J‑RS‑Momentum | Interpretation |
|----------|------------|----------------|----------------|
| Leading  | > 100      | > 100          | Strong, accelerating job growth |
| Improving| < 100      | > 100          | Weak but gaining momentum |
| Lagging  | < 100      | < 100          | Weak and decelerating |
| Weakening| > 100      | < 100          | Still strong but losing steam |

### 3. Visualization
An **animated RRG** is created using Plotly Express (`px.scatter` with `animation_frame`). Each point represents a sector, labeled by its NAICS sector code. It can be seen that at the beginning of the provided dataset there are not much active job hiring, only 2-3 sectors can be seen. More sectors show up since 2014.

### 4. Backtest
- Constructed a backtester allowing long-short or single-way strategy
- Tunable lag for both long signals and short signals

#### 4.1. Signal Lag Analysis
- A **lag of 1 month** is applied between the signal date and portfolio formation.
- The strategy is implemented **long‑only**: holds only sectors that exhibited an *Improving → Leading* rotation in the previous month.
- The benchmark is the **average equal‑weighted return across all sectors** (Linkup Average).

#### 4.2 Results
- **Sharpe Ratio**  
  - RRG Strategy: **0.90**  
  - Linkup Average: **0.72**
- **Max Drawdown**  
  - RRG Strategy: **‑22.15%**  
  - Linkup Average: **‑28.66%**
- **Factor Regression**  
  - The strategy shows significant positive loading on the market (β≈0.77) and size (SMB≈0.69) factors, a significant negative loading on value (HML≈‑0.37), and no significant momentum exposure.  
  - The constant (alpha) is **0.85% per month (p‑value ≈ 0.083)**, indicating a positive but not statistically significant abnormal return after adjusting for these factors.


## Common Data Handling across Notebooks

### 1. Company Identifier Mapping
- **Table**: `company_id_compustat_identifiers` maps internal `company_id` to standard Compustat identifiers (`gvkey`, `cusip`, `tic`, `conm`) and NAICS industry codes.
- Used to bridge job posting data with CRSP/Compustat financial data.

### 2. Financial Data Integration
- **Compustat North America Quarterly** (`compustat_na_quarterly_all_firms_since_2000`): balance‑sheet items (e.g., `atq`). Merged with company mapping to compute firm‑level metrics.
- **CRSP Monthly Returns** (`crsp_monthly_ret_all_firms_since_2000`): monthly stock returns, prices, dividends. Attempted (but not fully corrected) merge on `cusip` – column‑case sensitivity issues noted.

### 3. Sector‑Level Aggregation
- **Firm‑Sector Mapping**: NAICS codes extracted from `company_id_compustat_identifiers`; sector = floor(naics/10000).
- **Monthly Job Openings**: For each firm, we count distinct active job posts (`hash`) per month. The logic considers:
  - `active_jobs` – any job whose active period overlaps with the month.
  - Derived metrics: `new_jobs`, `closed_jobs`, `jobs_open_full_month` (all computed but primarily `active_jobs` used).
- **Sector Aggregation**: Sum active jobs across all firms belonging to the same sector, producing a monthly time series for each sector.