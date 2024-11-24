# World Development Indicators Dataset (1960-2022)

## Source
[World Bank Development Indicators Database](https://www.kaggle.com/datasets/nicolasgonzalezmunoz/world-bank-world-development-indicators/data?select=world_bank_development_indicators.csv)

## Background
This dataset contains macro-economical, social, political and environmental data extracted from the World Bank database. It covers 268 countries and regions from 1960 to 2022, including 48 original features (all numerical) plus 2 derived columns. Due to varying data collection and reporting across regions and time periods, there are missing entries across different columns.

## Dataset Structure
Structure:
- Format: CSV
- Rows: Country-year observations for 268 countries/regions  
- Columns: 50 indicators (48 original + 2 derived)
- Time Range: 1960-2022
- Geographic Coverage: Global

## Column Descriptions

### 1. Basic Identifiers
- **country** : str
    - Country or geographic region name

- **date** : datetime
    - Date of measurement (YYYY-MM-DD format)

### 2. Land & Environmental  
- **agricultural_land%** : float
    - Agricultural land as % of land area
- **forest_land%** : float
    - Forest area as % of land area
- **land_area** : float
    - Land area in square kilometers (km²)
- **avg_precipitation** : float
    - Average precipitation in depth (mm per year)
- **CO2_emisions** : float
    - CO2 emissions (kt)
- **other_greenhouse_emisions** : float
    - Total greenhouse gas emissions (kt of CO2 equivalent)

### 3. Economic
- **GDP_current_US** : float
    - GDP in current US dollars
- **trade_in_services%** : float
    - Trade in services as % of GDP
- **inflation_annual%** : float
    - Inflation, consumer prices (annual %)
- **real_interest_rate** : float
    - Real interest rate (%)
- **risk_premium_on_lending** : float
    - Risk premium on lending (lending rate minus treasury bill rate, %)
- **central_goverment_debt%** : float
    - Central government debt, total (% of GDP)
- **tax_revenue%** : float
    - Tax revenue (% of GDP)
- **expense%** : float
    - Expense (% of GDP)
- **research_and_development_expenditure%** : float
    - Research and development expenditure (% of GDP)

### 4. Governance & Institutional Quality
- **control_of_corruption_estimate** : float
    - Estimate of control of corruption
- **control_of_corruption_std** : float
    - Standard error of control of corruption estimate
- **goverment_effectiveness_estimate** : float
    - Estimate of Government Effectiveness
- **goverment_effectiveness_std** : float
    - Standard error of Government Effectiveness estimate
- **political_stability_estimate** : float
    - Estimate of Political Stability and Absence of Violence/Terrorism
- **political_stability_std** : float
    - Standard error of Political Stability estimate
- **rule_of_law_estimate** : float
    - Estimate of Rule of Law
- **rule_of_law_std** : float
    - Standard error of Rule of Law estimate
- **regulatory_quality_estimate** : float
    - Estimate of Regulatory Quality
- **regulatory_quality_std** : float
    - Standard error of Regulatory Quality estimate
- **voice_and_accountability_estimate** : float
    - Estimate of Voice and Accountability
- **voice_and_accountability_std** : float
    - Standard error of Voice and Accountability estimate

### 5. Development & Infrastructure
- **access_to_electricity%** : float
    - Access to electricity (% of population)
- **renewvable_energy_consumption%** : float
    - Renewable energy consumption (% of total final energy consumption)
- **electric_power_consumption** : float
    - Electric power consumption (kWh per capita)
- **individuals_using_internet%** : float
    - Individuals using the Internet (% of population)
- **logistic_performance_index** : float
    - Logistics performance index: Overall (1=low to 5=high)
- **doing_business** : float
    - Ease of doing business score (0=lowest to 100=best performance)
- **time_to_get_operation_license** : float
    - Days required to obtain operating license
- **statistical_performance_indicators** : float
    - Statistical performance indicators (SPI): Overall score (0-100)
- **human_capital_index** : float
    - Human Capital Index (HCI) (scale 0-1)

### 6. Social & Demographic
- **population** : float
    - Total population count
- **population_density** : float
    - Population density (people per km² of land area)
- **rural_population** : float
    - Rural population count
- **birth_rate** : float
    - Birth rate, crude (per 1,000 people)
- **death_rate** : float
    - Death rate, crude (per 1,000 people)
- **life_expectancy_at_birth** : float
    - Life expectancy at birth, total (years)
- **gini_index** : float
    - Gini index (measure of income inequality)
- **multidimensional_poverty_headcount_ratio%** : float
    - Multidimensional poverty headcount ratio (% of total population)
- **intentional_homicides** : float
    - Intentional homicides (per 100,000 people)

### 7. Government Expenditure
- **military_expenditure%** : float
    - Military expenditure (% of GDP)
- **government_expenditure_on_education%** : float
    - Government expenditure on education (% of GDP)
- **government_health_expenditure%** : float
    - Domestic general government health expenditure (% of GDP)

### Derived Columns
- **log10_GDP_per_cap** : float
    - Log10 transformation of GDP per capita (GDP_current_US/population)
- **year** : int
    - Extracted year from date column

# API
[Docs](https://linear-regression-model-4ns3.onrender.com/docs#/default/get_countries_countries_get)

# Demo Video
[See here](https://youtu.be/rskLyEF9e-Y)