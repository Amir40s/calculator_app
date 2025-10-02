import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  var themeValue = 0.obs;
  RxInt selectedIndex =0.obs;
  var themeName = "System Default".obs;

  final List<String> themeList = [
    'System Default',
    'Light Theme',
    'Dark Theme',
  ];
  var themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    loadThemeFromPreferences();
  }

  void updateSelectedIndex(int index) {
    themeValue.value = index;
    switch (index) {
      case 0:
        themeMode.value = ThemeMode.system;
        themeName.value = "System Default";
        break;
      case 1:
        themeMode.value = ThemeMode.light;
        themeName.value = "Light Theme";
        break;
      case 2:
        themeMode.value = ThemeMode.dark;
        themeName.value = "Dark Theme";
        break;
    }

    saveThemeToPreferences();
  }

  Future<void> loadThemeFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('themeMode') ?? 'system';

    switch (savedTheme) {
      case 'light':
        themeMode.value = ThemeMode.light;
        themeValue.value = 1;
        themeName.value = "Light Theme";
        break;
      case 'dark':
        themeMode.value = ThemeMode.dark;
        themeValue.value = 2;
        themeName.value = "Dark Theme";
        break;
      case 'system':
      default:
        themeMode.value = ThemeMode.system;
        themeValue.value = 0;
        themeName.value = "System Default";
        break;
    }
  }

  Future<void> saveThemeToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    String mode;
    switch (themeMode.value) {
      case ThemeMode.light:
        mode = 'light';
        break;
      case ThemeMode.dark:
        mode = 'dark';
        break;
      case ThemeMode.system:
      default:
        mode = 'system';
        break;
    }
    await prefs.setString('themeMode', mode);
  }

  void clearInt() {
    themeValue.value = 0;
    themeMode.value = ThemeMode.system;
    themeName.value = "System Default";
    saveThemeToPreferences();
  }

  void toggleTheme() {
    if (themeMode.value == ThemeMode.light) {
      themeMode.value = ThemeMode.dark;
      themeValue.value = 2;
      themeName.value = "Dark Theme";
    } else {
      themeMode.value = ThemeMode.light;
      themeValue.value = 1;
      themeName.value = "Light Theme";
    }

    saveThemeToPreferences();
  }


  bool isLightTheme() {
    return themeMode.value == ThemeMode.light;
  }
}