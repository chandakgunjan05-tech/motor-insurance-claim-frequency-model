Exposure-Adjusted Motor Insurance Claim Frequency Model Using Poisson GLM



This project applies a Poisson Generalized Linear Model (GLM) in R to model motor insurance claim frequency using the French Motor insurance dataset.



Dataset: 678,013 policy records

Method: Poisson GLM with log link and exposure offset

Tool: R



Objective



To model expected claim frequency and investigate the relationship between claim frequency and driver, vehicle and geographic characteristics, with applications to motor insurance risk assessment and pricing.

Key variables include:
- Claim Number
- Exposure
- Driver Age
- Vehicle Age
- Vehicle Power
- Bonus-Malus
- Population Density

Methodology:

- Exploratory Data Analysis
- Data preparation and train-test split
- Poisson GLM with log link
- log(Exposure) used as an offset
- Model prediction and evaluation
- visualizations through plots
- Analysis of dispersion and key risk factors



Key Findings

Higher-density regions showed higher claim incidence.
Vehicle age shows a negative relationship with claim frequency, suggesting relatively lower claim
occurrence for older vehicles. 
Higher vehicle power was associated with higher accident risk


Repository Contents

R Script: Complete analysis and modelling workflow.

Project Report: Detailed methodology, model results and interpretation.

Plots: Visualizations generated during the analysis.
