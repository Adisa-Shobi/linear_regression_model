class GDPInput {
  String? country; // Must be from valid countries list

  // Land and Resources
  double? agriculturalLand; // Percentage [0-100]
  double? forestLand; // Percentage [0-100], sum with agriculturalLand <= 100
  double? landArea; // Square kilometers, positive
  double? avgPrecipitation; // Millimeters per year, positive

  // Economic Indicators
  double? tradeInServices; // Percentage [0-100]
  double?
      controlOfCorruptionEstimate; // No constraints, typically [-2.5 to 2.5]
  double? controlOfCorruptionStd; // No constraints, typically [0-1]
  double? centralGovermentDebt; // Percentage [0-100]
  double? taxRevenue; // Percentage [0-100]
  double? inflationAnnual; // Percentage [0-100]
  double? realInterestRate; // No constraints, can be negative
  double? riskPremiumOnLending; // No constraints, typically positive

  // Infrastructure and Development
  double? accessToElectricity; // Percentage [0-100]
  double? electricPowerConsumption; // kWh per capita, positive
  double? individualsUsingInternet; // Percentage [0-100]

  // Business and Development Metrics
  double? humanCapitalIndex; // No constraints, typically [0-1]
  double? doingBusiness; // No constraints, typically [0-120]
  double? statisticalPerformanceIndicators; // No constraints, typically [0-100]
  double? logisticPerformanceIndex; // No constraints, typically [1-5]

  // Demographics and Social
  double? populationDensity; // People per sq km, positive
  double? intentionalHomicides; // Per 100,000 people, positive
  double? giniIndex; // [0-100]
  double? multidimensionalPovertyHeadcountRatio; // Percentage [0-100]

  // Government Expenditure
  double? militaryExpenditure; // Percentage [0-100]
  double? governmentExpenditureOnEducation; // Percentage [0-100]
  double? governmentHealthExpenditure; // Percentage [0-100]
  double? researchAndDevelopmentExpenditure; // Percentage [0-100]

  // Business Environment
  double? timeToGetOperationLicense; // Days, positive

  GDPInput({
    this.country,
    this.agriculturalLand,
    this.forestLand,
    this.landArea,
    this.avgPrecipitation,
    this.tradeInServices,
    this.controlOfCorruptionEstimate,
    this.controlOfCorruptionStd,
    this.centralGovermentDebt,
    this.taxRevenue,
    this.inflationAnnual,
    this.realInterestRate,
    this.riskPremiumOnLending,
    this.accessToElectricity,
    this.electricPowerConsumption,
    this.individualsUsingInternet,
    this.humanCapitalIndex,
    this.doingBusiness,
    this.statisticalPerformanceIndicators,
    this.logisticPerformanceIndex,
    this.populationDensity,
    this.intentionalHomicides,
    this.giniIndex,
    this.multidimensionalPovertyHeadcountRatio,
    this.militaryExpenditure,
    this.governmentExpenditureOnEducation,
    this.governmentHealthExpenditure,
    this.researchAndDevelopmentExpenditure,
    this.timeToGetOperationLicense,
  });

  // From JSON constructor
  factory GDPInput.fromJson(Map<String, dynamic> json) {
    return GDPInput(
      country: json['country'] as String,
      agriculturalLand: json['agricultural_land'] as double,
      forestLand: json['forest_land'] as double,
      landArea: json['land_area'] as double,
      avgPrecipitation: json['avg_precipitation'] as double,
      tradeInServices: json['trade_in_services'] as double,
      controlOfCorruptionEstimate:
          json['control_of_corruption_estimate'] as double,
      controlOfCorruptionStd: json['control_of_corruption_std'] as double,
      centralGovermentDebt: json['central_goverment_debt'] as double,
      taxRevenue: json['tax_revenue'] as double,
      inflationAnnual: json['inflation_annual'] as double,
      realInterestRate: json['real_interest_rate'] as double,
      riskPremiumOnLending: json['risk_premium_on_lending'] as double,
      accessToElectricity: json['access_to_electricity'] as double,
      electricPowerConsumption: json['electric_power_consumption'] as double,
      individualsUsingInternet: json['individuals_using_internet'] as double,
      humanCapitalIndex: json['human_capital_index'] as double,
      doingBusiness: json['doing_business'] as double,
      statisticalPerformanceIndicators:
          json['statistical_performance_indicators'] as double,
      logisticPerformanceIndex: json['logistic_performance_index'] as double,
      populationDensity: json['population_density'] as double,
      intentionalHomicides: json['intentional_homicides'] as double,
      giniIndex: json['gini_index'] as double,
      multidimensionalPovertyHeadcountRatio:
          json['multidimensional_poverty_headcount_ratio'] as double,
      militaryExpenditure: json['military_expenditure'] as double,
      governmentExpenditureOnEducation:
          json['government_expenditure_on_education'] as double,
      governmentHealthExpenditure:
          json['government_health_expenditure'] as double,
      researchAndDevelopmentExpenditure:
          json['research_and_development_expenditure'] as double,
      timeToGetOperationLicense:
          json['time_to_get_operation_license'] as double,
    );
  }

  // To JSON method
  Map<String, dynamic> toJson() {
    return {
      'country': country,
      'agricultural_land': agriculturalLand,
      'forest_land': forestLand,
      'land_area': landArea,
      'avg_precipitation': avgPrecipitation,
      'trade_in_services': tradeInServices,
      'control_of_corruption_estimate': controlOfCorruptionEstimate,
      'control_of_corruption_std': controlOfCorruptionStd,
      'central_goverment_debt': centralGovermentDebt,
      'tax_revenue': taxRevenue,
      'inflation_annual': inflationAnnual,
      'real_interest_rate': realInterestRate,
      'risk_premium_on_lending': riskPremiumOnLending,
      'access_to_electricity': accessToElectricity,
      'electric_power_consumption': electricPowerConsumption,
      'individuals_using_internet': individualsUsingInternet,
      'human_capital_index': humanCapitalIndex,
      'doing_business': doingBusiness,
      'statistical_performance_indicators': statisticalPerformanceIndicators,
      'logistic_performance_index': logisticPerformanceIndex,
      'population_density': populationDensity,
      'intentional_homicides': intentionalHomicides,
      'gini_index': giniIndex,
      'multidimensional_poverty_headcount_ratio':
          multidimensionalPovertyHeadcountRatio,
      'military_expenditure': militaryExpenditure,
      'government_expenditure_on_education': governmentExpenditureOnEducation,
      'government_health_expenditure': governmentHealthExpenditure,
      'research_and_development_expenditure': researchAndDevelopmentExpenditure,
      'time_to_get_operation_license': timeToGetOperationLicense,
    };
  }
}
