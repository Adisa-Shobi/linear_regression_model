import 'package:gdp_predictor/controllers/predict_controller.dart';
import 'package:get/get.dart';

class PredictBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => PredictController(),
    );
  }
}
