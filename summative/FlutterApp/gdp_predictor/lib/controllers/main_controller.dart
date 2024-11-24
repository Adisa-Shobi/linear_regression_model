import 'package:gdp_predictor/utils/remote.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final ApiClient apiClient = ApiClient(
    baseUrl: 'https://linear-regression-model-4ns3.onrender.com',
  );
}
