Exposure-Adjusted Motor Insurance Claim Frequency Model Using Poisson GLM



This project applies a Poisson Generalized Linear Model (GLM) in R to model motor insurance claim frequency using the French Motor insurance dataset.



Dataset: 678,013 policy records

Method: Poisson GLM with log link and exposure offset

Tool: R



Objective


The aim is to understand which driver, vehicle and geographic factors are linked to claim frequency and use them to estimate expected claims.


Key variables include:
- Claim Number
- Exposure
- Driver Age
- Vehicle Age
- Vehicle Power
- Bonus-Malus
- Population Density

Method:

- Exploratory Data Analysis
- Data preparation and train-test split
- Poisson GLM with log link
- log(Exposure) used as an offset
- Model prediction and evaluation
- visualizations through plots
- Analysis of dispersion and key risk factors



Key Findings

Policies from higher-density areas generally had higher predicted claim frequencies.
Vehicle age shows a negative relationship with claim frequency, suggesting relatively lower claim
occurrence for older vehicles. 
Higher vehicle power was associated with higher accident risk


Repository Contents

R Script: Complete analysis and modelling workflow.

Project Report: Detailed methodology, model results and interpretation.

Plots: Visualizations generated during the analysis.
