import 'package:get/get.dart';

abstract class BaseCalculatorController<T> extends GetxController {
  var isLoading = false.obs;
  var data = Rxn<T>();

  void setData(T newData) {
    data.value = newData;
  }

  void setLoading(bool value) {
    isLoading.value = value;
  }
}
