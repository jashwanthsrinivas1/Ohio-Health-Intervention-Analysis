# OhioHealth Performance Intervention Analysis

**M.S. in Business Analytics | University of Dayton Capstone Project | May 2026**

---

## Project Overview

OhioHealth is a non-profit healthcare system managing operational performance across 18 hospitals using a monthly executive dashboard tracking 47 metrics across four balanced scorecard quadrants: Quality, Service, Finance, and Culture.

Each month, when a metric falls below target and declines compared to the prior month, OhioHealth initiates a formal intervention (countermeasure) requiring root cause analysis, corrective action planning, and follow-up monitoring. Client-validated estimates placed average countermeasure effort at 60–80 minutes per intervention, typically involving two leaders at ~$75/hour.

**The core question: Was this intervention process actually working?**

---

## Business Problem

OhioHealth's intervention process was reactive — it triggered action whenever a metric fell below target and declined month-over-month, regardless of whether that change reflected meaningful operational deterioration or routine variation.

This created two risks:
- Teams spending time on short-term fluctuation that would have self-corrected
- Persistent underperformance receiving less attention when metrics stayed below target without continuing to decline

---

## My Role and Contribution

End-to-end contributor across all project phases:
- Scoped the statistical approach and determined which methods fit the business problem
- Performed regression analysis (lagged OLS, N+1 through N+5) and pattern testing in R
- Built and validated the decision-rule framework (Monitor / Intervene / Escalate)
- Authored sections of the final report
- Led client coordination with OhioHealth stakeholders
- Presented findings at University of Dayton Capstone Showcase, May 2026

---

## Dataset

> Data Privacy Notice: All OhioHealth performance data is confidential and cannot be shared publicly. The data/ folder in this repository contains 100% synthetic data generated to mirror the original panel structure. No real hospital names, metric values, or performance figures are included.

**Original dataset structure:**
- 1,296 site x metric x month observations
- 17 months of performance data (July 2024 - November 2025)
- 18 hospital sites, 47 metrics across 4 balanced scorecard quadrants
- Formal countermeasure records linked by site, metric, and month

---

## Methodology

### 1. Data Preparation
- Combined FY25 and FY26 dashboard files into a single monthly panel
- Converted wide format to long format (one row = one site, one metric, one month)
- Merged countermeasure records using site + metric + month as the key
- Standardized raw values to month-over-month percent change (direction-adjusted so positive = improvement)
- Created lag variables N+1 through N+5 to measure post-intervention performance

### 2. Baseline Trigger Review
- Reconstructed OhioHealth's current intervention rule in code
- Compared modeled trigger behavior against actual countermeasure records

### 3. Descriptive Analysis
- Compared performance change distributions across intervention vs. non-intervention periods
- Both groups centered near zero with substantial overlap — no clear system-wide shift

### 4. Lagged Regression Testing
- Dependent variable: normalized month-over-month performance change
- Primary independent variable: intervention status (binary)
- Models run across N+1 through N+5
- Controls included for site, metric, and time period

### 5. Pattern Testing
- Grouped interventions by distance from target
- Tested whether recovery exceeding the triggering gap predicted stronger outcomes
- Identified operating conditions where intervention was more likely to produce improvement

### 6. Control Panel Design
- Translated findings into a decision-support framework
- Four inputs: trend direction, distance from target, historical variability, prior intervention history
- Three output classifications: Monitor, Intervene, Escalate

---

## Key Findings

| Lag Period | Direction | Statistical Result |
|---|---|---|
| N+1 | Positive | Not statistically significant |
| N+2 | Positive/weak | Not consistently significant |
| N+3 | Positive | Not statistically significant |
| N+4 | Positive | RMH significant: coeff = 0.0211, p = 0.028, R-squared = 0.031 |
| N+5 | Positive | Not statistically significant |

- Interventions were directionally helpful but the effect was small and inconsistent system-wide
- The clearest signal appeared 4 months after intervention at one high-volume site
- Interventions performed better when metrics were already close to target (distance less than 0.1)
- Intervention value depends more on WHEN OhioHealth acts than WHETHER it acts

---

## Recommendations

1. Shift from reactive to signal-based intervention — incorporate trend direction, distance from target, historical variability, and prior intervention history into trigger decisions
2. Add a validation step before assigning RCA work — screen whether observed decline differs meaningfully from normal variation before committing leader time
3. Build a learning system around outcomes — track post-intervention results to refine thresholds over time

---

## Tools and Skills Demonstrated

- **R** — dplyr, ggplot2, lm() for OLS regression, lag variable construction, panel data preparation
- **Excel** — decision control panel with adjustable thresholds
- **PowerPoint** — executive presentation and capstone showcase deck
- **Statistical methods** — lagged OLS regression, descriptive analysis, pattern testing, decision-rule design
- **Domain** — healthcare operations, balanced scorecard, performance management

---

## Repository Structure
Ohio-Health-Intervention-Analysis/
├── README.md
├── data/
│   └── synthetic_panel_data.csv
├── analysis/
│   └── intervention_analysis.R
├── outputs/
│   └── regression_summary.txt
│   └── pattern_testing_results.txt
└── docs/
    └── control_panel_guide.md

---

## Team

University of Dayton Capstone Team — May 2026

*Completed as part of the M.S. in Business Analytics program at the University of Dayton.*
