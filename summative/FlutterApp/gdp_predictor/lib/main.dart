import 'package:flutter/material.dart';
import 'package:gdp_predictor/bindings/bindings.dart';
import 'package:gdp_predictor/controllers/main_controller.dart';
import 'package:gdp_predictor/utils/theme.dart';
import 'package:gdp_predictor/views/predict_view.dart';
import 'package:gdp_predictor/views/result_view.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/predict',
      theme: AppTheme.lightTheme,
      getPages: [
        GetPage(
          name: '/predict',
          page: () => const PredictView(),
          binding: PredictBindings(),
        ),
        GetPage(
          name: '/result',
          page: () => GDPResultsPage(
            gdpInput: Get.arguments['gdpInput'],
            logGdpPrediction: Get.arguments['logGdpPrediction'],
          ),
        ),
      ],
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => MainController());
      }),
    );
  }
}
