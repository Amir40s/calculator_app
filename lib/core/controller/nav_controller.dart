import 'package:get/get.dart';

import '../services/analytics_services.dart';

class NavController extends GetxController {
  var currentIndex = 0.obs;

  void changeScreen(int index) {
    currentIndex.value = index;
    // AppAnalyticsService.logScreenView(screenName: returnScreenName(index));
  }
  
  String returnScreenName(int index){
    switch(index){
      case 0:
        return "Home Screen";
      case 1:
        return "History Screen";
      case 2:
        return "Setting Screen";
      default:
        return  "Index Error";
    }
  }
  
}
