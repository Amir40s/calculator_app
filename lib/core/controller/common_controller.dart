import 'package:get/get.dart';

import '../../config/model/faq_model.dart';
import '../../config/model/history_model.dart';
import '../services/analytics_services.dart';

class CommonController extends GetxController {

  var faqList = <FaqItem>[].obs;
  var contactFaqList = <FaqItem>[].obs;
  var sections = <FaqSection>[].obs;

  
  ///history screen 4 variables
  var todayList = <HistoryModel>[].obs;
  var weekList = <HistoryModel>[].obs;
  var monthList = <HistoryModel>[].obs;
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    faqList.value = [
      FaqItem(
        title: "How to contact with Support chat?",
        content: "Yes, you can delete history from settings safely.",
      ),
      FaqItem(
        title: "How to change my selected History?",
        content: "All your data is securely backed up in the cloud.",
      ),
      FaqItem(
        title: "What is cost of each Calculator?",
        content: "Go to settings and choose 'Reset Password' option.",
      ),
    ];
    contactFaqList.value = [
      FaqItem(
        title: "What is the used of Calculation?",
        content: "Yes, you can delete history from settings safely.",
      ),
      FaqItem(
        title: "Can I Delete a history?",
        content: "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium.",
      ),
      FaqItem(
        title: "How to call any service now?",
        content: "Go to settings and choose 'Reset Password' option.",
      ),
    ];
    sections.value = [
      FaqSection(title: "General", items: faqList),
      FaqSection(title: "Contact", items: contactFaqList),
    ];
    todayList.value = [
      HistoryModel(
        date: "Jun 6, 2025",
        time: "10:00 AM",
        title: "Conversion Calculator",
        amount: "14,828,858.80 Rs",
      ),
    ];

    weekList.value = [
      HistoryModel(
        date: "Jun 2, 2025",
        time: "02:00 PM",
        title: "Cement Calculator",
        amount: "2,345,600 Rs",
      ),
      HistoryModel(
        date: "May 30, 2025",
        time: "11:15 AM",
        title: "Steel Calculator",
        amount: "5,123,000 Rs",
      ),
    ];

    monthList.value = [
      HistoryModel(
        date: "May 5, 2025",
        time: "01:00 PM",
        title: "Sand Calculator",
        amount: "1,850,000 Rs",
      ),
    ];
  }
  void toggle(RxList<FaqItem> list, int index) {
    list[index].isVisible = !list[index].isVisible;
    list.refresh();
  }

  ///history screen

  void changeFilter(int index) {
    selectedIndex.value = index;
  }



}
