import 'package:flutter/material.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';

class PricingTable extends StatelessWidget {
  const PricingTable({super.key});

  final List<Map<String, String>> data = const [
    {
      'material': 'Cement',
      'quantity': '1 Bags',
      'price': '500 Rs.',
    },
    {
      'material': 'Sand:',
      'quantity': '1000 ft3',
      'price': '2,000 Rs.',
    },
    {
      'material': 'Aggregate',
      'quantity': '1000 ft3',
      'price': '3000 Rs.',
    },
    {
      'material': 'Water',
      'quantity': '100 KL',
      'price': '300 Rs.',
    },
    {
      'material': 'Steel:',
      'quantity': '1 kg',
      'price': '125 Rs.',
    },
    {
      'material': 'Soil:',
      'quantity': '1000 Nos.',
      'price': '280 Rs.',
    },
    {
      'material': 'Block',
      'quantity': '1 ft3',
      'price': '390 Rs.',
    },
  ];

  // Cell padding for the content
  final EdgeInsets cellPadding = const EdgeInsets.symmetric(
    vertical: 16.0,
    horizontal: 8.0,
  );

  @override
  Widget build(BuildContext context) {
    // Determine column widths (flex factors)
    const int materialFlex = 3;
    const int quantityFlex = 2;
    const int priceFlex = 3;

    // A helper function to create a table cell
    Widget buildTableCell({
      required String text,
      required int flex,
      required TextStyle style,
      Color borderColor = Colors.black12,
      AlignmentGeometry alignment = Alignment.centerLeft,
    }) {
      return Expanded(
        flex: flex,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(color: borderColor, width: 1.0),
              bottom: BorderSide(color: borderColor, width: 1.0),
            ),
          ),
          padding: cellPadding,
          alignment: alignment,
          child: AppTextWidget(text:
            text,
            textStyle: style,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    final Widget header = Container(
      color: AppColors.blueColor,
      child: Row(
        children: [
          // Material Header
          buildTableCell(
            text: 'Material',
            flex: materialFlex,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            alignment: Alignment.center,
            borderColor: Colors.transparent,

          ),
          // Quantity Header
          buildTableCell(
            text: 'Quantity',
            flex: quantityFlex,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            borderColor: Colors.transparent,
            alignment: Alignment.center,
          ),
          Expanded(
            flex: priceFlex,
            child: Container(
              padding: cellPadding,
              alignment: Alignment.center,
              child: AppTextWidget(text:
                'Current Price',
               color: AppColors.whiteColor,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,

              ),
            ),
          ),
        ],
      ),
    );
    final List<Widget> bodyRows = data.map((item) {
      const TextStyle cellTextStyle = TextStyle(
        color: Colors.black,
        fontSize: 14,
      );

      return Row(
        children: [
          buildTableCell(
            text: item['material']!,
            flex: materialFlex,
            style: cellTextStyle,
            borderColor: Colors.black12,
            alignment: Alignment.center,
          ),
          buildTableCell(
            text: item['quantity']!,
            flex: quantityFlex,
            style: cellTextStyle,
            borderColor: Colors.black12,
            alignment: Alignment.center,
          ),
          Expanded(
            flex: priceFlex,
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.black12, width: 1.0),
                ),
              ),
              padding: cellPadding,
              alignment: Alignment.center,
              child: AppTextWidget(text:
                item['price']!,
                textStyle: cellTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
    }).toList();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12, width: 1.0),
      ),
      child: Column(
        children: [
          header,
          ...bodyRows,
        ],
      ),
    );
  }
}
