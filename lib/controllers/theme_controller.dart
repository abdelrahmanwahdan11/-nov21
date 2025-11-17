import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/utils/dummy_data.dart';

class ThemeController extends ChangeNotifier {
  ThemeController(this._prefs);

  final SharedPreferences _prefs;
  static const _keyDark = 'is_dark_mode';
  static const _keyPrimary = 'primary_color_hex';

  bool _isDark = false;
  Color _primaryColor = primaryChoices.first;

  ThemeMode get mode => _isDark ? ThemeMode.dark : ThemeMode.light;
  Color get primaryColor => _primaryColor;

  Future<void> load() async {
    _isDark = _prefs.getBool(_keyDark) ?? false;
    final hex = _prefs.getInt(_keyPrimary);
    if (hex != null) {
      _primaryColor = Color(hex);
    }
    notifyListeners();
  }

  Future<void> toggleDark(bool value) async {
    _isDark = value;
    await _prefs.setBool(_keyDark, value);
    notifyListeners();
  }

  Future<void> setPrimary(Color color) async {
    _primaryColor = color;
    await _prefs.setInt(_keyPrimary, color.value);
    notifyListeners();
  }
}
