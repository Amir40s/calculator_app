import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  static final PrefService _instance = PrefService._internal();
  late final SharedPreferences _prefs;
  bool _isInitialized = false;

  factory PrefService() {
    return _instance;
  }

  PrefService._internal();

  Future<void> init() async {
    if (!_isInitialized) {
      _prefs = await SharedPreferences.getInstance();
      _isInitialized = true;
    }
  }

  static const String _newUserKey = 'isNewUser';
  static const String _themeKey = 'selectedTheme';

  Future<void> saveNewUserStatus(bool isNewUser) async {
    await _prefs.setBool(_newUserKey, isNewUser);
  }

  bool? loadNewUserStatus() {
    return _prefs.getBool(_newUserKey);
  }

  Future<void> saveTheme(String themePath) async {
    await _prefs.setString(_themeKey, themePath);
  }

  String? loadTheme() {
    return _prefs.getString(_themeKey);
  }
}
