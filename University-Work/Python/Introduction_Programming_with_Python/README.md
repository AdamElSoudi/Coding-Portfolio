# Electricity Price Analysis (Sweden, 2018–2023)

This project analyzes and visualizes electricity price trends in Sweden for apartments and villas (residential customers) between 2018 and 2023. It was developed as part of a university assignment and includes data processing, statistical analysis, and visualizations using Python.

## Features

- 📊 **Reads and processes** electricity price data from CSV files.
- 📈 **Plots monthly price trends** for different customer types and pricing agreements.
- 📉 **Calculates statistics**: min, max, average, and median values.
- 🔄 **Tracks month-over-month changes** for different pricing agreements (e.g., fixed or variable).
- 🧮 **Compares pricing across four regions** (SE1–SE4) in Sweden.

## Technologies Used

- Python 3
- `matplotlib` for data visualization
- `csv` for file handling

## Input Data

- `lghpriser.csv` – Apartment customer prices
- `villapriser.csv` – Villa customer prices

## How It Works

The program guides the user through several steps:
1. Load data from CSV files.
2. Choose customer type, year, pricing model (R, F1, F3), and region (SE1–SE4).
3. View a statistical breakdown and visual analysis of pricing data.
4. Explore long-term trends across multiple years.

## Output

- Interactive line and bar charts
- Printed tables with price stats
- Clean, console-based user interaction

## Example

```plaintext
Analys av elpriserna för kategorin villakund år 2020

Prisomr.  min -- (mån)  max -- (mån)  medel  median   ...
SE1       17.82 apr     42.20 jan     28.92  29.72    ...
...
