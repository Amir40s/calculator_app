// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:smart_construction_calculator/config/enum/style_type.dart';
// import 'package:smart_construction_calculator/config/res/app_color.dart';
// import 'package:smart_construction_calculator/config/res/app_icons.dart';
// import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
// import 'package:smart_construction_calculator/core/component/appbar_widget.dart';
//
// class NotificationScreen extends StatelessWidget {
//   const NotificationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(child: Column(
//         children: [
//           AppBarWidget(text: 'Notifications',showDivider: true,),
//           Padding(
//             padding:  EdgeInsets.symmetric(horizontal: 4.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               spacing: 20.px,
//               children: [
//                 SvgPicture.asset(AppIcons.noNotifications,height: 50.px,),
//                 AppTextWidget(text: 'No Notifications',styleType: StyleType.subTitle,),
//                 AppTextWidget(text: 'We’ll let you know when there will be something to update you.',styleType: StyleType.subTitle,color: AppColors.greyColor,),
//               ],
//             ),
//           ),
//         ],
//       )),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/res/app_icons.dart';
import 'package:smart_construction_calculator/core/component/appbar_widget.dart';

import '../../core/component/app_text_widget.dart';
import 'package:get/get.dart';

import '../../core/controller/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tabs Row
            AppBarWidget(text: "Notifications"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Row(
                  children: [
                    GestureDetector(
                      onTap: () => controller.changeTab(0),
                      child: Container(
                        decoration: BoxDecoration(
                          border: controller.selectedTabIndex.value == 0
                              ? const Border(
                              bottom:
                              BorderSide(color: Colors.amber, width: 2))
                              : null,
                        ),
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            AppTextWidget(
                              text: "All",
                              textStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: controller.selectedTabIndex.value == 0
                                    ? Colors.black
                                    : AppColors.greyColor,
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 6),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.greyColor.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: AppTextWidget(text:
                                "1",
                                textStyle: TextStyle(
                                  fontSize: 12
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () => controller.changeTab(1),
                      child: Container(
                        decoration: BoxDecoration(
                          border: controller.selectedTabIndex.value == 1
                              ? const Border(
                              bottom:
                              BorderSide(color: AppColors.premiumColor, width: 2))
                              : null,
                        ),
                        padding: const EdgeInsets.only(bottom: 4),
                        child: AppTextWidget(
                          text: "Unread",
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: controller.selectedTabIndex.value == 1
                                ? Colors.black
                                : AppColors.greyColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: AppTextWidget(text: 'Mark all as read',
                    textStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                )

              ],
            ),
            SizedBox(height: 2.h),

            // Notification List
            Expanded(
              child: Obx(() {
                final filtered = controller.selectedTabIndex.value == 0
                    ? controller.notifications
                    : controller.notifications
                    .where((n) => n['isUnread'] == true)
                    .toList();

                return ListView(
                  children: [
                    if (filtered
                        .any((n) => n['isYesterday'] == false)) ...[
                      ...filtered
                          .where((n) => n['isYesterday'] == false)
                          .map((n) => NotificationTile(
                        title: n['title'] as String,
                        subtitle: n['subtitle'] as String,
                        time: n['time'] as String,
                        isUnread: n['isUnread'] as bool,
                      ))
                          ,
                      SizedBox(height: 2.h),
                    ],
                    if (filtered.any((n) => n['isYesterday'] == true)) ...[
                      AppTextWidget(
                        text: "Yesterday",
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      ...filtered
                          .where((n) => n['isYesterday'] == true)
                          .map((n) => NotificationTile(
                        title: n['title'] as String,
                        subtitle: n['subtitle'] as String,
                        time: n['time'] as String,
                        isUnread: n['isUnread'] as bool,
                      ))
                          .toList(),
                    ],
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}


class NotificationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String time;
  final bool isUnread;

  const NotificationTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isUnread,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 1.h),
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: isUnread ? AppColors.baseColor : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: isUnread
                ? AppColors.blueColor
                : AppColors.baseColor,
            child: SvgPicture.asset(
              AppIcons.bell,
              color: isUnread ? Colors.white : Colors.grey.shade600,
            ),
          ),
          SizedBox(width: 3.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextWidget(
                  text: title,
                  textStyle: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 0.5.h),
                AppTextWidget(
                  text: subtitle,
                  textStyle: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppTextWidget(
                text: time,
                textStyle: TextStyle(color: Colors.grey.shade600, fontSize: 13),
              ),
              const SizedBox(height: 8),
              const Icon(Icons.more_horiz, size: 20, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }
}
