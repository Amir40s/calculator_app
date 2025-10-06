import 'package:get/get.dart';

class NotificationController extends GetxController {
  var selectedTabIndex = 0.obs; // 0 = All, 1 = Unread

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  // Dummy notifications data
  final notifications = [
    {
      "title": "We have added a New Calculator for House Revue Calculate",
      "subtitle": "Click Here to Use the Calculator",
      "time": "2m",
      "isUnread": true,
      "isYesterday": false,
    },
    {
      "title": "We have added a New Calculator for House Revue Calculate",
      "subtitle": "Click Here to Use the Calculator",
      "time": "8h",
      "isUnread": false,
      "isYesterday": false,
    },
    {
      "title": "We have added a New Calculator for House Revue Calculate",
      "subtitle": "Click Here to Use the Calculator",
      "time": "1day",
      "isUnread": false,
      "isYesterday": true,
    },
  ];
}
