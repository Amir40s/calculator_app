import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/core/component/cost_estimation_widget.dart';
import '../../../core/controller/calculators/cost_estimation/grey_structure_controller.dart';

class GreyStructureConversionScreen extends StatelessWidget {
  final String itemName;
  GreyStructureConversionScreen({super.key, required this.itemName});

  final controller = Get.put(GreyStructureController());

  Widget _buildSectionTitle(String title, {IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          if (icon != null) Icon(icon, color: Colors.blueGrey),
          if (icon != null) const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyValueRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(key, style: const TextStyle(fontSize: 15)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Grey Structure Estimation")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            BuiltupAreaWidget(onChanged: controller.setBuiltupArea,),
            const SizedBox(height: 20),
            // 🔹 Button
            ElevatedButton.icon(
              onPressed: controller.fetchGreyStructureData,
              icon: const Icon(Icons.calculate),
              label: const Text('Calculate Now'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Result Section
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final data = controller.greyData.value;
                if (data == null) {
                  return const Center(
                      child: Text('Enter area and tap "Calculate Now"'));
                }

                final results = data.results;

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // =============================
                      //  1️⃣ Estimated Rate Section
                      // =============================
                      _buildSectionTitle(
                        "Estimated Rate per Square Foot",
                        icon: Icons.square_foot,
                      ),
                      Card(
                        color: Colors.blueGrey.shade50,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "PKR ${(results.totalCost / results.builtupArea).toStringAsFixed(2)} / sq.ft",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // =============================
                      //  2️⃣ Material Cost Breakdown
                      // =============================
                      _buildSectionTitle(
                        "Material Cost Breakdown",
                        icon: Icons.engineering,
                      ),
                      // Card(
                      //   elevation: 2,
                      //   child: Padding(
                      //     padding: const EdgeInsets.symmetric(vertical: 10),
                      //     child: Column(
                      //       children: [
                      //         _buildKeyValueRow(
                      //             "Excavation", "PKR ${results.toStringAsFixed(2)}"),
                      //         _buildKeyValueRow(
                      //             "Cement", "PKR ${results.cementCost.toStringAsFixed(2)}"),
                      //         _buildKeyValueRow(
                      //             "Sand", "PKR ${results.sandCost.toStringAsFixed(2)}"),
                      //         _buildKeyValueRow(
                      //             "Aggregate", "PKR ${results.aggregateCost.toStringAsFixed(2)}"),
                      //         _buildKeyValueRow(
                      //             "Water", "PKR ${results.waterCost.toStringAsFixed(2)}"),
                      //         _buildKeyValueRow(
                      //             "Steel", "PKR ${results.steelCost.toStringAsFixed(2)}"),
                      //         _buildKeyValueRow(
                      //             "Block", "PKR ${results.blockCost.toStringAsFixed(2)}"),
                      //         _buildKeyValueRow(
                      //             "Back Fill Material", "PKR ${results.backFillMaterialCost.toStringAsFixed(2)}"),
                      //         _buildKeyValueRow(
                      //             "Door Frame", "PKR ${results.doorFrameCost.toStringAsFixed(2)}"),
                      //         _buildKeyValueRow(
                      //             "Electrical Conduiting", "PKR ${results.electricalConduitingCost.toStringAsFixed(2)}"),
                      //         _buildKeyValueRow(
                      //             "Sewage", "PKR ${results.sewageCost.toStringAsFixed(2)}"),
                      //         _buildKeyValueRow(
                      //             "Miscellaneous", "PKR ${results.miscellaneousCost.toStringAsFixed(2)}"),
                      //         _buildKeyValueRow(
                      //             "Labor & Project Management", "PKR ${(results.laborCost + results.projectManagementCost).toStringAsFixed(2)}"),
                      //         const Divider(),
                      //         _buildKeyValueRow(
                      //           "Total Cost",
                      //           "PKR ${results.totalCost.toStringAsFixed(2)}",
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      const SizedBox(height: 20),

                      // =============================
                      //  3️⃣ Monthly Expense
                      // =============================
                      _buildSectionTitle(
                        "Monthly Expense Distribution",
                        icon: Icons.calendar_today,
                      ),
                      Card(
                        elevation: 2,
                        child: Table(
                          border: TableBorder.all(color: Colors.grey.shade300),
                          columnWidths: const {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(1),
                            2: FlexColumnWidth(2),
                          },
                          children: [
                            const TableRow(
                              decoration: BoxDecoration(color: Color(0xFFE0E0E0)),
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Period",
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Percent",
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Amount",
                                      style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            ...results.monthlyDistribution.map(
                                  (m) => TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(m.period),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("${m.percentage}%"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("PKR ${m.amount.toStringAsFixed(2)}"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // =============================
                      //  4️⃣ Quantity of Material Required
                      // =============================
                      _buildSectionTitle(
                        "Quantity of Material Required",
                        icon: Icons.inventory,
                      ),
                      Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            children: const [
                              // These are example values — API should return actual quantities
                              ListTile(
                                  dense: true,
                                  title: Text("Cement"),
                                  trailing: Text("10 Bags")),
                              ListTile(
                                  dense: true,
                                  title: Text("Sand"),
                                  trailing: Text("42 ft³")),
                              ListTile(
                                  dense: true,
                                  title: Text("Aggregate"),
                                  trailing: Text("31 ft³")),
                              ListTile(
                                  dense: true,
                                  title: Text("Water"),
                                  trailing: Text("1 KL")),
                              ListTile(
                                  dense: true,
                                  title: Text("Steel"),
                                  trailing: Text("98 kg")),
                              ListTile(
                                  dense: true,
                                  title: Text("Block"),
                                  trailing: Text("29 Units")),
                              ListTile(
                                  dense: true,
                                  title: Text("Back Fill Material"),
                                  trailing: Text("92 ft³")),
                              ListTile(
                                  dense: true,
                                  title: Text("Door Frame"),
                                  trailing: Text("0 Units")),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
