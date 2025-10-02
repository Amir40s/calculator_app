import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/enum/style_type.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/res/app_icons.dart';
import 'package:smart_construction_calculator/core/component/app_text_widget.dart';
import 'package:smart_construction_calculator/core/component/appbar_widget.dart';
import 'package:smart_construction_calculator/core/component/smooth_container_widget.dart';
import 'package:smart_construction_calculator/screens/settings/chat_support/chat_support.dart';

import '../../../core/component/support_card_widget.dart';
import '../faq/faq_screen.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarWidget(text: 'Contact Us',showDivider: true,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w,),
            child: Column(
              children: [
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics:
                      NeverScrollableScrollPhysics(),
                  childAspectRatio: 0.86,
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 3.h,
                  children: [
                    SupportCard(
                      iconPath: AppIcons.chat,
                      title: "Support Chat",
                      subtitle: "24x7 Online Support",
                      color: Color(0xffEEF9F0),
                      onTap: () {
                        Get.to(ChatScreen());

                      },
                    ),
                    SupportCard(
                      iconPath: AppIcons.callCenter,
                      title: "Call Center",
                      subtitle: "24x7 Customer Service",
                      color: Color(0xffFFF0EA), onTap: () {

                      },
                    ),
                    SupportCard(
                      iconPath: AppIcons.contactMail,
                      title: "Email",
                      subtitle: "admin@unchost.com",
                      color: Color(0xffF5EEFC), onTap: () {

                      },
                    ),
                    SupportCard(
                      iconPath: AppIcons.faq,
                      title: "FAQ",
                      subtitle: "+50 Answers",
                      color: Color(0xffFFFBE8), onTap: () {
                        Get.to(FaqScreen());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
