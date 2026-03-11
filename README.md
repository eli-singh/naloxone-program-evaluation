# Association Between County-Level Naloxone Distribution Intensity and Changes in Opioid Overdose Mortality in California
### Author: Eli Singh, M.S. Biostatistics Candidate

### Overview
This project evaluates the association between county-level naloxone distribution intensity and changes in opioid overdose mortality in California.
Using publicly available data from the California Naloxone Distribution Project and CDC WONDER mortality files, I constructed a county-level panel dataset and estimated change-in-mortality regression models controlling for baseline overdose severity and urban–rural classification.
The analysis explores whether counties with higher cumulative naloxone distribution intensity experienced different mortality trends between 2018–2020 and 2021–2023.

### Research Question
Are counties with higher cumulative naloxone distribution intensity associated with smaller (or larger) changes in opioid overdose mortality over time?

### Data Sources
#### Naloxone Distribution Data
California Naloxone Distribution Project (count-level kits per 100,000 residents, 2018-2025 cumulative)
#### Overdose Mortality Data
CDC WONDER – Multiple Cause of Death database
(ICD-10 drug poisoning codes: X40–X44, X60–X64, X85, Y10–Y14)
#### Urban-Rural Classification
National Center for Health Statistics (NCHS) county classification scheme

### Study design
Unit of analysis: California counties
Baseline period: 2018–2020 (3-year average)
Follow-up period: 2021–2023 (3-year average)
Primary outcome: Change in overdose mortality rate (follow-up − baseline)
Secondary outcome: Log-difference (proportional change)
Naloxone distribution intensity was treated as a county-level exposure variable (kits per 100,000 residents, cumulative 2018–2025).

### Methods
#### Model 1 - Absolute Change
Change in overdose rate regressed on: naloxone distribution intensity (scaled per 1,000 kits per 100,000 residents), baseline overdose rate, urban-rural classification
#### Model 2 - Proportional Change
Log(follow-up rate) - log(baseline rate) regressed on: naloxone distribution intensity, baseline overdose rate, urban-rural classification

All models were estimated using OLS.

### Key Findings
Overdose mortality increased in most counties between baseline and follow-up periods.
After adjusting for baseline overdose rates and urban–rural classification, naloxone distribution intensity was not significantly associated with proportional changes in overdose mortality.
These findings are consistent with targeted deployment of naloxone in higher-burden counties rather than evidence of a direct mortality-reducing effect at the ecological level.

### Limitations
Ecological (county-level) design
Naloxone exposure only available as cumulative intensity
Potential reverse causality (high-burden counties receive more naloxone)
No adjustment for concurrent policy change or fentanyl supply shocks