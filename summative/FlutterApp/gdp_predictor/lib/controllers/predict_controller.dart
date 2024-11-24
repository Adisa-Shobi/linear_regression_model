import 'package:flutter/widgets.dart';
import 'package:gdp_predictor/controllers/main_controller.dart';
import 'package:gdp_predictor/models/gdp_model.dart';
import 'package:gdp_predictor/utils/snack_bar.dart';
import 'package:get/get.dart';

class PredictController extends GetxController {
  final MainController _mainController = Get.find();
  final RxList<String> countries = <String>[].obs;
  final RxBool countriesLoading = false.obs;
  final RxBool showPredict = false.obs;
  // Controller for the form
  final RxInt currentStep = 0.obs;
  final Rx<GDPInput> gdpInput = GDPInput().obs;

  // Step form keys
  final RxList<GlobalKey<FormState>> formKeys = <GlobalKey<FormState>>[
    GlobalKey<FormState>(), // Bas
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    getCountries();
  }

  void getCountries() async {
    countriesLoading.value = true;
    _mainController.apiClient.get('/countries', fromJson: (json) {
      final List<dynamic> countries = json['countries'];
      return countries.map((country) => country.toString()).toList();
    }).then((val) {
      if (val.data != null) {
        countries.addAll(val.data!);
      }
    }).whenComplete(() {
      countriesLoading.value = false;
    });
  }

  void submitForm() {
    final json = gdpInput.value.toJson();
    print(json);
    if (json.values.any((value) => value == null || value.toString().isEmpty)) {
      negativeMessage(message: 'Please fill all the fields');
    } else {
      positiveMessage(message: "Submitting form...");
      _mainController.apiClient
          .post(
        '/predict',
        body: json,
        fromJson: (val) => val['prediction']['log10_GDP_per_cap'],
      )
          .then((val) {
        if (val.data != null) {
          Get.toNamed('result', arguments: {
            'gdpInput': gdpInput.value,
            'logGdpPrediction': val.data,
          });
        }
      });
      print('Form submitted successfully');
    }
  }
}
