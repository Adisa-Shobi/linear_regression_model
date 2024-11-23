from pydantic import BaseModel, Field, model_validator
from typing import ClassVar


class GDPInput(BaseModel):
    # Class variable to store valid countries
    valid_countries: ClassVar[list] = []  # Will be set after model creation

    # Identifier
    country: str = Field(..., description="Country name", min_length=1)

    # Land and Resources
    agricultural_land: float = Field(..., ge=0, le=100,
                                     description="Agricultural land (% of land area)")
    forest_land: float = Field(..., ge=0, le=100,
                               description="Forest land (% of land area)")
    land_area: float = Field(..., description="Total land area in sq km")
    avg_precipitation: float = Field(...,
                                     description="Average precipitation in mm per year")

    # Economic Indicators
    trade_in_services: float = Field(..., ge=0, le=100,
                                     description="Trade in services (% of GDP)")
    control_of_corruption_estimate: float = Field(
        ..., description="Control of corruption estimate")
    control_of_corruption_std: float = Field(
        ..., description="Control of corruption standard error")
    central_goverment_debt: float = Field(..., ge=0, le=100,
                                          description="Central government debt (% of GDP)")
    tax_revenue: float = Field(..., ge=0, le=100,
                               description="Tax revenue (% of GDP)")
    inflation_annual: float = Field(..., ge=0, le=100,
                                    description="Annual inflation rate (%)")
    real_interest_rate: float = Field(...,
                                      description="Real interest rate (%)")
    risk_premium_on_lending: float = Field(...,
                                           description="Risk premium on lending (%)")

    # Infrastructure and Development
    access_to_electricity: float = Field(..., ge=0, le=100,
                                         description="Access to electricity (% of population)")
    electric_power_consumption: float = Field(
        ..., description="Electric power consumption (kWh per capita)")
    individuals_using_internet: float = Field(
        ..., ge=0, le=100, description="Individuals using Internet (% of population)")

    # Business and Development Metrics
    human_capital_index: float = Field(...,
                                      description="Human Capital Index")
    doing_business: float = Field(...,
                                 description="Ease of doing business score")
    statistical_performance_indicators: float = Field(...,
                                                    description="Statistical Performance Indicators score")
    logistic_performance_index: float = Field(...,
                                            description="Logistics performance index")

    # Demographics and Social
    population_density: float = Field(...,
                                      description="Population density (people per sq km)")
    intentional_homicides: float = Field(
        ..., description="Intentional homicides per 100,000 people")
    gini_index: float = Field(..., ge=0, le=100,
                              description="Gini index (0-100)")
    multidimensional_poverty_headcount_ratio: float = Field(
        ..., ge=0, le=100, description="Poverty headcount ratio (%)")

    # Government Expenditure
    military_expenditure: float = Field(..., ge=0, le=100,
                                        description="Military expenditure (% of GDP)")
    government_expenditure_on_education: float = Field(
        ..., ge=0, le=100, description="Government expenditure on education (% of GDP)")
    government_health_expenditure: float = Field(
        ..., ge=0, le=100, description="Government health expenditure (% of GDP)")
    research_and_development_expenditure: float = Field(
        ..., ge=0, le=100, description="R&D expenditure (% of GDP)")

    # Business Environment
    time_to_get_operation_license: float = Field(
        ..., description="Time required to get operation license (days)")

    @model_validator(mode='before')
    def validate_percentage_fields(cls, values):
        percentage_fields = [
            'agricultural_land', 'forest_land', 'access_to_electricity',
            'individuals_using_internet', 'tax_revenue',
            'multidimensional_poverty_headcount_ratio', 'trade_in_services', 
            'central_goverment_debt', 'research_and_development_expenditure', 
            'inflation_annual', 'military_expenditure',
            'government_expenditure_on_education', 'government_health_expenditure'
        ]

        for field in percentage_fields:
            if field in values and values[field] > 100:
                raise ValueError(f"{field} cannot exceed 100%")
        return values

    @model_validator(mode='before')
    def validate_land_constraints(cls, values):
        if 'agricultural_land' in values and 'forest_land' in values:
            if values['agricultural_land'] + values['forest_land'] > 100:
                raise ValueError(
                    "Sum of agricultural and forest land percentage cannot exceed 100%")
        return values

    @model_validator(mode='before')
    def validate_country_name(cls, values):
        if 'country' in values:
            # Remove leading/trailing whitespace and convert to title case
            country = values['country'].strip().title()

            # Validate against list of valid countries
            if not cls.valid_countries:
                raise ValueError(
                    "List of valid countries has not been initialized")

            if country not in cls.valid_countries:
                raise ValueError(f"Invalid country: {country}. Must be one of {cls.valid_countries}")

            values['country'] = country
        return values

    class Config:
        json_schema_extra = {
            "example": {
                "country": "United States",
                "agricultural_land": 45.2,
                "forest_land": 32.1,
                "land_area": 500000,
                "avg_precipitation": 1200,
                "trade_in_services": 15.3,
                "control_of_corruption_estimate": 0.5,
                "control_of_corruption_std": 0.2,
                "access_to_electricity": 98.5,
                "electric_power_consumption": 12000,
                "population_density": 35.6,
                "inflation_annual": 2.1,
                "real_interest_rate": 3.5,
                "risk_premium_on_lending": 2.8,
                "research_and_development_expenditure": 2.8,
                "central_goverment_debt": 65.4,
                "tax_revenue": 15.2,
                "time_to_get_operation_license": 45,
                "individuals_using_internet": 85.6,
                "military_expenditure": 3.2,
                "government_expenditure_on_education": 5.1,
                "government_health_expenditure": 8.5,
                "multidimensional_poverty_headcount_ratio": 1.2,
                "gini_index": 41.5,
                "intentional_homicides": 5.2,
                "human_capital_index": 0.75,
                "doing_business": 119,
                "statistical_performance_indicators": 88.3,
                "logistic_performance_index": 4.2
            }
        }