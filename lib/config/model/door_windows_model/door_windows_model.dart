import 'package:flutter/material.dart';

class DoorData {
  TextEditingController heightController;
  TextEditingController widthController;
  TextEditingController quantityController;

  DoorData()
      : heightController = TextEditingController(),
        widthController = TextEditingController(),
        quantityController = TextEditingController();
}