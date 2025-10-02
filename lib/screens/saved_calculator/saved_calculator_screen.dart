import 'package:flutter/material.dart';
import 'package:smart_construction_calculator/core/component/appbar_widget.dart';

class SavedCalculatorScreen extends StatelessWidget {
  const SavedCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        children: [
          AppBarWidget(text: 'Saved Calculators',showButton: false,centre: true,),


        ],
      )),
    );
  }
}
