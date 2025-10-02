import 'dart:ui';

import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/res/app_icons.dart';

import '../../config/model/calculator_category_model.dart';

class CategoryCalculatorController extends GetxController {
  var categories = <CalculatorCategory>[
    CalculatorCategory(
      title: "Conversion Calculator",
      icon: AppIcons.conversion,
      color: Color(0xffFAC7C7),
      items: [
        CalculatorItem(name: "Grey Structure BOQ Calculator", icon: AppIcons.greyStructureBoq, ),
        CalculatorItem(name: "Wood Calculator", icon:  AppIcons.woodCalculator),
        CalculatorItem(name: "Grey Structure Cost Calculator", icon: AppIcons.greyStructureBoq,),
        CalculatorItem(name: "Termite Treatment Cost Estimate", icon:  AppIcons.termiteTreat,),
        CalculatorItem(name: "Lean Concrete Calculator", icon:  AppIcons.concrete,),
        CalculatorItem(name: "Excavation Calculator", icon:  AppIcons.excavation,),
        CalculatorItem(name: "UGWT Excavation Calculator", icon:  AppIcons.ugwtExcavation,),
        CalculatorItem(name: "Plaster Calculator", icon:  AppIcons.plaster,),
      ],
    ),
    CalculatorCategory(
      title: "Construction Calculator",
      icon: AppIcons.construction,
      color: Color(0xfffff1e6),
      items: [
        CalculatorItem(name: "Plaster Calculator", icon:  AppIcons.greyStructureBoq,),
        CalculatorItem(name: "Plaster Calculator", icon:  AppIcons.greyStructureBoq,),
      ],
    ),
    CalculatorCategory(
      title: "Concrete Calculator",
      icon: AppIcons.concrete,
      color:  Color(0xffe6f4ff),
      items: [
        CalculatorItem(name: "Plaster Calculator", icon:  AppIcons.greyStructureBoq,),
        CalculatorItem(name: "Plaster Calculator", icon:  AppIcons.greyStructureBoq,),
      ],
    ),
  ].obs;
}