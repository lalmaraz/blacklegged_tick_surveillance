# Blacklegged Tick Surveillance in Toronto, 2013-2019

This repo contains an R project file for the paper "Highest Concentration of Lyme Disease-Causing Bacteria Found in Blacklegged Ticks in East Toronto Parks."

It contains three folders: inputs, outputs, and scripts.
Inputs:
- Source data from the City of Toronto's Open Data Portal
- Reference literature, including Public Health Ontario manual

Outputs:
- The paper folder contains the R Markdown file  to generate the paper, a pdf version of the paper, and a complete bibliography.
- The data folder is populated by the R Markdown script. It includes modifications to the original dataset.

Scripts:
- Two scripts for generating graphs, one animated and two static.

## How to generate the paper
1.  Open `blacklegged_tick_surveillance.Rproj` in RStudio
2.  Open `outputs/paper/paper.Rmd` 
3.  Install libraries using `install.packages()` if necessary
4.  Run all code chunks
5. The paper is generated to`outputs/paper/`