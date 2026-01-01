import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smart_construction_calculator/config/res/app_assets.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/config/routes/routes_name.dart';
import 'package:smart_construction_calculator/config/utility/pref_service.dart';
import 'package:smart_construction_calculator/core/component/logo_text_widget.dart';
import 'package:smart_construction_calculator/core/controller/calculators/all_calculators.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PrefService _prefService = PrefService();
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await _prefService.init();
    await Future.delayed(const Duration(milliseconds: 3500));

    final bool? isNewUser = _prefService.loadNewUserStatus();
    final uid = FirebaseAuth.instance.currentUser;

    if (isNewUser == null || isNewUser == true) {
      _prefService.saveNewUserStatus(false);
      Get.offAllNamed(RoutesName.onboarding);
    } else {
      if (uid != null) {
        // User is already logged in: fetch calculators once on Splash for this app session.
        final calcC = Get.isRegistered<CalculatorController>()
            ? Get.find<CalculatorController>()
            : Get.put(CalculatorController(), permanent: true);
        // Don't await; let it load in background while we navigate.
        calcC.fetchCalculators();
        Get.offAllNamed(RoutesName.mainScreen);
      } else {
        Get.offAllNamed(RoutesName.onboarding);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(AppAssets.splash, fit: BoxFit.cover),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  LogoTextWidget(
                    color: AppColors.whiteColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
