# AWP advancement (All Weather Portfolio)

This folder contains our All Weather Portfolio (AWP) replication and enhancement work, including the notebooks and the datasets they use.

## Files

### Notebooks
- `awp_replication_analysis.ipynb`: replication/analysis notebook for the AWP workflow and results.
- `FINA4359.ipynb`: main project notebook used for the AWP advancement work (data prep + portfolio construction / evaluation).

### Data
- `macro_data.csv`: macro series used for the AWP signals/inputs.
- `FINA4359 database +btc.csv`: project dataset export including BTC (used for extended asset universe / comparisons).

## How to run
1. Open the notebooks in Jupyter (or VS Code) from this folder so relative paths resolve.
2. Run cells top-to-bottom.

If you encounter missing-package errors, install the required Python packages referenced at the top of the notebook (typical stack: `pandas`, `numpy`, `matplotlib`, `statsmodels`, etc.).
