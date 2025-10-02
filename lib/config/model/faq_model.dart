import 'package:get/get.dart';

class FaqItem {
  final String title;
  final String content;
  bool isVisible;

  FaqItem({
    required this.title,
    required this.content,
    this.isVisible = false,
  });
}

class FaqSection {
  final String title;
  final RxList<FaqItem> items;

  FaqSection({required this.title, required this.items});
}
