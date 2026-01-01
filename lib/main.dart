import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'package:smart_construction_calculator/config/res/app_color.dart';
import 'package:smart_construction_calculator/firebase_options.dart';
import 'config/routes/routes.dart';
import 'config/routes/routes_name.dart';
import 'core/binding/app_binding.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          key: navigatorKey,
          title: 'UHCONST',
          initialRoute: RoutesName.splash,
          initialBinding: AppBinding(),
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.scaffoldColor
          ),
          getPages: Routes.routes,
        );
      },
    );
  }
}
