import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/utility/app_utils.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';

class DynamicTable extends StatelessWidget {
  final List<String> headers;
  final List<List<String>> rows;

  const DynamicTable({
    super.key,
    required this.headers,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'No data available',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔹 Header row
        Container(
          color: AppColors.blueColor,
          padding:  EdgeInsets.symmetric(vertical: 1.h, horizontal: 4.w),
          width: 100.w,
          child: Row(
            children: List.generate(headers.length, (index) {
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  child: AppTextWidget(
                    text: headers[index],
                    styleType: StyleType.subHeading,
                    color: AppColors.whiteColor,
                  ),
                ),
              );
            }),
          ),
        ),

        /// 🔹 Table body
        SizedBox(
          width: 100.w,
          child: Table(
            border: TableBorder.all(color: Colors.grey.shade400, width: 0.8),
            columnWidths: {
              for (int i = 0; i < headers.length; i++) i: const FlexColumnWidth(),
            },
            children: rows.map((row) {
              final safeRow = List<String>.from(
                row.length == headers.length
                    ? row
                    : [
                  ...row,
                  ...List.generate(headers.length - row.length, (_) => ''),
                ],
              );

              return TableRow(
                children: List.generate(safeRow.length, (index) {
                  final cell = safeRow[index];

                  final isUnitColumn = headers[index].toLowerCase() == 'unit';

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
                    child: AppTextWidget(
                      text: isUnitColumn ? AppUtils().formatUnit(cell) : cell,
                      styleType: StyleType.body,
                      color: AppColors.blackColor,
                    ),
                  );
                }),
              );
            }).toList(),
          ),
        )

      ],
    );
  }
}
