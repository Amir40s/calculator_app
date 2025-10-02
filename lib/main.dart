import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

import 'config/routes/routes.dart';
import 'config/routes/routes_name.dart';
import 'config/theme/app_theme.dart';
import 'core/binding/app_binding.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          key: navigatorKey,
          title: 'UHCONST',
          // theme: AppTheme.lightTheme,
          // darkTheme: AppTheme.darkTheme,
          initialRoute: RoutesName.splash,
          initialBinding: AppBinding(),
          getPages: Routes.routes,
        );
      },
    );
  }
}
