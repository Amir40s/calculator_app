import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/core/component/app_button_widget.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/dynamic_table_widget.dart';
import 'package:smart_construction_calculator/core/component/two_fields_widget.dart';

import '../../../../core/component/app_text_field.dart';
import '../../../../core/component/dropdown_widget.dart';
import '../../../../core/controller/calculators/door_windows/door_boq_controller.dart';
import '../../../../core/controller/loader_controller.dart';

class DoorBoqScreen extends StatelessWidget {
  final String itemName;
   DoorBoqScreen({super.key, required this.itemName});
  final controller = Get.put(DoorBoqController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 1.h,
            children: [
              AppTextWidget(text: "Door BOQ Generator",styleType: StyleType.heading,),
              AppTextWidget(text: "Solid Wood Door",styleType: StyleType.subHeading,),
              buildRowWithField(
                heading: "Door Width",
                hint2: "Feet (ft)",
                itemsList: controller.measuringType,
                onChangedCallback: (val) {

                },
                selectedValue: controller.selectedLockType,
                controller: controller.noOfNetDoorsController,
              ),

              AppTextWidget(text: "Net Door",styleType: StyleType.subHeading,),
              TwoFieldsWidget(
                  heading1: "Number of Doors",
                  heading2: "Height (ft)",
                  controller1: controller.noOfSolidDoorsController,
                  controller2: controller.heightController),
              AppTextField(hintText: "Width (ft)",heading: "Width (ft)",controller: controller.widthController,),
              SizedBox(height: 2.h,),
              AppButtonWidget(text: "Calculate",width: 100.w,height: 5.h,onPressed: () {
                controller.convert();
              },),
              SizedBox(height: 2.h,),
              Obx(() {
                final result = controller.result.value;
                if (controller.isLoading.value) {
                  return Center(child: Loader());
                }
                if (result == null || result.solid.isEmpty || result.net.isEmpty) {
                  return AppTextWidget(text: "No BOQ results yet. Enter door details and click Generate BOQ",styleType: StyleType.subHeading,);
                }
                final solidRows = result.solid.expand((group) => group).map((item) {
                  return [item.name, item.unit, item.quantity];
                }).toList();

                final netRows = result.net.expand((group) => group).map((item) {
                  return [item.name, item.unit, item.quantity];
                }).toList();
                return Column(
                  spacing: 1.h,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppTextWidget(text: "Solid Wood Door",styleType: StyleType.heading,),
                    DynamicTable(headers: ["Description","Unit","Total Quantity"],
                        rows: solidRows,
                    ),
                    AppTextWidget(text: "Net Door",styleType: StyleType.heading,),
                    DynamicTable(headers: ["Description","Unit","Total Quantity"],
                      rows: netRows),
                  ]);
              }),
              SizedBox(height: 2.h,),


            ],
          ),
        ),
      ),
    );
  }
}
Row buildRowWithField({
  required TextEditingController controller,
  required RxString selectedValue,
  required RxList<String> itemsList,
  required String hint2,
  heading,
  required void Function(String) onChangedCallback,
}) {
  return Row(
    children: [
      Expanded(
        flex: 4,
        child: AppTextField(
          hintText: "0",
          heading: heading,
          controller: controller,
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        flex: 2,
        child: ReusableDropdown(
          selectedValue: selectedValue,
          itemsList: itemsList,
          hintText: hint2,
          alignWithTextFieldHeading: true,
          onChangedCallback: onChangedCallback,
        ),
      ),
    ],
  );
}