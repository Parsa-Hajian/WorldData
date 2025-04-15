# Global Happiness Indicators Panel Dataset and Shiny App

This repository contains a merged and harmonized panel dataset of the World Happiness Reports from 2015 to 2019, along with a Shiny application for interactive visualization of global happiness indicators.

## Overview

The World Happiness Report datasets from 2015 through 2019 were combined into a single panel dataset. During the merging process, we:
- **Standardized variable names:** Renamed columns (e.g., converting "Happiness Score" to `Score`, "Economy (GDP per Capita)" to `GDP_per_capita`, "Family" to `Social_support`, etc.) so that every dataset used the same terminology.
- **Added a Year column:** Each dataset was tagged with its corresponding year (2015–2019) for easy temporal comparison.
- **Selected common variables:** Only variables common to all datasets (Score, GDP_per_capita, Social_support, Healthy_life_expectancy, Freedom, Generosity, and Corruption) were kept.
- **Resolved naming conflicts:** For instance, the GDP per capita column in datasets from 2015–2017 was renamed to match the “GDP per capita” column in 2018–2019, and then these were merged into one unified column.

The final merged dataset is stored as `merged_data.csv`.

## Requirements

This project requires the following R packages:
- `dplyr`
- `readr`
- `ggplot2`
- `sf`
- `rnaturalearth`
- `rnaturalearthdata`
- `viridis`
- `shiny`
- `tidyr`
- `GGally`

You can install them by running:

```r
install.packages(c("dplyr", "readr", "ggplot2", "sf", "rnaturalearth", "rnaturalearthdata", "viridis", "shiny", "tidyr", "GGally"))
```

##Shiny App

The Shiny application allows users to explore global patterns in happiness indicators. Users can:

- **    Select a Feature: Choose one of the key variables (Score, GDP_per_capita, Social_support, Healthy_life_expectancy, Freedom, Generosity, or Corruption). **

- **    Select a Year: Choose a specific year (from 2015 to 2019) or view an aggregated "Total" (the average across all years). **

- **    View a Global Map: The app displays a world choropleth map that updates according to the selected feature and time period, highlighting geographical patterns in the data. **

##Data Preparation

All data merging and harmonization were performed using R scripts (details of these steps are described in our report). The final merged dataset (merged_data.csv) includes the following columns:

 
- **   Country: Country name. **

 
- **   Year: The year for the observation. **

 
- **   Score: Overall happiness score. **

  
- **  GDP_per_capita: Economic performance measured by GDP per capita. **

 
- **   Social_support: A measure of social support. **


- **    Healthy_life_expectancy: Expected healthy lifespan. **


- **    Freedom: Measure of freedom to make life choices. **


- **    Generosity: Level of generosity. **


- **    Corruption: Perceptions of corruption (stored as numeric). **

##Benefits and Motivations

Merging and harmonizing the datasets enabled us to:

- **    Compare Trends Over Time: Analyze how countries' happiness indicators evolved from 2015 to 2019. **

- **    Increase Sample Size: Combining all years into a unified dataset improved the reliability of unsupervised analysis. **

- **   Apply Consistent Methods: A unified panel allowed the same clustering and dimensionality reduction techniques to be applied across all data. **

- **    Uncover Global Patterns: The Shiny app facilitates interactive exploration of geographical patterns, aiding in segmenting countries based on similar indicators. **
