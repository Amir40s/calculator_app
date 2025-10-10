import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/chat_enum.dart';
import 'package:smart_construction_calculator/core/component/appbar_widget.dart';
import 'package:smart_construction_calculator/core/controller/app_policy_controller.dart';

class AppPolicies extends StatelessWidget {
  final AppPolicy policy;

  const AppPolicies({super.key, required this.policy});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppPolicyController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchPolicy(policy);
    });

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBarWidget(
              text: policy == AppPolicy.privacy
                  ? 'Privacy Policy'
                  : 'Terms & Conditions',
                  showDivider: true
            ),
            SizedBox(height: 2.h),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final policyData = controller.policy.value;
                if (policyData == null) {
                  return const Center(child: Text('No data available.'));
                }

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if ((policyData.createdAt ?? '').isNotEmpty)
                        Text(
                          "Created At: ${DateFormat('MMMM d, y, h:mm a').format(DateTime.parse(policyData.createdAt!))}",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey,
                          ),
                        ),
                      SizedBox(height: 1.5.h),
                      Text(
                        policyData.title ?? '',
                        style: TextStyle(
                            fontSize: 18.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        policyData.description ?? '',
                        style: TextStyle(fontSize: 16.sp, height: 1.5),
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
