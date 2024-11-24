import 'package:flutter/material.dart';
import 'package:gdp_predictor/models/gdp_model.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

import 'package:intl/intl.dart';

class GDPResultsPage extends GetView {
  final GDPInput gdpInput;
  final double logGdpPrediction;

  const GDPResultsPage({
    Key? key,
    required this.gdpInput,
    required this.logGdpPrediction,
  }) : super(key: key);

  double get actualGdpPrediction => math.pow(10, logGdpPrediction).toDouble();

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,##0.00", "en_US");
    final currencyFormatter = NumberFormat("#,##0", "en_US");

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade900,
              Colors.blue.shade800,
              Colors.blue.shade700,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top section with country name
              Expanded(
                flex: 2,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        gdpInput.country ?? 'Country',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 4,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // GDP Prediction Section
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Predicted GDP per Capita',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '\$',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            currencyFormatter.format(actualGdpPrediction),
                            style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Log₁₀ GDP: ${formatter.format(logGdpPrediction)}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Stats section
              Expanded(
                flex: 3,
                child: Container(
                  margin: const EdgeInsets.all(24),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatRow(
                        'Infrastructure Score',
                        '${((gdpInput.accessToElectricity ?? 0) + (gdpInput.individualsUsingInternet ?? 0)) / 2}%',
                      ),
                      _buildStatRow(
                        'Population Density',
                        '${formatter.format(gdpInput.populationDensity ?? 0)}',
                      ),
                      _buildStatRow(
                        'Development Index',
                        '${formatter.format(gdpInput.humanCapitalIndex ?? 0)}',
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom section with button
              Expanded(
                flex: 1,
                child: Center(
                  child: ElevatedButton.icon(
                    onPressed: () => Get.offAllNamed('/predict'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: Icon(Icons.arrow_back, color: Colors.blue.shade900),
                    label: Text(
                      'Back to Form',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white70,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
