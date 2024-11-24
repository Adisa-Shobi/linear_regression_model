import 'package:flutter/material.dart';
import 'package:gdp_predictor/controllers/predict_controller.dart';
import 'package:gdp_predictor/utils/colors.dart';
import 'package:get/get.dart';

class PredictView extends GetView<PredictController> {
  const PredictView({super.key});

  Step _buildBasicIdentifiersStep() {
    return Step(
      isActive: controller.currentStep.value >= 0,
      title: const Text('Basic Identifiers'),
      content: Form(
        key: controller.formKeys[0],
        child: const _BasicIdentifiersSection(),
      ),
    );
  }

  Step _buildLandResourcesStep() {
    return Step(
      isActive: controller.currentStep.value >= 1,
      title: const Text('Land & Resources'),
      content: Form(
        key: controller.formKeys[1],
        child: const _LandResourcesSection(),
      ),
    );
  }

  Step _buildEconomicIndicatorsStep() {
    return Step(
      isActive: controller.currentStep.value >= 2,
      title: const Text('Economic Indicators'),
      content: Form(
        key: controller.formKeys[2],
        child: const _EconomicIndicatorsSection(),
      ),
    );
  }

  Step _buildInfrastructureDevelopmentStep() {
    return Step(
      isActive: controller.currentStep.value >= 3,
      title: const Text('Infrastructure & Development'),
      content: Form(
        key: controller.formKeys[3],
        child: const _InfrastructureDevelopmentSection(),
      ),
    );
  }

  Step _buildBusinessDevelopmentStep() {
    return Step(
      isActive: controller.currentStep.value >= 4,
      title: const Text('Business & Development'),
      content: Form(
        key: controller.formKeys[4],
        child: const _BusinessDevelopmentSection(),
      ),
    );
  }

  Step _buildDemographicsSocialStep() {
    return Step(
      isActive: controller.currentStep.value >= 5,
      title: const Text('Demographics & Social'),
      content: Form(
        key: controller.formKeys[5],
        child: const _DemographicsSocialSection(),
      ),
    );
  }

  Step _buildGovernmentExpenditureStep() {
    return Step(
      isActive: controller.currentStep.value >= 6,
      title: const Text('Government Expenditure'),
      content: Form(
        key: controller.formKeys[6],
        child: const _GovernmentExpenditureSection(),
      ),
    );
  }

  Step _buildBusinessEnvironmentStep() {
    return Step(
      isActive: controller.currentStep.value >= 7,
      title: const Text('Business Environment'),
      content: Form(
        key: controller.formKeys[7],
        child: const _BusinessEnvironmentSection(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: const Text('GDP Forecaster'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Stepper(
                type: StepperType.vertical,
                currentStep: controller.currentStep.value,
                onStepContinue: () {
                  if (controller.currentStep.value < 7) {
                    if (controller
                        .formKeys[controller.currentStep.value].currentState!
                        .validate()) {
                      controller
                          .formKeys[controller.currentStep.value].currentState!
                          .save();

                      controller.currentStep.value += 1;
                    }
                  } else if (controller.currentStep.value == 7) {
                    controller.showPredict.value = true;
                  }
                },
                onStepCancel: () {
                  if (controller.currentStep.value > 0) {
                    controller.currentStep.value -= 1;
                  }
                },
                steps: [
                  _buildBasicIdentifiersStep(),
                  _buildLandResourcesStep(),
                  _buildEconomicIndicatorsStep(),
                  _buildInfrastructureDevelopmentStep(),
                  _buildBusinessDevelopmentStep(),
                  _buildDemographicsSocialStep(),
                  _buildGovernmentExpenditureStep(),
                  _buildBusinessEnvironmentStep(),
                ],
              ),
            ),
            // Submit button that only shows on the last step
            if (controller.currentStep.value == 7 &&
                controller.showPredict.value)
              Container(
                padding: const EdgeInsets.all(16.0),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: AppColors.primary,
                      elevation: 5),
                  onPressed: () {
                    if (controller.formKeys[7].currentState!.validate()) {
                      controller.formKeys[7].currentState!.save();
                      controller.submitForm();
                    }
                  },
                  child: const Text(
                    'Predict',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Section Widgets
class _BasicIdentifiersSection extends GetWidget<PredictController> {
  const _BasicIdentifiersSection();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          LoadingDropdown(
            label: 'Country',
            isLoading: controller.countriesLoading.value,
            value: null,
            items: controller.countries,
            onChanged: (x) {
              controller.gdpInput.value.country = x;
            },
            displayTextFor: (x) => x.toString(),
            validator: (x) => x == null ? 'This field is required' : null,
          )
        ],
      ),
    );
  }
}

class _LandResourcesSection extends GetWidget<PredictController> {
  const _LandResourcesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPercentageField(
          label: 'Agricultural Land',
          helperText: 'Enter percentage (0-100)',
          onSaved: (x) {
            controller.gdpInput.value.agriculturalLand = double.parse(x);
          },
        ),
        _buildPercentageField(
          label: 'Forest Land',
          helperText: 'Enter percentage (0-100)',
          onSaved: (x) {
            controller.gdpInput.value.forestLand = double.parse(x);
          },
        ),
        _buildNumberField(
          label: 'Land Area',
          helperText: 'Enter area in square kilometers',
          onSaved: (x) {
            controller.gdpInput.value.landArea = double.parse(x);
          },
        ),
        _buildNumberField(
          label: 'Average Precipitation',
          helperText: 'Enter precipitation in mm per year',
          onSaved: (x) {
            controller.gdpInput.value.avgPrecipitation = double.parse(x);
          },
        ),
      ],
    );
  }
}

class _EconomicIndicatorsSection extends GetWidget<PredictController> {
  const _EconomicIndicatorsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPercentageField(
          label: 'Trade in Services',
          helperText: 'Trade in services (% of GDP)',
          onSaved: (x) {
            controller.gdpInput.value.tradeInServices = double.parse(x);
          },
        ),
        _buildNumberField(
          label: 'Control of Corruption Estimate',
          helperText: 'Control of corruption estimate',
          onSaved: (x) {
            controller.gdpInput.value.controlOfCorruptionEstimate =
                double.parse(x);
          },
        ),
        _buildNumberField(
          label: 'Control of Corruption Std',
          helperText: 'Control of corruption standard error',
          onSaved: (x) {
            controller.gdpInput.value.controlOfCorruptionStd = double.parse(x);
          },
        ),
        _buildPercentageField(
          label: 'Central Government Debt',
          helperText: 'Central government debt (% of GDP)',
          onSaved: (x) {
            controller.gdpInput.value.centralGovermentDebt = double.parse(x);
          },
        ),
        _buildPercentageField(
          label: 'Tax Revenue',
          helperText: 'Tax revenue (% of GDP)',
          onSaved: (x) {
            controller.gdpInput.value.taxRevenue = double.parse(x);
          },
        ),
        _buildPercentageField(
          label: 'Inflation Annual',
          helperText: 'Annual inflation rate (%)',
          onSaved: (x) {
            controller.gdpInput.value.inflationAnnual = double.parse(x);
          },
        ),
        _buildNumberField(
          label: 'Real Interest Rate',
          helperText: 'Real interest rate (%)',
          onSaved: (x) {
            controller.gdpInput.value.realInterestRate = double.parse(x);
          },
        ),
        _buildNumberField(
          label: 'Risk Premium on Lending',
          helperText: 'Risk premium on lending (%)',
          onSaved: (x) {
            controller.gdpInput.value.riskPremiumOnLending = double.parse(x);
          },
        ),
      ],
    );
  }
}

class _InfrastructureDevelopmentSection extends GetWidget<PredictController> {
  const _InfrastructureDevelopmentSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPercentageField(
          label: 'Access to Electricity',
          helperText: 'Access to electricity (% of population)',
          onSaved: (x) {
            controller.gdpInput.value.accessToElectricity = double.parse(x);
          },
        ),
        _buildNumberField(
          label: 'Electric Power Consumption',
          helperText: 'Electric power consumption (kWh per capita)',
          onSaved: (x) {
            controller.gdpInput.value.electricPowerConsumption =
                double.parse(x);
          },
        ),
        _buildPercentageField(
          label: 'Individuals Using Internet',
          helperText: 'Individuals using Internet (% of population)',
          onSaved: (x) {
            controller.gdpInput.value.individualsUsingInternet =
                double.parse(x);
          },
        ),
      ],
    );
  }
}

class _BusinessDevelopmentSection extends GetWidget<PredictController> {
  const _BusinessDevelopmentSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildNumberField(
          label: 'Human Capital Index',
          helperText: 'Human Capital Index',
          onSaved: (x) {
            controller.gdpInput.value.humanCapitalIndex = double.parse(x);
          },
        ),
        _buildNumberField(
          label: 'Doing Business',
          helperText: 'Ease of doing business score',
          onSaved: (x) {
            controller.gdpInput.value.doingBusiness = double.parse(x);
          },
        ),
        _buildNumberField(
          label: 'Statistical Performance Indicators',
          helperText: 'Statistical Performance Indicators score',
          onSaved: (x) {
            controller.gdpInput.value.statisticalPerformanceIndicators =
                double.parse(x);
          },
        ),
        _buildNumberField(
          label: 'Logistic Performance Index',
          helperText: 'Logistics performance index',
          onSaved: (x) {
            controller.gdpInput.value.logisticPerformanceIndex =
                double.parse(x);
          },
        ),
      ],
    );
  }
}

class _DemographicsSocialSection extends GetWidget<PredictController> {
  const _DemographicsSocialSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildNumberField(
          label: 'Population Density',
          helperText: 'Population density (people per sq km)',
          onSaved: (x) {
            controller.gdpInput.value.populationDensity = double.parse(x);
          },
        ),
        _buildNumberField(
          label: 'Intentional Homicides',
          helperText: 'Intentional homicides per 100,000 people',
          onSaved: (x) {
            controller.gdpInput.value.intentionalHomicides = double.parse(x);
          },
        ),
        _buildPercentageField(
          label: 'Gini Index',
          helperText: 'Gini index (0-100)',
          onSaved: (x) {
            controller.gdpInput.value.giniIndex = double.parse(x);
          },
        ),
        _buildPercentageField(
          label: 'Multidimensional Poverty Headcount Ratio',
          helperText: 'Poverty headcount ratio (%)',
          onSaved: (x) {
            controller.gdpInput.value.multidimensionalPovertyHeadcountRatio =
                double.parse(x);
          },
        ),
      ],
    );
  }
}

class _GovernmentExpenditureSection extends GetWidget<PredictController> {
  const _GovernmentExpenditureSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildPercentageField(
          label: 'Military Expenditure',
          helperText: 'Military expenditure (% of GDP)',
          onSaved: (x) {
            controller.gdpInput.value.militaryExpenditure = double.parse(x);
          },
        ),
        _buildPercentageField(
          label: 'Government Expenditure on Education',
          helperText: 'Government expenditure on education (% of GDP)',
          onSaved: (x) {
            controller.gdpInput.value.governmentExpenditureOnEducation =
                double.parse(x);
          },
        ),
        _buildPercentageField(
          label: 'Government Health Expenditure',
          helperText: 'Government health expenditure (% of GDP)',
          onSaved: (x) {
            controller.gdpInput.value.governmentHealthExpenditure =
                double.parse(x);
          },
        ),
        _buildPercentageField(
          label: 'Research and Development Expenditure',
          helperText: 'R&D expenditure (% of GDP)',
          onSaved: (x) {
            controller.gdpInput.value.researchAndDevelopmentExpenditure =
                double.parse(x);
          },
        ),
      ],
    );
  }
}

class _BusinessEnvironmentSection extends GetWidget<PredictController> {
  const _BusinessEnvironmentSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildNumberField(
          label: 'Time to Get Operation License',
          helperText: 'Time required to get operation license (days)',
          onSaved: (x) {
            controller.gdpInput.value.timeToGetOperationLicense =
                double.parse(x);
          },
        ),
      ],
    );
  }
}

Widget _buildPercentageField({
  required String label,
  required String helperText,
  Function(dynamic)? onChanged,
  Function(dynamic)? onSaved,
}) {
  return _InputField(
    label: label,
    helperText: helperText,
    onChanged: onChanged,
    isPercentage: true,
    onSaved: onSaved,
  );
}

Widget _buildNumberField({
  required String label,
  required String helperText,
  Function(dynamic)? onChanged,
  Function(dynamic)? onSaved,
}) {
  return _InputField(
    label: label,
    helperText: helperText,
    onChanged: onChanged,
    onSaved: onSaved,
  );
}

// Add similar section widgets for:
// _EconomicIndicatorsSection
// _InfrastructureDevelopmentSection
// _BusinessDevelopmentSection
// _DemographicsSocialSection
// _GovernmentExpenditureSection
// _BusinessEnvironmentSection

// Utility widgets
class _InputField extends StatelessWidget {
  final String label;
  final String helperText;
  final String? suffixText;
  final Function(dynamic)? onChanged;
  final Function(dynamic)? onSaved;
  final bool isPercentage;

  const _InputField({
    required this.label,
    required this.helperText,
    this.suffixText,
    required this.onChanged,
    required this.onSaved,
    this.isPercentage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildLabel(text: label),
        TextFormField(
          decoration: _inputDecoration(
            helperText: helperText,
            suffixText: suffixText,
          ),
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'This field is required';
            }
            final number = double.tryParse(value);
            if (number == null) {
              return 'Please enter a valid number';
            }
            if (isPercentage && (number < 0 || number > 100)) {
              return 'Please enter a value between 0 and 100';
            }
            return null;
          },
          onChanged: onChanged,
          onSaved: onSaved,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

_buildLabel({
  required String text,
  bool loading = false,
  bool required = false,
}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
    child: Row(
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(width: 5),
        if (loading)
          const SizedBox(
            height: 10,
            width: 10,
            child: CircularProgressIndicator(
              color: Colors.grey,
              strokeWidth: 0.7,
            ),
          ),
        if (required)
          const Text(
            ' *',
            style: TextStyle(
              color: Colors.red,
            ),
          ),
      ],
    ),
  );
}

class LoadingDropdown<T> extends StatelessWidget {
  final String label;
  final String? helperText;
  final bool isLoading;
  final T? value;
  final List<T> items;
  final Function(T?) onChanged;
  final String Function(T) displayTextFor;
  final String? Function(T?)? validator;

  const LoadingDropdown({
    super.key,
    required this.label,
    this.helperText,
    required this.isLoading,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.displayTextFor,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildLabel(text: label, loading: isLoading),
        DropdownButtonFormField<T>(
          value: value,
          decoration: _inputDecoration(
            helperText: helperText,
          ),
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                displayTextFor(item),
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            );
          }).toList(),
          onChanged: isLoading ? null : onChanged,
          validator: validator,
          isExpanded: true,
        ),
      ],
    );
  }
}

// Input field decoration
InputDecoration _inputDecoration({
  String? helperText,
  String? suffixText,
}) =>
    InputDecoration(
      // filled: true,
      // fillColor: Colors.grey.withOpacity(0.1),
      helperText: helperText,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 5.0,
      ),
      suffixText: suffixText,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: AppColors.primary,
          width: 0.5,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 0.5,
        ),
      ),
    );
